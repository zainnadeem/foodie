//
//  UserTableViewCell.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit

class UserTableViewCell: UITableViewCell {
    
    var profileImageView: UIImageView!
    var usernameLabel: UILabel!
    var fullNameLabel: UILabel!
    var labelStackView: UIStackView!
    
    var user: User!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        profileImageView = UIImageView(image: UIImage(named: "profile_placeholder"))
        usernameLabel = UILabel(text: "sulu_candles")
        usernameLabel.font = UIFont.mammaFoodieFontBold(14)
        fullNameLabel = UILabel(text: "Sulu Candles")
        fullNameLabel.font = UIFont.mammaFoodieFont(12)
        
        labelStackView = UIStackView(arrangedSubviews: [usernameLabel, fullNameLabel])
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillProportionally
        labelStackView.alignment = .leading
        
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setConstraints() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(labelStackView)
        
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
            make.width.equalTo(profileImageView.snp.height)
            make.left.equalToSuperview().offset(10)
        }
        
        labelStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
