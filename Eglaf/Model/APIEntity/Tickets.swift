//
//  Tickets.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation

class Tickets: NSObject {
    var tickets: [Ticket]?
    var lastStamp: String?
    
    init(dictionary: [String : Any]) {
        super.init()
        
        if let tickets = dictionary["tickets"] as? [Ticket] {
            self.tickets = tickets
        }

        if let lastStamp = dictionary["lastStamp"] as? String {
            self.lastStamp = lastStamp
        }
    }
}
