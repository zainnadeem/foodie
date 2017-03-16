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
    
    func removeBorders() {
        textField.layer.borderWidth = 0
    }
  
    
}

class MoneyTextFieldTableViewCell: TextFieldTableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let dollarSign = UILabel(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        dollarSign.textColor = UIColor.darkGray
        dollarSign.text = "  $"
        self.textField.leftViewMode = .always
        self.textField.leftView = dollarSign
        
        let buffer = UILabel(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        buffer.textColor = UIColor.darkGray
        buffer.text = "   "
        self.textField.rightViewMode = .always
        self.textField.rightView = buffer
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
