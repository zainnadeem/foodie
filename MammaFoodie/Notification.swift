//
//  Notification.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/22/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import UIKit
import Firebase

enum NotificationType: String {
    //user liked dish
    case likedDish = "liked your dish!"
    
    //user starting following
    case following = "started following you!"
    
    //user reviewed a chef
    case reviewed = "left you a review!"
    
    //a chef that the user follows is having a upcoming broadcast
    case upcomingBroadcast = "has an upcoming broadcast, tune in!"
}

class Notification{
    
    var uid                                 :                          String
    var createdTime                         :                          String
    
    var notificationCreatedByUID            :                          String
    var notificationForUID                  :                          String
    
    var notificationType                    :                          NotificationType
    var caption                             :                          String
    
    var ref                                 :                          FIRDatabaseReference
    
    
    init(notificationCreatedByUID: String, notificationForUID: String, notificationType: NotificationType, caption: String) {
        self.notificationCreatedByUID = notificationCreatedByUID
        self.notificationForUID = notificationForUID
        
        self.notificationType = notificationType
        self.caption = caption
        
        self.createdTime = Constants.dateFormatter().string(from: Date(timeIntervalSinceNow: 0))
        
        ref = DatabaseReference.users(uid: notificationForUID).reference().child("notifications").childByAutoId()
        uid = ref.key
        
    }
    
    init(dictionary: [String : Any]) {
        
        uid = dictionary["uid"] as! String
        createdTime = dictionary["created time"] as! String
        
        caption = dictionary["caption"] as! String
        notificationType = NotificationType(rawValue: dictionary["notification type"] as! String)!
        
        notificationCreatedByUID  = dictionary["notification created by UID"] as! String
        notificationForUID  = dictionary["notification for UID"] as! String
        
        ref = DatabaseReference.users(uid: uid).reference().child("notifications/\(uid)")
    }
    
    func save(){
        ref.setValue(toDictionary())
        
    }
    
    func toDictionary() -> [String : Any]
    {
        return [
            "uid" : uid,
            "created time"  : createdTime,
            "uid" : uid,
            "notification type" : notificationType.rawValue,
            "notification for UID" : notificationForUID,
            "notification created by UID" : notificationCreatedByUID,
        ]
    }
    
    
}


extension Notification : Equatable{ }

func == (lhs: Notification, rhs: Notification) -> Bool {
    return lhs.uid == rhs.uid
}


func sortByMostRecentlyCreated(_ arrayOfNotifications : [Notification]) -> [Notification] {
    
    var notification = arrayOfNotifications
    notification.sort(by: { return $0 > $1 })
    return notification
}

func >(lhs: Notification, rhs: Notification) -> Bool {
    
    let lhsNotification = Constants.dateFormatter().date(from: lhs.createdTime)
    let rhsNotification = Constants.dateFormatter().date(from: rhs.createdTime)
    
    return lhsNotification?.compare(rhsNotification!) == .orderedDescending ? true : false
}

func <(lhs: Notification, rhs: Notification) -> Bool {
    
    let lhsNotification = Constants.dateFormatter().date(from: lhs.createdTime)
    let rhsNotification = Constants.dateFormatter().date(from: rhs.createdTime)
    
    return lhsNotification?.compare(rhsNotification!) == .orderedDescending ? false : true
}






