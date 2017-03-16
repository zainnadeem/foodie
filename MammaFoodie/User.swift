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
    
    var uid                             :           String
    var username                        :           String
    var fullName                        :           String
    var email                           :           String
    var bio                             :           String
    var website                         :           String
    var location                        :           String
    var tags                            :           [String]
    var profileImageURL                 :           String
    
    var addresses                       :           [Address]
    
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
    
    var tagsString                      : String {
        
        var string = ""
        
        for (index, tag) in self.tags.enumerated() {
            if index == self.tags.count - 1 { string += "\(tag)" }
            else { string += "\(tag), " }
        }
        
        return string
    }
    
    
    
    // MARK: - Initializers
    
    init(uid: String, username: String, fullName: String, email: String, bio: String, website: String, location: String, follows: [User], followedBy: [User], profileImageURL: String, dishes: [Dish], reviews: [Review], notifications: [Notification], broadcasts: [Broadcast], blockedUsers: [User], totalLikes: Int, averageRating: Int, deviceTokens: [String], isAvailable: Bool, tags: [String], addresses: [Address])
    {
        self.uid = uid
        self.username = username
        self.fullName = fullName
        self.email = email
        self.bio = bio
        self.website = website
        self.location = location
        self.follows = follows
        self.followedBy = followedBy
        self.profileImageURL = profileImageURL
        self.dishes = dishes
        self.reviews = reviews
        self.notifications = notifications
        self.broadcasts = broadcasts
        self.totalLikes = totalLikes
        self.blockedUsers = blockedUsers
        self.averageRating = averageRating
        self.deviceTokens = deviceTokens
        self.isAvailable = isAvailable
        self.tags = tags
        self.addresses = addresses
    }
    
    convenience init(uid: String, username: String, fullName: String, email: String, profileImageURL: String) {
        self.init()
        self.uid = uid
        self.username = username
        self.fullName = fullName
        self.email = email
        self.profileImageURL = profileImageURL
    }
    
    init() {
        self.uid = ""
        self.username = ""
        self.fullName = ""
        self.email = ""
        self.bio = ""
        self.website = ""
        self.location = ""
        self.follows = []
        self.followedBy = []
        self.profileImageURL = ""
        self.dishes = []
        self.reviews = []
        self.notifications = []
        self.broadcasts = []
        self.totalLikes = 0
        self.blockedUsers = []
        self.averageRating = 0
        self.deviceTokens = []
        self.isAvailable = false
        self.tags = [""]
        self.addresses = []
    }
    
    init(dictionary: [String : Any])
    {
        uid = dictionary["uid"] as! String
        username = dictionary["username"] as! String
        fullName = dictionary["fullName"] as! String
        email = dictionary["email"] as! String
        bio = dictionary["bio"] as! String
        website = dictionary["website"] as! String
        location = dictionary["location"] as! String
        profileImageURL = dictionary["profile image URL"] as! String
        
        averageRating = dictionary["average rating"] as! Int
        totalLikes = dictionary["total likes"] as! Int
        isAvailable = dictionary["is available"] as! Bool
        tags = dictionary["tags"] as! [String]
        
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
        
        //Addresses
        self.addresses = []
        if let addressesDict = dictionary["addresses"] as? [String : Any]
        {
            for (_, addressDict) in addressesDict {
                if let addressDict = addressDict as? [String : Any] {
                    self.addresses.append(Address(dictionary: addressDict))
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
            "uid"             : uid,
            "username"        : username,
            "fullName"        : fullName,
            "location"        : location,
            "email"           : email,
            "tags"            : tags,
            "bio"             : bio,
            "website"         : website,
            "profile image URL" : profileImageURL,
            "average rating"  : averageRating,
            "total likes"     : totalLikes,
            "is available"    : isAvailable
            
            
        ]
    }
}

extension User {
    
    func share(dish: Dish) {
        DatabaseReference.users(uid: uid).reference().child("dishes").childByAutoId().setValue(dish.toDictionary)
    }
    
//    func downloadProfilePicture(completion: @escaping (UIImage?, NSError?) -> Void)
//    {
//        FIRImage.downloadProfileImage(uid, completion: { (image, error) in
//            self.profileImageURL = image
//            completion(image, error as NSError?)
//        })
//    }
    
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
    
    
    
    func updateUserInfo(){
        DatabaseReference.users(uid: uid).reference().updateChildValues(self.toDictionary())
        //save other user data
        
    }

    
}




