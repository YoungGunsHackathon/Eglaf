//
//  Ticket.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation

class Ticket : NSObject {
    var ticketId: String?
    var name: String?
    var checkedAt: String?
    
    init(dictionary: [String : Any]) {
        super.init()

        if let ticketId = dictionary["tickeId"] as? String {
            self.ticketId = ticketId
        }

        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let checkedAt = dictionary["checkedAt"] as? String {
            self.checkedAt = checkedAt
        }
    }
}
