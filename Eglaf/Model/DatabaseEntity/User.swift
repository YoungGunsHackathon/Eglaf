//
//  User.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation

class User {
    var userId: String?
    var firstName: String?
    var lastname: String?
    var pictureUrl: String?
    
    init(dictionary: [String : Any]) {
        //super.init()
        
        if let userId = dictionary["userId"] as? String {
            self.userId = userId
        }
        
        if let firstName = dictionary["firstName"] as? String {
            self.firstName = firstName
        }
        
        if let lastname = dictionary["lastname"] as? String {
            self.lastname = lastname
        }
        
        if let pictureUrl = dictionary["pictureUrl"] as? String {
            self.pictureUrl = pictureUrl
        }
    }
}
