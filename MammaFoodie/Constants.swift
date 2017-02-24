//
//  Constants.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation


class Constants {
    
     // MARK: - Time Constants
    
    class func twoHoursAgo() -> Date {
        return Constants.dateFormatter().date(from: Constants.twoHoursAgo())!
    }
    
    class func twoHoursAgo() -> String {
        return Constants.dateFormatter().string(from: Date(timeInterval: -7200, since: Date(timeIntervalSinceNow: 0)))
    }
    
    class func oneDayAgo() -> String {
        return Constants.dateFormatter().string(from: Date(timeInterval: -86400, since: Date(timeIntervalSinceNow: 0)))
    }
    
    class func twoDaysAgo() -> String {
        return Constants.dateFormatter().string(from: Date(timeInterval: -176800, since: Date(timeIntervalSinceNow: 0)))
    }
    
    class func isDimeWithinTwoDays(videoDate date : String) -> Bool {
        if let creationDate = Constants.dateFormatter().date(from: date) {
            
            let yesterday = Constants.dateFormatter().date(from: Constants.twoDaysAgo())!
            
            if creationDate.compare(yesterday) == .orderedDescending { return true }
            else if creationDate.compare(yesterday) == .orderedSame  { return true }
            else { return false }
            
        } else {
            print("Couldn't get NSDate object from string date arguement")
            return false
        }
    }
    
    class func dateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy, HH:mm:ss"
        return dateFormatter
    }
    
    
}
