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
    var purchasingUser: User!
    
    init(pickup: Address, dropoff: Address, chef: User, purchasingUser: User) {
        
        self.purchasingUser = purchasingUser
        
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
            "first_name"    : chef.fullName.components(separatedBy: " ").first!,
            "last_name"     : chef.fullName.components(separatedBy: " ").last!,
            "phone"         : [ "number" : pickup.phone, "sms_enabled" : false]
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
            "first_name"    : purchasingUser.fullName.components(separatedBy: " ").first!,
            "last_name"     : purchasingUser.fullName.components(separatedBy: " ").last!,
            "phone"         : [ "number" : dropoff.phone, "sms_enabled" : false]
        ]
        
        self.params = ["dropoff" : ["location" : dropoffLocation, "contact" : dropoffContact], "pickup" : ["location" : pickupLocation, "contact" : pickupContact]]
        
    }
    
    
    
    
    
    func getDeliveryQuote(completion: @escaping ([String : Any]?) -> ()) {
        
        let urlString = "\(uberBaseURL)/deliveries/quote"
        
        Alamofire.request(urlString, method: .post, parameters: self.params, encoding: JSONEncoding.default, headers: uberHeaders).responseJSON { (response) in
            print("\n\n\n\n Status code: \(response.response?.statusCode)")
            if response.response?.statusCode != 201 {
                print("\n\n\n\n\n\n There was an error")
                completion(nil)
            }
            if let json = response.result.value as? [String : Any], let quotes = json["quotes"] as? [[String : Any]] {
                print("\n\n\n\n\n\n")
//                print(json)
                if let firstQuote = quotes.first {
//                    completion(firstQuote["quote_id"] as? String)
                    completion(firstQuote)
                }
                
            }
        }
    }
    
    func createDelivery(completion: @escaping (String?) -> ()) {
        
        let urlString = "\(uberBaseURL)/deliveries"
        
        var items = [[String : Any]]()
        for dish in self.purchasingUser.cart {
            let item: [String : Any] = [
                "currency_code" : "USD",
                "price"         : Float(dish.price)/100.0,
                "quantity"      : 1,
                "title"         : dish.name
            ]
            items.append(item)
        }
        self.params["items"] = items
        
        self.getDeliveryQuote { (quoteID) in
            guard let quoteID = quoteID else { completion(nil); return }
            self.params["quote_id"] = quoteID["quote_id"]
            Alamofire.request(urlString, method: .post, parameters: self.params, encoding: JSONEncoding.default, headers: uberHeaders).responseJSON { (response) in
                print("\n\n\n\n Status code: \(response.response?.statusCode)")
                if response.response?.statusCode != 200 && response.response?.statusCode != 201 {
                    print("\n\n\n\n\n\n There was an error")
                    completion(nil)
                }
                if let json = response.result.value as? [String : Any] {
                    completion(json["delivery_id"] as? String)
                }
            }
        }
    }
    
    func getDeliveryDetails(deliveryID: String, completion: @escaping ([String : Any]?) -> ()) {
        
        let urlString = "\(uberBaseURL)/deliveries/\(deliveryID)"
        
        Alamofire.request(urlString, headers: uberHeaders).responseJSON { (response) in
            if response.response?.statusCode != 200 {
                print("there was an error in getDeliveryDetails")
                completion(nil)
            }
            if let json = response.result.value as? [String : Any] {
                completion(json)
            }
        }
    }
    
    func assignVehicleToDelivery(deliveryID: String, completion: @escaping (Bool) -> ()) {
        let urlString = "\(uberBaseURL)/sandbox/deliveries/\(deliveryID)"
        
        Alamofire.request(urlString, method: .put, headers: uberHeaders).responseJSON { (response) in
            if response.response?.statusCode != 204 {
                print("there was an error in assignVehicleToDelivery: status code \(response.response?.statusCode)")
                completion(false)
            }
            if (response.result.value as? [String : Any]) != nil {
                completion(true)
            }
        }
    }
    
    class func getAccessToken(authorizationCode: String, completion: @escaping ([String : Any]?) -> ()) {
        let urlString = "https://login.uber.com/oauth/v2/token"
        let parameters = ["client_secret"   : uberClientSecret,
                      "client_id"       : uberClientID,
                      "grant_type"      : "authorization_code",
                      "redirect_uri"    : "mammafoodie-uber://oauth",
                      "code"            : authorizationCode
                      ]
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { (response) in
            if let json = response.result.value as? [String : Any] {
                completion(json)
            }
            
        }
    }
}
