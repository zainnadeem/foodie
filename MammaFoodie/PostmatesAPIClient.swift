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
        
        let url = URL(string: encodedString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(encodedSandboxKey, forHTTPHeaderField: "Authorization")
        request.httpBody = params.data(using: String.Encoding.utf8)
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = postmatesHeaders
        
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { print("there was an error"); return }
            if response.statusCode != 200 {
                print("There was an error with your request")
                completion(false, nil)
            }
            if let responseDict = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                if let responseDict = responseDict {
                    completion(true, responseDict)
                }
                else { completion(false, nil) }
            }
        }.resume()
        
    }
    
    class func createDeliveryRequest(manifest: String,
                                     pickupAddress: Address,
                                     dropoffAddress: Address,
                                     completion: @escaping (Bool, [String: Any]?) -> ()) {
        let urlString = "\(postMatesBaseURL)/deliveries"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { print("Error encoding the url string"); return }
        
        var pickupAptSuite = ""
        if pickupAddress.aptSuite != "" { pickupAptSuite = " \(pickupAddress.aptSuite)" }
        let pickupAddressString = "\(pickupAddress.addressLine)\(pickupAptSuite), \(pickupAddress.city), \(pickupAddress.state)"
        
        var dropoffAptSuite = ""
        if dropoffAddress.aptSuite != "" { dropoffAptSuite = " \(dropoffAddress.aptSuite)" }
        let dropoffAddressString = "\(dropoffAddress.addressLine)\(dropoffAptSuite), \(dropoffAddress.city), \(dropoffAddress.state)"
        
        let params = "manifest=\(manifest)&pickup_name=\(pickupAddress.title)&pickup_phone_number=\(pickupAddress.phone)&pickup_address=\(pickupAddressString)&dropoff_name=\(dropoffAddress.title)&dropoff_phone_number=\(dropoffAddress.phone)&dropoff_address=\(dropoffAddressString)"
        
        let url = URL(string: encodedString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(encodedSandboxKey, forHTTPHeaderField: "Authorization")
        request.httpBody = params.data(using: String.Encoding.utf8)
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = postmatesHeaders
        
        let session = URLSession(configuration: config)
        
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { print("there was an error"); return }
            if response.statusCode != 200 {
                print("There was an error with your request")
                completion(false, nil)
            }
            if let responseDict = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                if let responseDict = responseDict {
                    completion(true, responseDict)
                }
                else { completion(false, nil) }
            }
        }.resume()
    }
    
    class func giveCourier(tip: Int, deliveryID: Int) {
        let urlString = "\(postMatesBaseURL)/deliveries/\(deliveryID)"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { print("Error encoding the url string"); return }
    }
    
}
