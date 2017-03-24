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
    
    var params: [String: Any]
    
    init(pickup: Address, dropoff: Address, chef: User, purchasingUser: User) {
        
        let pickupLocation = [
            "address"       : pickup.addressLine,
            "address_2"     : pickup.aptSuite,
            "city"          : pickup.city,
            "country"       : "US",
            "postal_code"   : pickup.postalCode,
            "state"         : pickup.state
        ]
        let pickupContact: [String: Any] = [
            "email"         : chef.email,
            "first_name"    : chef.fullName.components(separatedBy: " ").first as Any,
            "last_name"     : chef.fullName.components(separatedBy: " ").last as Any,
            "phone"         : [ "number" : chef.phoneNumber, "sms_enabled" : false]
        ]
        
        let dropoffLocation = [
                "address"       : dropoff.addressLine,
                "address_2"     : dropoff.aptSuite,
                "city"          : dropoff.city,
                "country"       : "US",
                "postal_code"   : dropoff.postalCode,
                "state"         : dropoff.state
        ]
        let dropoffContact: [String: Any] = [
            "email"         : purchasingUser.email,
            "first_name"    : purchasingUser.fullName.components(separatedBy: " ").first as Any,
            "last_name"     : purchasingUser.fullName.components(separatedBy: " ").last as Any,
            "phone"         : [ "number" : chef.phoneNumber, "sms_enabled" : false]
        ]
        
        self.params = ["dropoff" : ["location" : dropoffLocation, "contact" : dropoffContact], "pickup" : ["location" : pickupLocation, "contact" : pickupContact]]
        
    }
    
    
    
    
    
    func getDeliveryQuote(completion: @escaping (String?) -> ()) {
        
        let urlString = "\(uberBaseURL)/deliveries/quote"
        
        Alamofire.request(urlString, method: .post, parameters: self.params, encoding: JSONEncoding.default, headers: uberHeaders).responseJSON { (response) in
            print("\n\n\n\n Status code: \(response.response?.statusCode)")
            if response.response?.statusCode == 400 {
                print("\n\n\n\n\n\n There was an error")
                completion(nil)
            }
            if let json = response.result.value {
                print("\n\n\n\n\n\n")
                print(json)
            }
        }
    }
    
    func createDelivery(completion: @escaping (Bool) -> ()) {
        
        let urlString = "\(uberBaseURL)/deliveries"
        
        self.getDeliveryQuote { (quoteID) in
            guard let quoteID = quoteID else { completion(false); return }
            self.params["quote_id"] = quoteID
            Alamofire.request(urlString, method: .post, parameters: self.params, encoding: JSONEncoding.default, headers: uberHeaders).responseJSON { (response) in
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
}
