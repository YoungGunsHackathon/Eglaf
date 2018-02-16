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
    
    var tickets: Tickets?
    let apiEvent = EventAPIService(network: Network(), authHandler: nil)
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView = UIView()
    
    //MARK: Outlets
    
    @IBOutlet weak var qrLabel: UILabel!
    
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
        view.bringSubview(toFront: qrLabel)
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "people"), style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.35, green:0.43, blue:0.52, alpha:1)
    }
}

//MARK: - QRViewController (AVCaptureMetadataOutputObjectsDelegate)

extension QRViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else {
            qrCodeFrameView.frame = CGRect.zero
            qrLabel.text = "No QR code is detected"
            return
        }

        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else {
            qrLabel.text = "Can't scan unknown code"
            return
        }
        
        //Set green frame for recognized QR
        let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject)
        qrCodeFrameView.frame = barCodeObject!.bounds
        
        guard let qrString = metadataObject.stringValue else {
            qrLabel.text = "QR contains no text"
            return
        }

        getTicketIDFrom(qrString: qrString)
    }
}

//MARK: - QRViewController (QR Checking)

extension QRViewController {
    func getTicketIDFrom(qrString: String) {
        guard let url = URLComponents(string: qrString) else { return }
        let ticketID = url.queryItems?.first?.value
        qrLabel.text = ticketID
        guard let ticketIDUnwrapped = ticketID else {
            showOKAlert(message: "Unrelevant QR Code!")
            return
        }
        showTicketConfirmation(ticketID: ticketIDUnwrapped)
    }
    func showTicketConfirmation(ticketID: String) {
        if compareTicketID(ticketID: ticketID) {
            showOKAlert(message: "JE TAM BRASKO")
        } else {
            showOKAlert(message: "BOHUZEL NIKDO NENI")
        }
    }
    func compareTicketID(ticketID: String) -> Bool {
        var matched = false
//        print("----------------------")
//        print(tickets)
//        for ticket in (tickets?.tickets)! {
//            print(ticket)
//            if ticketID == ticket.ticketId {
//                matched = true
//            }
//        }
        return false
    }
}
