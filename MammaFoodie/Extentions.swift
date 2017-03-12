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


extension String {
    func isValidCurrency() -> Bool {
        var notDigitsSet = NSCharacterSet.decimalDigits.inverted //everything that's not a digit
        notDigitsSet.remove(charactersIn: ".") //a period in the price is valid
        var currencyCheck = self.rangeOfCharacter(from: notDigitsSet) == nil && self != ""
        if self.contains(".") {
            let periodRange = self.range(of: ".")
            let substringAfterPeriod = self.substring(from: (periodRange?.upperBound)!)
            let afterPeriodCount = substringAfterPeriod.characters.count
            currencyCheck = currencyCheck && afterPeriodCount == 2 && !substringAfterPeriod.contains(".")
        }
        return currencyCheck
    }
}

extension UIWindow {
    func setRootViewController(_ newRootViewController: UIViewController, transition: CATransition? = nil) {
        
        let previousViewController = rootViewController
        
        if let transition = transition {
            // Add the transition
            layer.add(transition, forKey: kCATransition)
        }
        
        rootViewController = newRootViewController
        
        // Update status bar appearance using the new view controllers appearance - animate if needed
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration(), animations: {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            })
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }
        
        /// The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
        if let transitionViewClass = NSClassFromString("UITransitionView") {
            for subview in subviews where subview.isKind(of: transitionViewClass) {
                subview.removeFromSuperview()
            }
        }
        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismiss(animated: false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}


