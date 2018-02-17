//
//  QRViewController.swift
//  Eglaf
//
//  Created by Zvada, Adam on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class QRViewController: UIViewController, StoryboardInit {
    
    //MARK: Properties
    
    var responseView: ResponseView? {
        willSet {
            if let resView = responseView {
                resView.removeFromSuperview()
            }
        }
    }
    var tickets: Tickets?
    let apiEvent = EventAPIService(network: Network(), authHandler: nil)
    var qrValue: String = "" {
        didSet {
            if qrValue != oldValue {
                getTicketIDFrom(qrString: qrValue)
            }
        }
    }
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView = UIView()
    
    
    @IBOutlet weak var opacityView: UIView!
    
    //MARK: Outlets
    //@IBOutlet weak var responseView: UIView!
    
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadTickets()
    }
    
    //MARK: Functions
    
    func downloadTickets() {
        apiEvent.getTickets(eventId: "cc6c6fad-8047-4084-9aca-d7be1ee06c92eve").startWithResult { (result) in
            if case .success(let value) = result {
                if let data = value {
                    self.tickets = data
                    self.initializeQR()
                    //self.state = .ready
                } else {
                    //self.state = .empty
                    print("--- No Data ----")
                }
            }
            
            if case .failure(let error) = result {
                //self.state = .error
                print(error)
            }
        }
    }
    
    func setCheckedTicket(eventId: String, ticketId: String, complition: @escaping (CheckInResponse) -> Void) {
        apiEvent.userCheckedAt(eventId: eventId, ticketId: ticketId).startWithResult { (result) in
            if case .success(let value) = result {
                if let data = value {
                    //self.state = .ready
                    complition(data)
                } else {
                    //self.state = .empty
                    print("--- No Data ----")
                }
            }
            
            if case .failure(let error) = result {
                //self.state = .error
                print(error)
            }
        }
    }
}

//MARK: - QRViewController (QR Init)
extension QRViewController {
    func initializeQR() {
        let captureDeviceOptional = AVCaptureDevice.default(for: AVMediaType.video)
        
        guard let captureDevice = captureDeviceOptional else {
            showOKAlert(message: "No input device available")
            initializeUI()
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch {
            showOKAlert(message: error.localizedDescription)
            return
        }
        
        //set QR capturing
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [.qr]
        
        //render the video on screen
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        captureSession.startRunning()
        initializeUI()
    }
    
    
}

//MARK: - QRViewController (UI)

extension QRViewController {
    func initializeUI() {
        qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView)
        view.bringSubview(toFront: qrCodeFrameView)
        //view.bringSubview(toFront: qrLabel)
        prepareNavBar()
    }
    
    func prepareNavBar() {
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0.1, blue: 0.22, alpha: 1)
        //self.navigationController?.view.backgroundColor = UIColor.red
        self.navigationItem.title = "TICKET SCAN"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Regular", size: 14)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.kern: 4
        ]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "people"), style: .plain, target: self, action: #selector(showGuests))
        
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.35, green:0.43, blue:0.52, alpha:1)
    }
    
    @objc func showGuests() {
        let guestVC = GuestViewController.storyboardInit()
        let navVC = UINavigationController(rootViewController: guestVC)
        self.present(navVC, animated: true, completion: nil)
    }
}

//MARK: - QRViewController (AVCaptureMetadataOutputObjectsDelegate)

extension QRViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else {
            qrCodeFrameView.frame = CGRect.zero
            //qrLabel.text = "No QR code is detected"
            return
        }

        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else {
            //qrLabel.text = "Can't scan unknown code"
            return
        }
        
        //Set green frame for recognized QR
        let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject)
        qrCodeFrameView.frame = barCodeObject!.bounds
        
        guard let qrString = metadataObject.stringValue else {
            //qrLabel.text = "QR contains no text"
            return
        }
        
        self.qrValue = qrString
        //getTicketIDFrom(qrString: qrString)
    }
}

//MARK: - QRViewController (QR Checking)

extension QRViewController {
    func getTicketIDFrom(qrString: String) {
        guard let url = URLComponents(string: qrString) else { return }
        let ticketID = url.queryItems?.first?.value
        //qrLabel.text = ticketID
        
        guard let ticketIDUnwrapped = ticketID else {
            //showOKAlert(message: "Unrelevant QR Code!")
            return
        }
        
        compareTicketID(ticketID: ticketIDUnwrapped)
    }
    
    func compareTicketID(ticketID: String) -> Bool {
        var matched = false
        
        for ticket in (tickets?.tickets)! {
            //print(ticket)
            if ticketID == ticket.ticketId {
                matched = true
                setCheckedTicket(eventId: "cc6c6fad-8047-4084-9aca-d7be1ee06c92eve", ticketId: ticketID, complition: { (checkInResponse) in
                    
                    self.showResponseView(isSucces: true, ticketName: ticket.name!)
                    
                })
            }
        }
        
        if !matched {
            self.showResponseView(isSucces: false, ticketName: "")
        }
        
        return matched
    }
    
    @objc func closeResponseView() {
        UIView.transition(with: self.view, duration: 0.4, options: [.transitionCrossDissolve], animations: {
            self.responseView!.removeFromSuperview()
            self.opacityView.isHidden = true
        }, completion: nil)
        
        self.qrValue = ""
    }
    
    func showResponseView(isSucces: Bool, ticketName: String) {
        
        let resView = ResponseView.instanceFromNib()
        resView.button.addTarget(self, action: #selector(closeResponseView), for: .touchUpInside)
        isSucces ? resView.conformResponse(name: ticketName) : resView.notConformResponse()
        resView.frame = CGRect(x: 0, y: 0, width: 240, height: 240)
        resView.center = CGPoint(x: self.view.frame.width / 2.0, y: self.view.frame.height / 2.0)
        resView.layer.cornerRadius = 43
        UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.opacityView.isHidden = false
            self.view.bringSubview(toFront: self.opacityView)
            self.view.addSubview(resView)
        }, completion: nil)
        
        self.responseView = resView
    }
}
