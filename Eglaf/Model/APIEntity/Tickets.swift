//
//  Tickets.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation

class Tickets: NSObject {
    var lastStamp: String?
    var tickets: [String: Any]?
    
    init(dictionary: [String : Any]) {
        super.init()
        dictionary.forEach { (atr) in
            self.setValue(atr.value, forKey: atr.key)
        }
    }
}
