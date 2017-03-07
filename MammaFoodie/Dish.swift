//
//  Dish.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/22/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import Firebase

class Dish{
    
    // MARK: - Dish Properties
    
    let uid                             :           String
    var name                            :           String
    var description                     :           String
    
    var likedBy                         :           [User]
    var averageRating                   :           Int
    var price                           :           Int
    
    var mainImage                       :           UIImage?
    
    
    init(uid: String, name: String, description: String, mainImage: UIImage?, price: Int, likedBy: [User], averageRating: Int){
        
        self.uid = uid
        self.name = name
        self.description = description
        self.mainImage = mainImage
        self.price = price
        self.likedBy = likedBy
        self.averageRating = averageRating
        
    }
    
    init(dictionary: [String : Any])
    {
        uid = dictionary["uid"] as! String
        
        name = dictionary["name"] as! String
        description = dictionary["description"] as! String
        
        price = dictionary["price"] as! Int
        averageRating = dictionary["average rating"] as! Int
        
        
        self.likedBy = []
        if let likedByDict = dictionary["liked by"] as? [String : Any] {
            for (_, userDict) in likedByDict {
                if let userDict = userDict as? [String : Any] {
                    self.likedBy.append(User(dictionary: userDict))
                }
            }
        }
    }
    
    
    func save(ref: FIRDatabaseReference, completion: @escaping (URL) -> Void) {
        
        let ref = DatabaseReference.users(uid: self.uid).reference().child("dishes").childByAutoId()
        ref.setValue(toDictionary())
        
        //save likes
        for user in likedBy {
            ref.child("like by/\(user.uid)").setValue(user.toDictionary())
        }
        //upload image to storage database
        if let mainImage = self.mainImage {
            let firImage = FIRImage(image: mainImage)
            firImage.save(self.uid, completion: { (downloadURL) in
                completion(downloadURL)
            })
            
            
        }
    }
    
    
    func toDictionary()-> [String : Any]
    {
        
        return [
            "uid" : uid,
            "name" : name,
            "description" : description,
            "average rating" : averageRating,
            "price" : price
            
        ]
    }
    
}
