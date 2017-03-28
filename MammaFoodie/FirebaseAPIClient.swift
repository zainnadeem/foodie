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
    
    class func checkForUserToken(for userID: String, completion: @escaping (Bool) -> ()) {
        FIRDatabase.database().reference().child("tokens").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String: String]
            if let check = value?.keys.contains(userID) {
                completion(check)
            }
        }) { (error) in
            print("Error in checkForUserToken: \(error.localizedDescription)")
        }
    }
}
