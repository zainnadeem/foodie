//
//  Dish.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/22/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import Firebase

class Dish {
    
    // MARK: - Dish Properties
    
    let createdBy                       :           String
    var name                            :           String
    var description                     :           String
    
    var likedBy                         :           [User]
    var averageRating                   :           Int
    var price                           :           Int
    
    var mainImage                       :           UIImage?
    var mainImageURL                    :           String
    
    
    init(createdBy: String, name: String, description: String, mainImage: UIImage, mainImageURL: String, price: Int, likedBy: [User], averageRating: Int){
        
        self.createdBy = createdBy
        self.name = name
        self.description = description
        self.mainImage = mainImage
        self.mainImageURL = mainImageURL
        self.price = price
        self.likedBy = likedBy
        self.averageRating = averageRating
        
    }
    
    init(dictionary: [String : Any])
    {
        createdBy = dictionary["created by"] as! String
        
        name = dictionary["name"] as! String
        description = dictionary["description"] as! String
        
        price = dictionary["price"] as! Int
        averageRating = dictionary["average rating"] as! Int
        mainImageURL = dictionary["main image URL"] as! String
        
        self.likedBy = []
        if let likedByDict = dictionary["liked by"] as? [String : Any] {
            for (_, userDict) in likedByDict {
                if let userDict = userDict as? [String : Any] {
                    self.likedBy.append(User(dictionary: userDict))
                }
            }
        }
    }
    
    
    func save(completion: @escaping (URL) -> Void) {
        
        let ref = DatabaseReference.users(uid: self.createdBy).reference().child("dishes").childByAutoId()
        
        
        //save likes
        for user in likedBy {
            ref.child("like by/\(user.uid)").setValue(user.toDictionary())
        }
        //upload image to storage database
        if let mainImage = mainImage {
            let firImage = FIRImage(image: mainImage)
            firImage.save(self.createdBy, completion: { (downloadURL) in
                completion(downloadURL)
                ref.setValue(self.toDictionary())
            })
        }
        
        
    }
    
    
    func toDictionary()-> [String : Any]
    {
        
        return [
            "created by" : createdBy,
            "name" : name,
            "description" : description,
            "average rating" : averageRating,
            "price" : price,
            "main image URL" : mainImageURL
        ]
    }
    
}
