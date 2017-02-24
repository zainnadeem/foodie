//
//  Comment.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import Firebase

class Comment {
    var broadcastUID: String
    var uid: String
    var createdTime: String
    var fromUID: String
    var forUID: String
    var caption: String
    var ref: FIRDatabaseReference
    
    
    init(broadcastUID: String, fromUID: String, forUID: String, caption: String) {
        self.broadcastUID = broadcastUID
        self.fromUID = fromUID
        self.forUID = forUID
        self.caption = caption
        
        self.createdTime = Constants.dateFormatter().string(from: Date(timeIntervalSinceNow: 0))
        ref = DatabaseReference.users(uid: forUID).reference().child("\(broadcastUID)/comments")
        uid = ref.key
        
    }
    
    init(dictionary: [String : Any]) {
        broadcastUID = dictionary["broadcast UID"] as! String
        uid = dictionary["uid"] as! String
        fromUID = dictionary["from UID"] as! String
        forUID = dictionary["for UID"] as! String
        createdTime = dictionary["createdTime"] as! String
        caption = dictionary["caption"] as! String
        
        ref = DatabaseReference.users(uid: forUID).reference().child("\(broadcastUID)/comments")
    }
    
    func save(){
        ref.setValue(toDictionary())
    }
    
    func toDictionary() -> [String : Any]
    {
        return [
            "broadcast UID" : broadcastUID,
            "uid"  : uid,
            "from UID" : fromUID,
            "for UID" : forUID,
            "created time" : createdTime,
            "caption" : caption
        ]
    }
}

extension Comment : Equatable{ }

func == (lhs: Comment, rhs: Comment) -> Bool {
    return lhs.uid == rhs.uid
}


func sortByMostRecentlyCreated(_ arrayOfComments : [Comment]) -> [Comment] {
    
    var comments = arrayOfComments
    comments.sort(by: { return $0 > $1 })
    return comments
}


func >(lhs: Comment, rhs: Comment) -> Bool {
    
    let lhsComment = Constants.dateFormatter().date(from: lhs.createdTime)
    let rhsComment = Constants.dateFormatter().date(from: rhs.createdTime)
    
    return lhsComment?.compare(rhsComment!) == .orderedDescending ? true : false
}

func <(lhs: Comment, rhs: Comment) -> Bool {
    
    let lhsComment = Constants.dateFormatter().date(from: lhs.createdTime)
    let rhsComment = Constants.dateFormatter().date(from: rhs.createdTime)
    
    return lhsComment?.compare(rhsComment!) == .orderedDescending ? false : true
}

