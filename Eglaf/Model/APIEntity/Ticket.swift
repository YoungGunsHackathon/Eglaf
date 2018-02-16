//
//  Ticket.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation

class Ticket : NSObject {
    var id: String?
    var name: String?
    var checkedAt: String?
    
    init(dictionary: [String : Any]) {
        super.init()
        dictionary.forEach { (atr) in
            self.setValue(atr.value, forKey: atr.key)
        }
    }
}
