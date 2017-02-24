//
//  Broadcast.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/22/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import Firebase

class Broadcast{
    
    var uid                                 :                          String

    //title of the broadcast
    var title                               :                          String
    
    // comments should be real time on the live feed
    var comments                            :                          [Comment]

    
    // users should be able to press the like button as many times as they want, this number should update on the live video feed
    var likes                               :                           Int
    
    //when the user hits the "create" button
    var createdTime                         :                          String
    
    //scheduled time, when the user is expected to go live
    var scheduledTime                       :                          String
    
    //anytime a user enters the chat
    var numberOfViews                       :                           Int

    //Url to see the live feed
    var feedURL                             :                           URL?
    
    //users currently in wathcing the live video feed
    var usersWatching                       :                           [User]
    
    //if cook is offering a dish
    var offeredDish                         :                           Dish?
    
    //claimed dishes 
    var claimedDishes                       :                           Int?
    
    //dishes available
    var dishesAvailable                     :                           Int?
    
    //user
    var userUID                             :                           String
    
    //
    var ref                                 :                           FIRDatabaseReference
    
    
    init(title: String, scheduledTime: String, userUID: String){
        self.userUID = userUID
        self.title = title
        self.scheduledTime = scheduledTime
        self.createdTime = Constants.dateFormatter().string(from: Date(timeIntervalSinceNow: 0))
        self.numberOfViews = 0
        self.likes = 0
        self.claimedDishes = 0
        self.dishesAvailable = 0
        self.comments = []
        self.usersWatching = []
        
        ref = DatabaseReference.users(uid: userUID).reference().child("broadcasts").childByAutoId()
        uid = ref.key
        
        
    }
    
//    init(dictionary: [String : Any]){
//        
//        uid = dictionary["uid"] as! String
//        userUID = dictionary["userUID"] as! String
//        createdTime = dictionary["created time"] as! String
//        title = dictionary["title"] as! String
//        scheduledTime = dictionary["scheduled time"] as! String
//        createdTime = dictionary["created time"] as! String
//        numberOfViews = dictionary["number of views"] as! Int
//       
//        usersWatching = []
//        if let usersDict = dictionary["users watching"] as? [String : Any] {
//            for (_, userDict) in usersDict {
//                if let userDict = userDict as? [String: Any] {
//                    usersWatching.append(User(dictionary: userDict))
//                }
//            }
//        }
//        
//        if let feed = dictionary["feed url"] as? URL {
//            feedURL = feed
//        }
//        
//        if let dish = dictionary["offered dish"] as? [String : Any]  {
//            offeredDish = dish
//        }
//
//    }
    
    
}
