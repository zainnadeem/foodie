//
//  ProfileTableViewButton.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/3/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import ChameleonFramework

class SegmentedControlButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.mammaFoodieFont(14)
        self.setTitleColor(FlatBlack(), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                UIView.animate(withDuration: 0.5, animations: { 
                    self.backgroundColor = FlatSkyBlue()
                    self.setTitleColor(FlatWhite(), for: .normal)
                })
                
            case false:
                UIView.animate(withDuration: 0.5, animations: { 
                    self.backgroundColor = FlatWhite()
                    self.setTitleColor(FlatBlack(), for: .normal)
                })
                
            }
        }
    }

}
