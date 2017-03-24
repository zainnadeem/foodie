//
//  UberAPIClient.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/23/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Alamofire

class UberAPIClient {
    class func checkIfDeliveryIsAvailable(completion: @escaping (Bool) -> () ) {
        
        let params = [
            "dropoff": [
                "location": [
                    "address": "530 W 113th Street",
                    "address_2": "Floor 2",
                    "city": "New York",
                    "country": "US",
                    "postal_code": "10025",
                    "state": "NY"
                ]
            ],
            "pickup": [
                "location": [
                    "address": "636 W 28th Street",
                    "address_2": "Floor 2",
                    "city": "New York",
                    "country": "US",
                    "postal_code": "10001",
                    "state": "NY"
                ]
            ]
        ]
        
        let urlString = "\(uberBaseURL)/deliveries/quote"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { print("Error encoding the url string"); return }
        print(encodedString)
        
        Alamofire.request(encodedString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: uberHeaders).responseJSON { (response) in
            print("\n\n\n\n Status code: \(response.response?.statusCode)")
            if response.response?.statusCode == 400 {
                print("\n\n\n\n\n\n There was an error")
                completion(false)
            }
            if let json = response.result.value {
                print("\n\n\n\n\n\n")
                print(json)
            }
        }
        
    }
}
