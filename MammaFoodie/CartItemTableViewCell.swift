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
    
    lazy var nameLabel = UILabel()
    lazy var descriptionLabel = UILabel()
    var labelsStackView: UIStackView!
    lazy var deleteButton = UIButton(type: .system)
    
    var dish: Dish! {
        didSet {
            nameLabel.text = dish.name
            descriptionLabel.text = dish.description
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        deleteButton.setTitle("⛔️", for: .normal)
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.width.equalTo(34)
        }
        
        nameLabel.font = UIFont.mammaFoodieFontBold(14)
        nameLabel.lineBreakMode = .byTruncatingTail
        
        descriptionLabel.font = UIFont.mammaFoodieFont(13)
        descriptionLabel.lineBreakMode = .byTruncatingTail
        
        labelsStackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fillProportionally
        labelsStackView.alignment = .leading
        contentView.addSubview(labelsStackView)
        labelsStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.9)
            make.right.equalTo(deleteButton.snp.left).offset(5)
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
