//
//  TextViewTableViewCell.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/7/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {
    
    lazy var textView:         UITextView = UITextView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        textView.layer.borderWidth = 3
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.black.cgColor
        textView.font = UIFont.mammaFoodieFont(15)
        textView.textAlignment = .center
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}

