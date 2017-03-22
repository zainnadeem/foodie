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
import SDWebImage

class UserTableViewCell: UITableViewCell {
    
    lazy var profileImageView =  UIImageView()
    lazy var usernameLabel = UILabel()
    lazy var fullNameLabel = UILabel()
    var labelStackView: UIStackView!
    lazy var followButton: FollowButton = FollowButton()
    
    var user: User! {
        didSet {
//            profileImageView.image = #imageLiteral(resourceName: "profile_placeholder")
            profileImageView.sd_setImage(with: URL(string:user.profileImageURL))
            usernameLabel.text = user.username
            fullNameLabel.text = user.fullName
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        usernameLabel.font = UIFont.mammaFoodieFont(14)
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
