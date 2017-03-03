//
//  UserTableViewCell.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit
import ChameleonFramework

class UserTableViewCell: UITableViewCell {
    
    var profileImageView: UIImageView!
    var usernameLabel: UILabel!
    var fullNameLabel: UILabel!
    var labelStackView: UIStackView!
    var followButton: UIButton!
    
    var user: User!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        profileImageView = UIImageView(image: UIImage(named: "profile_placeholder"))
        usernameLabel = UILabel(text: "sulu_candles")
        usernameLabel.font = UIFont.mammaFoodieFont(14)
        fullNameLabel = UILabel(text: "Sulu Candles")
        fullNameLabel.font = UIFont.mammaFoodieFont(12)
        followButton = FollowButton()
        followButton.setTitle("Follow", for: .normal)
        followButton.titleLabel?.font = UIFont.mammaFoodieFont(14)
        followButton.setTitleColor(FlatWhite(), for: .normal)
        followButton.backgroundColor = FlatSkyBlueDark()
        
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
        contentView.addSubview(followButton)
        
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(profileImageView.snp.height)
            make.left.equalToSuperview().offset(10)
        }
        
        labelStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }
        
        followButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25)
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
