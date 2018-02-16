//
//  DBProvider.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage


class DBProvider {
    
    static let sharedInstance = DBProvider()

    var dbRef : DatabaseReference {
        return Database.database().reference(fromURL: Constants.DB_URL)
    }
    
    var userRef : DatabaseReference {
        return dbRef.child(Constants.DatabaseEntities.USER)
    }
    
    var issueRef : DatabaseReference {
        return dbRef.child(Constants.DatabaseEntities.ISSUE)
    }
    
    var storageRef : StorageReference {
        return Storage.storage().reference(forURL: Constants.STORAGE_URL)
    }
    
    func profileRef(UID: String) -> DatabaseReference {
        //return userRef.child(UID)
        return dbRef.child("users").child("user-hash1")
    }
    
    
    
}
