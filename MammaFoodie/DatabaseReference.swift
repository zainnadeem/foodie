//
//  Firebase.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/22/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.

import Foundation
import Firebase

enum DatabaseReference {
    
    case root
    case users(uid: String)
    case allUsers
    case dimes
    case chats
    case messages
    
    // MARK: - Public
    
    func reference() -> FIRDatabaseReference {
        return rootRef.child(path)
    }
    
    private var rootRef: FIRDatabaseReference{
        return FIRDatabase.database().reference()
    }
    
    private var path: String{
        switch self {
        case .root:
            return ""
        case .users(let uid):
            return "users/\(uid)"
        case .allUsers:
            return "users"
        default:
            return "default"
            
        }
    }
}


enum StorageReference {
    case root
    case images //for dishes
    case profileImages //for user
    
    func reference() -> FIRStorageReference{
        return baseRef.child(path)
    }
    
    private var baseRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    private var path: String {
        switch self {
        case .root:
            return ""
        case .images:
            return "images"
        case .profileImages:
            return "profileImages"
        }
    }
}
