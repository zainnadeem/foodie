//
//  StripeApiClient.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/18/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import Stripe

enum StripePath  {
        case source
        case customer(uid: String)
        case create
        case charge
        case authorize
        case none
    
        private var path: String{
            switch self {
            case .source:
                return "/customer/sources"
            case .customer(let uid):
                return "/customer/\(uid)"
            case .create:
                return "/customer/create"
            case .charge:
                return "/customer/charge"
            case .authorize:
                return "/authorize"
            case .none:
                return ""
                
            }
        }
    }

struct StripeTools {

    //generate token each time you need to get an api call
    func generateToken(card: STPCardParams, completion: @escaping (_ token: STPToken?) -> Void) {
        STPAPIClient.shared().createToken(withCard: card) { token, error in
            if let token = token {
                completion(token)
            }
            else {
                print(error)
                completion(nil)
            }
        }
    }
    func getBasicAuth() -> String{
        return "Bearer \(stripeSecret)"
    }
    
}

class StripeUtil {
    
    static let sharedClient = StripeUtil()
    
    var stripeTool = StripeTools()
    var customerId: String?
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    
    var defaultSource: STPCard? = nil
    var sources: [STPCard] = []
    
    let store = DataStore.sharedInstance
    
    //createUser
    func createUser(token: STPToken, completion: @escaping (_ success: Bool) -> Void) {
        
        //Stripe iOS SDK will gave us a token to make APIs call possible

                //request to create the user
                let baseURL = URL(string: backendBaseURL)
                let path = "/customer/create"
                let url = baseURL?.appendingPathComponent(path)
                let request = NSMutableURLRequest(url: url!)
                
                
                //params array where you can put your user informations
                var params = [String:Any]()
                params["email"] = "zn.nadeem@gmail.com"
                params["token"] = token
                
                //transform this array into a string
                var str = ""
                params.forEach({ (key, value) in
                    str = "\(str)\(key)=\(value)&"
                })
                
                //basic auth
                request.setValue(self.stripeTool.getBasicAuth(), forHTTPHeaderField: "Authorization")
                
                //POST method, refer to Stripe documentation
                request.httpMethod = "POST"
                request.httpBody = str.data(using: String.Encoding.utf8)
                
                //create request block
                self.dataTask = self.defaultSession.dataTask(with: request as URLRequest) { (data, response, error) in
                    
                    //get returned error
                    if let error = error {
                        print(error)
                        completion(false)
                    }
                    else if let httpResponse = response as? HTTPURLResponse {
                        //you can also check returned response
                        if(httpResponse.statusCode == 200) {
                            if let data = data {
                                let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
                                //serialize the returned datas an get the customerId
                                if let id = json?["id"] as? String {
                                    self.customerId = id
                                    self.store.currentUser.registerStripeCustomerId(id: id)
                                }
                                
                                let responseData = String(data: data, encoding: String.Encoding.utf8)
                                //
                                print(responseData ?? "No data")
                            }
                            completion(true)
                        }
                        else {
                            completion(false)
                        }
                    }
                }
                
                //launch request
                self.dataTask?.resume()
            }
    
    
    
