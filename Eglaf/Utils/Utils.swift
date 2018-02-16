//
//  Utils.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation

enum State {
    case empty
    case loading
    case ready
    case error
}

struct Utils {
    
    public static func getMinutes(timestamp: String) -> Int {
        let createTime = Date(timeIntervalSince1970: TimeInterval(timestamp)!)
        let elapsedTime = NSDate().timeIntervalSince(createTime)
        
        return Int(elapsedTime/60)
    }
}
