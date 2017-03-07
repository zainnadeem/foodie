//
//  TextFieldTableViewCell.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/3/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    lazy var textField:         UITextField = UITextField()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview().multipliedBy(0.8)
        }
        
        textField.layer.borderWidth = 3
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont.mammaFoodieFont(15)
        textField.textAlignment = .center

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    

    
    
}
