//
//  CheckInResponse.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation

class CheckInResponse: NSObject {
    var result: String?
    var checkedAt: String?
    
    init(dictionary: [String : Any]) {
        super.init()
        dictionary.forEach { (atr) in
            self.setValue(atr.value, forKey: atr.key)
        }
    }
}
