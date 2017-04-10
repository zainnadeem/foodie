//
//  APIClient.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/16/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import UIKit
import Stripe


class APIClient: NSObject, STPBackendAPIAdapter {
    
    static let sharedClient = APIClient()
    let session: URLSession
    var baseURLString = "http://10.101.104.124:3000/"
    var defaultSource: STPCard? = nil
    var sources: [STPCard] = []
    
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        self.session = URLSession(configuration: configuration)
        super.init()
    }
    
    func decodeResponse(_ response: URLResponse?, error: NSError?) -> NSError? {
        if let httpResponse = response as? HTTPURLResponse
            , httpResponse.statusCode != 200 {
            return error ?? NSError.networkingError(httpResponse.statusCode)
        }
        return error
    }
    
    func completeCharge(_ result: STPPaymentResult, amount: Int, completion: @escaping STPErrorBlock) {

    }
    

    
    @objc func selectDefaultCustomerSource(_ source: STPSourceProtocol, completion: @escaping STPErrorBlock) {
        //  guard let baseURLString = baseURLString, let baseURL = URL(string: baseURLString) else {
        if let token = source as? STPToken {
            self.defaultSource = token.card
            //    }
            completion(nil)
            return
        }
        let baseURL = URL(string: baseURLString)
        let path = "/customer/default_source"
        let url = baseURL?.appendingPathComponent(path)
        let params = [
            "source": source.stripeID,
            ]
        let request = URLRequest.request(url!, method: .POST, params: params as [String : AnyObject])
        let task = self.session.dataTask(with: request) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                if let error = self.decodeResponse(urlResponse, error: error as NSError?) {
                    completion(error)
                    return
                }
                completion(nil)
            }
        }
        task.resume()
    }
    
    @objc func attachSource(toCustomer source: STPSourceProtocol, completion: @escaping STPErrorBlock) {
        //guard let baseURLString = baseURLString, let baseURL = URL(string: baseURLString) else {
        if let token = source as? STPToken, let card = token.card {
            self.sources.append(card)
            self.defaultSource = card
            // }
            completion(nil)
            return
        }
        let baseURL = URL(string: baseURLString)
        let path = "/customer/sources"
        let url = baseURL?.appendingPathComponent(path)
        let params = [
            "source": source.stripeID,
            ]
        let request = URLRequest.request(url!, method: .POST, params: params as [String : AnyObject])
        let task = self.session.dataTask(with: request) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                if let error = self.decodeResponse(urlResponse, error: error as NSError?) {
                    completion(error)
                    return
                }
                completion(nil)
            }
        }
        task.resume()
    }
    
    func retrieveCustomer(_ completion: @escaping STPCustomerCompletionBlock) {
}
}

