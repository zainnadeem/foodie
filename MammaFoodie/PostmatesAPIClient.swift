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
        
        let params = "pickup_address=\(pickupAddress)&dropoff_address=\(dropOffAddress)"
        
        let urlString = "\(postMatesBaseURL)/delivery_quotes"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { print("Error encoding the url string"); return }
        print(encodedString)
        
        let url = URL(string: encodedString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(encodedSandboxKey, forHTTPHeaderField: "Authorization")
        let dataTry = params.data(using: String.Encoding.utf8)
        request.httpBody = dataTry
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = postmatesHeaders
        
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { print("there was an error"); return }
            if let responseDict = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                if responseDict != nil && response.statusCode == 200 {
                    completion(true, responseDict)
                }
                else { completion(false, nil) }
            }
        }.resume()
        
    }
    
    class func createDeliveryRequest () {
        let urlString = "\(postMatesBaseURL)/delivery_quotes"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { print("Error encoding the url string"); return }
    }
    
}
