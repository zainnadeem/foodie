//
//  Datastore.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/22/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class DataStore {
    
    static let sharedInstance = DataStore()

    var currentUser = User()
    
    func getCurrentUserWithToken(token: String,_ completion: @escaping () -> Void){
        
        DatabaseReference.tokens(token: token).reference().observeSingleEvent(of: .value, with: { (snapshot) in
            if let uid = snapshot.value {
                self.getCurrentUserWithUID(uid: uid as! String, {
                   completion()
                })
            }
            
        })
        
    }
    
    func getCurrentUserWithUID(uid: String,_ completion: @escaping () -> Void){
        
        DatabaseReference.users(uid: uid).reference().observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDict = snapshot.value as? [String : Any] {
                    self.currentUser = User(dictionary: userDict)
                    completion()
            }
            
        })
        
    }
    
    
    func createDummyUsers() -> [User] {
        
        let user1 = User(uid: "", username: "Jenny1", fullName: "Jenny Cook", email: "jenny@cook.com", bio: "Awesome Woman Cook", website: "", location: "", follows: [], followedBy: [], profileImageURL: "", dishes: [], reviews: [], notifications: [], broadcasts: [], blockedUsers: [], totalLikes: 0, averageRating: 2, deviceTokens: [], isAvailable: true, tags: ["Cookies, Soups, Pizza, Cake"], addresses: [])
       

        let user2 = User(uid: "", username: "greg1", fullName: "Greg Cook", email: "greg@cook.com", bio: "Awesome Man Cook", website: "", location: "", follows: [], followedBy: [], profileImageURL: "", dishes: [], reviews: [], notifications: [], broadcasts: [], blockedUsers: [], totalLikes: 0, averageRating: 2, deviceTokens: [], isAvailable: false, tags: ["Panini, Pizza, Indian, Meatballs"], addresses: [])
        
        return [user1, user2]
        
    }
  
}
