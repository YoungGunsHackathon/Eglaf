//
//  IssueHandler.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation

class IssueHandler {
    
    static let sharedInstance = IssueHandler()
    
    var dbProvider: DBProvider = DBProvider.sharedInstance
    
    
    func addIssue() {
        
    }
    
    func getIssue(issueId: String, completion: @escaping (Issue)->Void) {
        dbProvider.issueRef(issueId: issueId).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let issue = Issue(id: issueId ,dictionary: dictionary)
                completion(issue)
            }
        }
    }
    
    func observeIssues(completion: @escaping ([Issue]) -> Void) {
        dbProvider.issueRef.observe(.value) { (snapshot) in
            var issues: [Issue] = []
            
            if let dictionary = snapshot.value as? [String : Any] {
                for (key, value) in dictionary {
                    if let data = value as? [String : Any] {
                        let issue = Issue(id: key, dictionary: data)
                        issues.append(issue)
                    }
                }
            }
            completion(issues)
        }
    }
    
    func observeIssues(category: String, completion: @escaping ([Issue]) -> Void) {
        dbProvider.issueRef.observe(.value) { (snapshot) in
            var issues: [Issue] = []
            
            if let dictionary = snapshot.value as? [String : Any] {
                for (key, value) in dictionary {
                    if let data = value as? [String : Any] {
                        let issue = Issue(id: key, dictionary: data)
                        if issue.category == category {
                            issues.append(issue)
                        }
                    }
                }
            }
            completion(issues)
        }
    }
    
}
