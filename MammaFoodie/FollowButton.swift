//
//  FollowButton.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/2/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import ChameleonFramework

class FollowButton: UIButton {
    
    required init() {
        // set myValue before super.init is called
        super.init(frame: .zero)
        
        // set other operations after super.init, if required

        setTitle("Follow", for: .normal)
        titleLabel?.font = UIFont.mammaFoodieFont(14)
        setTitleColor(FlatWhite(), for: .normal)
        backgroundColor = FlatPowderBlueDark()
        layer.cornerRadius = 5
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
