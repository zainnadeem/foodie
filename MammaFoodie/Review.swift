//
//  Reviews.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/22/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import Firebase

class Review {
    
    var uid                              :          String
    var description                      :          String
    var rating                           :          Int
    
    var reviewCreatedByUID               :          String
    var reviewForUID                     :          String
    
    var createdTime                      :          String
    var ref                              :          FIRDatabaseReference
    
    
    init(description: String, rating: Int, reviewCreatedByUID: String, reviewForUID: String){
        self.description = description
        self.rating = rating
        self.reviewCreatedByUID = reviewCreatedByUID
        self.reviewForUID = reviewForUID
        
        self.createdTime = Constants.dateFormatter().string(from: Date(timeIntervalSinceNow: 0))
        ref = DatabaseReference.users(uid: reviewForUID).reference().child("reviews").childByAutoId()
        uid = ref.key
    }
    
    init(dictionary: [String : Any]){
       
        uid = dictionary["uid"] as! String
        createdTime = dictionary["created time"] as! String
        description = dictionary["description"] as! String
        rating = dictionary["rating"] as! Int
        reviewCreatedByUID = dictionary["review created by UID"] as! String
        reviewForUID = dictionary["review for UID"] as! String

        ref = DatabaseReference.users(uid: reviewForUID).reference().child("reviews/\(uid)")
    }
    
    
    func save(){
        ref.setValue(toDictionary())
    }
    
    func toDictionary() -> [String : Any]
    {
        return [
            "uid" : uid,
            "created time"  : createdTime,
            "description" : description,
            "rating"      : rating,
            "review created by UID" : reviewCreatedByUID,
            "review for UID" : reviewForUID
        ]
    }

}

extension Review : Equatable{ }

func == (lhs: Review, rhs: Review) -> Bool {
    return lhs.uid == rhs.uid
}


func sortByMostRecentlyCreated(_ arrayOfReviews : [Review]) -> [Review] {
    
    var reviews = arrayOfReviews
    reviews.sort(by: { return $0 > $1 })
    return reviews
}

func >(lhs: Review, rhs: Review) -> Bool {
    
    let lhsReview = Constants.dateFormatter().date(from: lhs.createdTime)
    let rhsReview = Constants.dateFormatter().date(from: rhs.createdTime)
    
    return lhsReview?.compare(rhsReview!) == .orderedDescending ? true : false
}

func <(lhs: Review, rhs: Review) -> Bool {
    
    let lhsReview = Constants.dateFormatter().date(from: lhs.createdTime)
    let rhsReview = Constants.dateFormatter().date(from: rhs.createdTime)
    
    return lhsReview?.compare(rhsReview!) == .orderedDescending ? false : true
}

