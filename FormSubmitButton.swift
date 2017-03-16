//
//  FoodieButton.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class FormSubmitButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.mammaFoodieFontBold(16)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .black
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
