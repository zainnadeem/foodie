//
//  Datastore.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/22/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import UIKit


class DataStore {
    
    static let sharedInstance = DataStore()
    var currentUser: User?
    
    
    func createDummyUsers() -> [User] {
        
        let user1 = User(uid: "", username: "Jenny1", fullName: "Jenny Cook", bio: "Awesome Woman Cook", website: "", location: "", follows: [], followedBy: [], profileImage: #imageLiteral(resourceName: "dummyImage1"), dishes: [], reviews: [], notifications: [], broadcasts: [], blockedUsers: [], totalLikes: 0, averageRating: 2, deviceTokens: [], isAvailable: true)
       

        let user2 = User(uid: "", username: "greg1", fullName: "Greg Cook", bio: "Awesome Man Cook", website: "", location: "", follows: [], followedBy: [], profileImage: #imageLiteral(resourceName: "dummyImage2"), dishes: [], reviews: [], notifications: [], broadcasts: [], blockedUsers: [], totalLikes: 0, averageRating: 2, deviceTokens: [], isAvailable: false)
        
        return [user1, user2]
        
    }
  
}
