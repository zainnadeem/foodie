//
//  User.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/22/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import Firebase

class User
    
{
    // MARK: - User Properties
    
    let uid                             :           String
    var username                        :           String
    var fullName                        :           String
    var bio                             :           String
    var website                         :           String
    var location                        :           String
    var profileImage                    :           UIImage?
    
    var dishes                          :           [Dish]
    var follows                         :           [User]
    var followedBy                      :           [User]
    var reviews                         :           [Review]
    var notifications                   :           [Notification]
    var broadcasts                      :           [Broadcast]
    var blockedUsers                    :           [User]
    
    var totalLikes                      :           Int
    var averageRating                   :           Int
    var deviceTokens                    :           [String]
    var isAvailable                     :           Bool
    
    
    // MARK: - Initializers
    
    init(uid: String, username: String, fullName: String, bio: String, website: String, location: String, follows: [User], followedBy: [User], profileImage: UIImage?, dishes: [Dish], reviews: [Review], notifications: [Notification], broadcasts: [Broadcast], blockedUsers: [User], totalLikes: Int, averageRating: Int, deviceTokens: [String], isAvailable: Bool)
    {
        self.uid = uid
        self.username = username
        self.fullName = fullName
        self.bio = bio
        self.website = website
        self.location = location
        self.follows = follows
        self.followedBy = followedBy
        self.profileImage = profileImage
        self.dishes = dishes
        self.reviews = reviews
        self.notifications = notifications
        self.broadcasts = broadcasts
        self.totalLikes = totalLikes
        self.blockedUsers = blockedUsers
        self.averageRating = averageRating
        self.deviceTokens = deviceTokens
        self.isAvailable = isAvailable
    }
    
    init() {
        self.uid = ""
        self.username = ""
        self.fullName = ""
        self.bio = ""
        self.website = ""
        self.location = ""
        self.follows = []
        self.followedBy = []
        self.profileImage = UIImage()
        self.dishes = []
        self.reviews = []
        self.notifications = []
        self.broadcasts = []
        self.totalLikes = 0
        self.blockedUsers = []
        self.averageRating = 0
        self.deviceTokens = []
        self.isAvailable = false
    }
    
    init(dictionary: [String : Any])
    {
        uid = dictionary["uid"] as! String
        username = dictionary["username"] as! String
        fullName = dictionary["fullName"] as! String
        bio = dictionary["bio"] as! String
        website = dictionary["website"] as! String
        location = dictionary["location"] as! String
        
        averageRating = dictionary["average rating"] as! Int
        totalLikes = dictionary["total likes"] as! Int
        isAvailable = dictionary["is available"] as! Bool
        
        // deviceToken: created for notifications
        self.deviceTokens = []
        if let deviceTokDict = dictionary["device tokens"] as? [String]
        {
            for device in deviceTokDict{
                self.deviceTokens.append(device)
            }
        }
        
        
        // follows
        self.follows = []
        if let followsDict = dictionary["follows"] as? [String : Any] {
            for (_, userDict) in followsDict {
                if let userDict = userDict as? [String : Any] {
                    self.follows.append(User(dictionary: userDict))
                }
            }
        }
        
        // followedBy
        followedBy = []
        if let followedByDict = dictionary["followed by"] as? [String : Any] {
            for (_, userDict) in followedByDict {
                if let userDict = userDict as? [String : Any] {
                    self.followedBy.append(User(dictionary: userDict))
                }
            }
        }
        
        self.blockedUsers = []
        if let followedByDict = dictionary["blocked users"] as? [String : Any] {
            for (_, userDict) in followedByDict {
                if let userDict = userDict as? [String : Any] {
                    self.blockedUsers.append(User(dictionary: userDict))
                }
            }
        }
        
        // notifications
        self.notifications = []
        if let notificationsDict = dictionary["notifications"] as? [String : Any]
        {
            for (_, notificationDict) in notificationsDict {
                if let notificationDict = notificationDict as? [String : Any] {
                    self.notifications.append(Notification(dictionary: notificationDict))
                }
            }
        }
        
        // dishes
        self.dishes = []
        if let dishesDict = dictionary["dishes"] as? [String : Any]
        {
            for (_, dishDict) in dishesDict {
                if let dishDict = dishDict as? [String : Any] {
                    self.dishes.append(Dish(dictionary: dishDict))
                }
            }
        }
        
        // reviews
        self.reviews = []
        if let reviewsDict = dictionary["reviews"] as? [String : Any]
        {
            for (_, reviewDict) in reviewsDict {
                if let reviewDict = reviewDict as? [String : Any] {
                    self.reviews.append(Review(dictionary: reviewDict))
                }
            }
        }
        
        //broadcasts
        self.broadcasts = []
        if let broadcastsDict = dictionary["broadcasts"] as? [String : Any]
        {
            for (_, broadcastDict) in broadcastsDict {
                if let broadcastDict = broadcastDict as? [String : Any] {
                   // self.broadcasts.append(Broadcast(dictionary: broadcastDict))
                }
            }
        }
        
    }
    
    
    func toDictionary() -> [String : Any] {
        return [
            "uid" : uid,
            "username" : username,
            "fullName" : fullName,
            "bio" : bio,
            "website" : website
        ]
    }
}

extension User {
    
    func share(dish: Dish) {
        DatabaseReference.users(uid: uid).reference().child("dishes").childByAutoId().setValue(dish.toDictionary)
    }
    
    func downloadProfilePicture(completion: @escaping (UIImage?, NSError?) -> Void)
    {
        FIRImage.downloadProfileImage(uid, completion: { (image, error) in
            self.profileImage = image
            completion(image, error as NSError?)
        })
    }
    
    func follow(user: User) {
        self.follows.append(user)
        let ref = DatabaseReference.users(uid: uid).reference().child("follows/\(user.uid)")
        
        ref.setValue(user.toDictionary())
    }
    
    func isFollowedBy(_ user: User) {
        self.followedBy.append(user)
        let ref = DatabaseReference.users(uid: uid).reference()
        ref.child("followed by/\(user.uid)").setValue(user.toDictionary())
    }
    
}
