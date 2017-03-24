//
//  Constants.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

//Postmates strings
let postMatesBaseURL = "https://api.postmates.com/v1/customers/\(postmatesCustomerID)"
let postmatesHeaders: HTTPHeaders = [
    "Authorization": encodedSandboxKey,
    "Accept": "application/json"
]

//Numbers
let collectionCellCornerRadius = CGFloat(6)
let featuredChefCollectionViewHeightMultiplier = CGFloat(0.23)
let cookingNowCollectionViewHeightMultiplier = CGFloat(0.32)
let liveNowCollectionViewHeightMultiplier = CGFloat(0.17)
let upcomingBroadcastsCollectionViewHeightMultiplier = CGFloat(0.13)

let featuredChefCellHeightMultiplier = CGFloat(0.21)
let cookingNowCellHeightMultiplier = CGFloat(0.30)
let liveNowCellHeightMultiplier = CGFloat(0.15)
let upcomingBroadcastsCellHeightMultiplier = CGFloat(0.11)
let formTableViewSectionHeaderHeight: CGFloat = 24

let cartViewHeight = 50

//Lorem Ipsum
let loremIpsumString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla vel enim sed turpis congue pretium. Cras pharetra dolor ante, auctor semper neque tristique sed. Praesent ultricies porttitor ex. Aenean vulputate est vel nisi convallis, nec fermentum ante rutrum. Pellentesque eleifend, diam a malesuada ornare, quam mauris tempor urna, eu facilisis ante velit eget libero. Sed a ligula mattis sapien lobortis convallis vitae at libero. Integer sit amet venenatis ipsum. Fusce sed sapien enim. Sed sed scelerisque orci, semper egestas lacus. Aliquam fringilla, lacus nec venenatis condimentum, arcu purus condimentum turpis, a suscipit lectus ligula in eros. Proin aliquam arcu convallis turpis accumsan, in euismod odio imperdiet. Curabitur faucibus pharetra felis non tincidunt. Maecenas elit ex, tristique a urna vitae, sagittis dignissim orci."

//Cell Identifiers
let featuredChefTableViewCellIdentifier = "featuredTableViewCell"
let cookingNowTableViewCellIdentifier = "cookingNowTableViewCell"
let liveNowTableViewCellIdentifier = "liveNowTableViewIdentifier"
let upcomingBroadcastsTableViewCellIdentifier = "upcomingTableVIewIdentifier"

let featuredChefCollectionViewIdentifier = "featuredChefCollectionViewCell"
let cookingNowCollectionViewIdentifier = "cookingNowCollectionViewCell"
let liveNowCollectionViewIdentifier = "liveNowCollectionViewCell"
let upcomingBroadcastsViewIdentifier = "upcomingBroadcastsViewCell"

let searchUserTableViewCellIdentifier = "searchUserTableViewCell"
let textViewTableViewCellIdentifier = "textViewTableViewCell"
let textFieldTableViewCellIdentifier = "textFieldTableViewCell"
let moneyTextFieldTableViewCellIdentifier = "moneyTextFieldTableViewCell"
let addImageTableViewCelIdentifier = "addImageTableViewCell"
let editProfileTableViewCellIdentifier = "editProfileTableViewCell"
let infoTableViewCellIdentifier = "infoTableViewCell"
let broadcastImageTableViewCellIdentifier = "broadcastImageTableViewCellIdentifier"
let defaultReuseIdentifier = "cell"

let dishCellIdentifier = "dishCell"
let reviewCellIdentifier = "reviewCell"
let followCellIdentifier = "followCell"
let profileHeaderIdentifier = "headerView"
let formTableViewHeaderViewIdentifier = "formHeaderView"
let cartItemCellIdentifier = "cartItemCell"

let notDigitsSet = CharacterSet.decimalDigits.inverted

let buttonRect = CGRect(x: 0, y: 0, width: 30, height: 30)



//Stripe Paths 

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
    
    class func reviewDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        return dateFormatter
    }
    
    
    
    //Magic Numbers
    let profileImageHeight = 100
    
    
    
}
