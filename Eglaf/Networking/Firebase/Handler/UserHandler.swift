//
//  UserHandler.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation

class UserHandler {
    
    static let sharedInstance = UserHandler()
    
    var dbProvider: DBProvider = DBProvider.sharedInstance
    
    
    func addUser(user: User) {
        // TODO
    }
    
    func getUser(userId: String, completion: @escaping (User)->Void) {
        dbProvider.profileRef(UID: userId).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let user = User(id: userId ,dictionary: dictionary)
                completion(user)
            }
        }
    }
    
    func getUsers(userId: [String], completion: @escaping ([User])->Void) {
        // TODO
    }
    
    func getUserWithProfileImage(userId: String, completion: @escaping (User)->Void) {
        dbProvider.profileRef(UID: userId).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let user = User(id: userId ,dictionary: dictionary)
                completion(user)
            }
        }
    }
    
}
