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
        
        let user1 = User(uid: "", username: "Jenny1", fullName: "Jenny Cook", email: "jenny@cook.com", bio: "Awesome Woman Cook", website: "", location: "", follows: [], followedBy: [], profileImageURL: "https://firebasestorage.googleapis.com/v0/b/mamma-foodie.appspot.com/o/images%2Fwearing-apron-in-the-kitchen.jpg?alt=media&token=2c903cc7-f143-4bab-bdc5-9a48ebd50d2e", dishes: [], reviews: [], notifications: [], broadcasts: [], blockedUsers: [], cart: [], totalLikes: 0, averageRating: 2, deviceTokens: [], isAvailable: true, tags: ["Cookies, Soups, Pizza, Cake"], addresses: [])
       

        let user2 = User(uid: "", username: "greg1", fullName: "Greg Cook", email: "greg@cook.com", bio: "Awesome Man Cook", website: "", location: "", follows: [], followedBy: [], profileImageURL: "https://firebasestorage.googleapis.com/v0/b/mamma-foodie.appspot.com/o/images%2Fimages.jpg?alt=media&token=89af4243-8189-4039-949b-5047e5cc9602", dishes: [], reviews: [], notifications: [], broadcasts: [], blockedUsers: [], cart: [], totalLikes: 0, averageRating: 2, deviceTokens: [], isAvailable: false, tags: ["Panini, Pizza, Indian, Meatballs"], addresses: [])
        
        return [user1, user2]
        
    }
  
}
