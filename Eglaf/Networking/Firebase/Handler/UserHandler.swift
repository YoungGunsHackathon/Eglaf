//
//  UserHandler.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

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
    
    func createStorageForProfileImage(image: UIImage, completion: @escaping (URL) -> Void) {
        let storageRef = dbProvider.storageRef.child("\(NSUUID().uuidString).png")
        
        if let uploadData = UIImageJPEGRepresentation(image, 0.1) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let myMetaData = metadata {
                    print("Succes of image store.")
                    print(myMetaData)
                    
                    completion(myMetaData.downloadURL()!)
                }
            })
        }
    }
}