    func retrieveCustomer(_ completion: @escaping STPCustomerCompletionBlock) {
        guard let key = Stripe.defaultPublishableKey() , !key.contains("#") else {
            
            let error = NSError(domain: StripeDomain, code: 50, userInfo: [
                NSLocalizedDescriptionKey: "Please set stripePublishableKey to your account's test publishable key in CheckoutViewController.swift"
                ])
            
            completion(nil, error)
            return
        }
        
        var defaultSource: STPCard? = nil
        var sources: [STPCard] = []
        let customer = STPCustomer(stripeID: self.store.currentUser.stripeCustomerId, defaultSource: defaultSource , sources: sources)
        
        completion(customer, nil)
        //    return
        //}
        let baseURL = URL(string: backendBaseURL)
        let path = "/customer/\(customer.stripeID)"
        let url = baseURL?.appendingPathComponent(path)
        
        let request = URLRequest.request(url!, method: .GET, params: [:])
        
        self.dataTask = self.defaultSession.dataTask(with: request) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                let deserializer = STPCustomerDeserializer(data: data, urlResponse: urlResponse, error: error)
                if let error = deserializer.error {
                    completion(nil, error)
                    return
                } else if let customer = deserializer.customer {
                    completion(customer, nil)
                }
            }
        }
        self.dataTask?.resume()
    }
    
    
    //create card for given user
    func createCard(stripeId: String, token: String, completion: @escaping (_ success: Bool) -> Void) {

                let baseURL = URL(string: backendBaseURL)
                let path = "/customer/sources"
                let url = baseURL?.appendingPathComponent(path)
                let request = NSMutableURLRequest(url: url!)
                
                //token needed
                var params = [String:String]()
                params["source"] = token
                params["id"] = stripeId
                
                var str = ""
                params.forEach({ (key, value) in
                    str = "\(str)\(key)=\(value)&"
                })
                
                //basic auth
                request.setValue(self.stripeTool.getBasicAuth(), forHTTPHeaderField: "Authorization")
                
                request.httpMethod = "POST"
                
                request.httpBody = str.data(using: String.Encoding.utf8)
                
                self.dataTask = self.defaultSession.dataTask(with: request as URLRequest) { (data, response, error) in
                    
                    if let error = error {
                        print(error)
                        completion(false)
                    }
                    else if let data = data {
//                        _ = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                        //                        print(json)
                        completion(true)
                    }
                }
                
                self.dataTask?.resume()
            }
        
        

    
    func stripeAPICall(URLString: String, params: [String: Any], requestMethod: Method, path: String, completion: @escaping (_ success: Bool) -> Void){
        
        let baseURL = URL(string: URLString)
        let url = baseURL?.appendingPathComponent(path)
        var request = URLRequest.request(url!, method: requestMethod, params: params as [String : AnyObject])

        //request.setValue(self.stripeTool.getBasicAuth(), forHTTPHeaderField: "Authorization")
        
        self.dataTask = self.defaultSession.dataTask(with: request as URLRequest) { (data, response, error) in
                
                if let error = error {
                    print(error)
                    completion(false)
                }
                
                else if let data = data {
                    do {
                        let info = try JSONSerialization.jsonObject(with: data, options:[]) as! [String: AnyObject]
                        print(info)
                    } catch let myJSONError {
                        print(myJSONError)
                        
                    }
                    completion(true)
                }
            }
            
            self.dataTask?.resume()
        }
    
    func stripeAPICallCreateCustomer(URLString: String, params: [String: Any], requestMethod: Method, path: String, completion: @escaping (_ success: Bool) -> Void){
        
        let baseURL = URL(string: URLString)
        let url = baseURL?.appendingPathComponent(path)
        var request = URLRequest.request(url!, method: requestMethod, params: params as [String : AnyObject])
        
        //request.setValue(self.stripeTool.getBasicAuth(), forHTTPHeaderField: "Authorization")
        
        self.dataTask = self.defaultSession.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if let error = error {
                print(error)
                completion(false)
            }
                
            else if let data = data {
                do {
                    let info = try JSONSerialization.jsonObject(with: data, options:[]) as! [String: AnyObject]
                    
                    if let id = info["id"] as? String {
                        self.customerId = id
                        self.store.currentUser.stripeCustomerId = self.customerId!
                        self.store.currentUser.registerStripeCustomerId(id: self.customerId!)
                    }

                    
                    print(info)
                } catch let myJSONError {
                    print(myJSONError)
                    
                }
                completion(true)
            }
        }
        
        self.dataTask?.resume()
    }

    
    
    func decodeResponse(_ response: URLResponse?, error: NSError?) -> NSError? {
        if let httpResponse = response as? HTTPURLResponse
            , httpResponse.statusCode != 200 {
            return error ?? NSError.networkingError(httpResponse.statusCode)
        }
        return error
    }
    
    
    
    func createCharge(stripeId: String, amount: Int, currency: String, destination: String, completion: @escaping (_ success: Bool) -> Void) {
        
        let baseURL = URL(string: backendBaseURL)
        let path = "/customer/charge"
        let url = baseURL?.appendingPathComponent(path)
        let request = NSMutableURLRequest(url: url!)
        
        //token needed
        var params = [String:String]()
        params["id"] = stripeId
        params["amount"] = String(amount)
        params["currency"] = currency
        params["destination"] = destination
        
        var str = ""
        params.forEach({ (key, value) in
            str = "\(str)\(key)=\(value)&"
        })
        
        //basic auth
        request.setValue(self.stripeTool.getBasicAuth(), forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        
        request.httpBody = str.data(using: String.Encoding.utf8)
        
        self.dataTask = self.defaultSession.dataTask(with: request as URLRequest) { (data, response, error) in
           
            if let error = error {
                print(error)
                completion(false)
            }
                
            else if let data = data {
                do {
                    let info = try JSONSerialization.jsonObject(with: data, options:[]) as! [String: AnyObject]
                    print(info)
                } catch let myJSONError {
                    print(myJSONError)
                    
                }
                completion(true)
            }
        }
        
        self.dataTask?.resume()
    }
    

    func getCardsList(completion: @escaping (_ result: [AnyObject]?) -> Void) {
        
        //request to create the user
        let baseURL = URL(string: backendBaseURL)
        let path = "/customer/getCards"
        let url = baseURL?.appendingPathComponent(path)
        let request = NSMutableURLRequest(url: url!)
        
        //basic auth
        request.setValue(self.stripeTool.getBasicAuth(), forHTTPHeaderField: "Authorization")
        
        //Get method, refer to Stripe documentation
        request.httpMethod = "GET"
        
        //create request block
        self.dataTask = self.defaultSession.dataTask(with: request as URLRequest) { (data, response, error) in
            
            //get returned error
            if let error = error {
                print(error)
                completion(nil)
            }
            else if let httpResponse = response as? HTTPURLResponse {
                //you can also check returned response
                if(httpResponse.statusCode == 200) {
                    if let data = data {
                        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                        let cardsArray = json?["data"] as? [AnyObject]
                        completion(cardsArray)
                    }
                }
                else {
                    completion(nil)
                }
            }
        }
        
        //launch request
        self.dataTask?.resume()
        
    }

}

