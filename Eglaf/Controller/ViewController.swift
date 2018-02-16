//
//  ViewController.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let apiEvent = EventAPIService(network: Network(), authHandler: nil)
    
    var tickets: Tickets?
    var state: State = .empty {
        didSet {
            if state != oldValue {
                //self.delegate?.changedState(state: state)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTickets()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTickets() {
        
        apiEvent.getTickets(eventId: "cc6c6fad-8047-4084-9aca-d7be1ee06c92eve").startWithResult { (result) in
            if case .success(let value) = result {
                if let data = value {
                    self.tickets = data
                    self.state = .ready
                } else {
                    self.state = .empty
                    print("--- No Data ----")
                }
            }
            
            if case .failure(let error) = result {
                self.state = .error
                print(error)
            }
        }
    
    }
}
