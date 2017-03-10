//
//  FIRImage.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/22/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import Firebase

class FIRImage {
    
    var image: UIImage
    var downloadURL: URL?
    var downloadLink: String!
    var ref: FIRStorageReference!
    
    init(image: UIImage) {
        self.image = image
    }
}

extension FIRImage {
    func saveProfileImage(_ userUID: String, _ completion: @escaping (Error?) -> Void)
    {
        let resizedImage = image.resized()
        let imageData = UIImageJPEGRepresentation(resizedImage, 0.9)
        
        ref = StorageReference.profileImages.reference().child(userUID)
        downloadLink = ref.description
        
        ref.put(imageData!, metadata: nil) { (metaData, error) in
            completion(error)
        }
        
    }
    
    func  save(_ uid:String, completion: @escaping (URL) -> Void) {
        
        let resizedImage = image.resized()
        let imageData = UIImageJPEGRepresentation(resizedImage, 0.9)
        
        ref = StorageReference.images.reference().child(uid)
        downloadLink = ref.description
        
        
        // Delete the file
        ref.delete { error in
            if let error = error {
                print("there was an error deleting the file from firebase: \(error.localizedDescription)")
            } else {
                // File deleted successfully
            }
        }
        
        ref.put(imageData!, metadata: nil) { (metaData, error) in
            if error != nil {
                print("there was an error uploading the image to firebase: \(error?.localizedDescription)")
                return
            }
            let downloadURL = metaData?.downloadURL()
            completion(downloadURL!)
        }
        
    }
    
    
    func saveToFirebaseStorage(_ uid:String, completion: @escaping (FIRStorageMetadata?, Error?) -> Void) {
        
        let imageUid = NSUUID().uuidString
        
        let resizedImage = image.resized()
        let imageData = UIImageJPEGRepresentation(resizedImage, 0.9)
        
        ref = StorageReference.images.reference().child(uid)
        
        ref.put(imageData!, metadata: nil, completion: { (meta, error) in
            completion(meta, error)
        })
    }
    
    
}

extension FIRImage {
    
    class func downloadProfileImage(_ uid: String, completion: @escaping (UIImage?, Error?) -> Void){
        StorageReference.profileImages.reference().child(uid).data(withMaxSize: 1 * 1024 * 1024) { (imageData, error) in
            if error == nil && imageData != nil {
                let image = UIImage(data: imageData!)
                completion(image, error)
            }else{
                completion(nil, error)
            }
            
        }
    }
    
    class func downloadImage(uid: String, completion: @escaping
        (UIImage?, Error?) -> Void){
        StorageReference.images.reference().child(uid).data(withMaxSize: 1 * 1024 * 1024) { (imageData, error) in
            if error == nil && imageData != nil {
                let image = UIImage(data: imageData!)
                completion(image, error)
            }else{
                completion(nil, error)
            }
            
        }
        
    }
  
    
}


private extension UIImage
{
    func resized() -> UIImage{
        let height: CGFloat = 800.0
        let ratio = self.size.width / self.size.height
        let width = height * ratio
        
        let newSize = CGSize(width: width, height: height)
        let newRectangle = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: newRectangle)
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
}
