//
//  AddImageTableViewCell.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/10/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit

class AddImageTableViewCell: UITableViewCell {
    
    lazy var dishImageView = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dishImageView.image = #imageLiteral(resourceName: "add_dish")
        dishImageView.layer.borderColor = UIColor.black.cgColor
        dishImageView.layer.borderWidth = 3
        dishImageView.layer.cornerRadius = 10
        dishImageView.clipsToBounds = true
        contentView.addSubview(dishImageView)
        
        dishImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(dishImageView.snp.height)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
