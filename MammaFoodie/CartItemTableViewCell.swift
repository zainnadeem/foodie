//
//  CartItemTableViewCell.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/16/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit

class CartItemTableViewCell: UITableViewCell {
    
    var dish: Dish!
    
    lazy var nameLabel = UILabel()
    lazy var deleteButton = UIButton(type: .system)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel.text = dish.name
        nameLabel.font = UIFont.mammaFoodieFont(16)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.right.equalTo(deleteButton.snp.left).offset(5)
        }
        
        deleteButton.setTitle("⛔️", for: .normal)
        contentView.addSubview(deleteButton)
        
        deleteButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.height.width.equalTo(34)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
