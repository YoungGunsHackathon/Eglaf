//
//  Issue.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation

class Issue {
    
    var issueId: String?
    var creator: String? // USER_ID
    var description: String?
    var category: String?
    var urgent: Bool?
    var resolved: Bool?
    var solver: String? // USER_ID
    var location: String?

    init(id: String, dictionary: [String : Any]) {
        //super.init()

//        if let issueId = dictionary["issueId"] as? String {
//            self.issueId = issueId
//        }
        
        self.issueId = id

        if let creator = dictionary["creator"] as? String {
            self.creator = creator
        }

        if let description = dictionary["description"] as? String {
            self.description = description
        }
        
        if let category = dictionary["category"] as? String {
            self.category = category
        }

        if let urgent = dictionary["urgent"] as? Bool {
            self.urgent = urgent
        }
        
        if let resolved = dictionary["resolved"] as? Bool {
            self.resolved = resolved
        }
        
        if let solver = dictionary["solver"] as? String {
            self.solver = solver
        }
        
        if let location = dictionary["location"] as? String {
            self.location = location
        }
    }
}
