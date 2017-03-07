//
//  Extentions.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework


//Font Constants
extension UIFont {
    class func mammaFoodieFont(_ size : CGFloat) -> UIFont {
        return UIFont(name: "Nexa Light", size: size)!
    }
    
    class func mammaFoodieFontBold(_ size : CGFloat) -> UIFont {
        return UIFont(name: "Nexa Bold", size: size)!
    }
    
    class func mammaFoodieFontItalic(_ size : CGFloat) -> UIFont {
        return UIFont(name: "Avenir-MediumOblique", size: size)!
        
    }
}

//Color Constants
extension UIColor {
    class func mammaFoodieMainColor() -> UIColor {
        return UIColor(red: 95.0/255.0, green: 146.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    }
    
    class func mammaFoodieSecondaryColor() -> UIColor {
        return UIColor(red: 226.0/255.0, green: 176.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    }
    
}

extension UILabel {
    convenience init (text: String) {
        self.init()
        self.text = text
    }
}

extension UITextField {
    convenience init (placeholder: String) {
        self.init()
        self.placeholder = text
    }
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


