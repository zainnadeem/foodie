//
//  PostmatesAPIClient.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/20/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Alamofire

class PostmatesAPIClient {
    

    class func checkIfDeliveryIsAvailable(pickupAddress: String,
                                          dropOffAddress: String,
                                          completion: @escaping (Bool, [String: Any]?) -> () ) {
        
        let urlString = "\(postMatesBaseURL)/delivery_quotes"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { print("Error encoding the url string"); return }
        print(encodedString)
//        Alamofire.request(encodedString, method: .post, headers: postmatesHeaders).responseJSON { (response) in
//            //HTTP - 200 for success, 400 for error
//            print("\n\n\n\n Status code: \(response.response?.statusCode)")
//            if response.response?.statusCode == 400 {
//                print("\n\n\n\n\n\n There was an error")
//                completion(false, nil)
//            }
//            if let json = response.result.value {
//                print("\n\n\n\n\n\n")
//                print(json)
//            }
//        }
        
    }
    
    class func createDeliveryRequest () {
        let urlString = "\(postMatesBaseURL)/delivery_quotes"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { print("Error encoding the url string"); return }
    }
    
}
