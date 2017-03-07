//
//  Address.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/6/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import Firebase

class Address{
    
    let store = DataStore.sharedInstance
    // MARK: - Address Properties
    
    var title                            :           String
    var addressLine                      :           String
    var aptSuite                         :           String
    var city                             :           String
    var state                            :           String
    var postalCode                       :           String
    var crossStreet                      :           String
    var phone                            :           String
    
    
    
    init(title: String, addressLine: String, aptSuite: String, city: String, state: String, postalCode: String, crossStreet: String, phone: String){
        
        self.title          = title
        self.addressLine    = addressLine
        self.aptSuite       = aptSuite
        self.city           = city
        self.state          = state
        self.postalCode     = postalCode
        self.crossStreet    = crossStreet
        self.phone          = phone
        
    }
    
    init(dictionary: [String : Any])
    {
        title       = dictionary["title"] as! String
        addressLine = dictionary["address line"] as! String
        aptSuite    = dictionary["apt / suite#"] as! String
        city        = dictionary["city"] as! String
        state       = dictionary["state"] as! String
        postalCode  = dictionary["postal code"] as! String
        crossStreet = dictionary["cross street"] as! String
        phone       = dictionary["phone"] as! String
        
    }
    
    init() {
        self.title = ""
        self.addressLine = ""
        self.aptSuite = ""
        self.city = ""
        self.state = ""
        self.postalCode = ""
        self.crossStreet = ""
        self.phone = ""
    }
    
    
    func save(ref: FIRDatabaseReference, completion: @escaping (Error?) -> Void) {
        
        let ref = DatabaseReference.users(uid: store.currentUser.uid).reference().child("addresses").childByAutoId()
        ref.setValue(toDictionary())
        
    }
    
    
    func toDictionary()-> [String : Any]
    {
        
        return [
            "title"        : title,
            "address line" : addressLine,
            "apt / suite#" : aptSuite,
            "city"         : city,
            "state"        : state,
            "postal code"  : postalCode,
            "cross street" : crossStreet,
            "phone"        : phone
            
        ]
    }
    
}
