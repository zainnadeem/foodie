//
//  Extentions.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import UIKit



//Font Constants
extension UIFont {
    class func mammaFoodieFont(_ size : CGFloat) -> UIFont {
        return UIFont(name: "Avenir", size: size)!
    }
    
    class func mammaFoodieFontBold(_ size : CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Black", size: size)!
    }
    
    class func mammaFoodieFontItalic(_ size : CGFloat) -> UIFont {
        return UIFont(name: "Avenir-MediumOblique", size: size)!
        
    }
}

//CG class helpers for Swift
extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x: x, y: y, width: width, height: height)
    }
    
}
extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width: width, height: height)
    }
}
extension CGPoint{
    init(_ x:CGFloat,_ y:CGFloat) {
        self.init(x: x, y: y)
    }
}




//Color Constants
extension UIColor {
    class func mammaFoodieRed() -> UIColor {
        return UIColor(red: 95.0/255.0, green: 146.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    }
    
    class func mammaFoodieYellow() -> UIColor {
        return UIColor(red: 226.0/255.0, green: 176.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    }
    
}
    
