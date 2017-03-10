//
//  FirebaseAPIClient.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Firebase

class FirebaseAPIClient {
    
    class func uploadImageToStorage(image: UIImage, completion: @escaping (URL) -> ()) {
        let imageData = UIImagePNGRepresentation(image)
        
        let storageRef = FIRStorage.storage().reference().child("profileImages")
        if let imageData = imageData {
            storageRef.put(imageData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("there was an error uploading the image to firebase: \(error?.localizedDescription)")
                    return
                }
                let downloadURL = metadata?.downloadURL()
                completion(downloadURL!)
            }
        }
    }
    
//    class func saveDishToDatabase(dish: Dish, completion: @escaping (Error?) -> ()) {
//        let userRef = DatabaseReference.users(uid: DataStore.sharedInstance.currentUser.uid).reference()
//        let dishRef = userRef.child("dishes").childByAutoId()
//        let newDish = Dish(uid: <#T##String#>, name: <#T##String#>, description: <#T##String#>, mainImage: <#T##UIImage?#>, price: <#T##Int#>, likedBy: <#T##[User]#>, averageRating: <#T##Int#>)
//        dishRef.setValue(["name": dish.name, "description": dish.description, ])
////        let databaseRef = FIRDatabase.database().reference().child("users")
//    }
}
