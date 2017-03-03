//
//  SearchUserTableViewCell.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/1/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import ChameleonFramework
import Cosmos

class SearchUserTableViewCell: UITableViewCell {
    
    lazy var profileImageView           : UIImageView = UIImageView()
    lazy var usernameLabel              : UILabel     = UILabel()
    lazy var fullNameLabel              : UILabel     = UILabel()
    lazy var availibilityLabel          : UILabel     = UILabel()
    
    lazy var leftStackView              : UIStackView = UIStackView()
    lazy var rightStackView             : UIStackView = UIStackView()
    lazy var followButton               : FollowButton = FollowButton()
    
    var ratingStars                     : CosmosView!
    var tags                            : UILabel = UILabel()
    
    lazy var borderWidth                  : CGFloat =       3.0
    lazy var profileImageHeightMultiplier : CGFloat =      (0.5)
    
    var user: User! {
        didSet {
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createStackViews()
        setViewConstraints()
        setViewProperties()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func updateUI(){
        usernameLabel.text = user.username
        fullNameLabel.text = user.fullName
        profileImageView.image = user.profileImage
        ratingStars.rating = Double(user.averageRating)
        
        if user.isAvailable {
            availibilityLabel.text = "Online"
            availibilityLabel.textColor = FlatGreen()
        }else{
            availibilityLabel.text = "Offline"
            availibilityLabel.textColor = .lightGray
        }

        tags.text = user.tagsString
        setImageViewCircular()
    }
    
    
    func setViewConstraints() {
       
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(profileImageView.snp.height)
            make.left.equalToSuperview().offset(10)
        }
        
         contentView.addSubview(leftStackView)
        leftStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }

        contentView.addSubview(rightStackView)
        rightStackView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.height.equalToSuperview().multipliedBy(0.6)
            make.centerY.equalToSuperview()
        }
        
        followButton.snp.makeConstraints { (make) in
            make.width.equalTo(rightStackView.snp.width)
            make.height.equalTo(rightStackView.snp.height).multipliedBy(0.45)
        }
        
        
        
    }
    
    func setViewProperties(){
        //username
        usernameLabel.font = UIFont.mammaFoodieFontBold(14)
        usernameLabel.textColor = .black
        
        //fullname
        fullNameLabel.font = UIFont.mammaFoodieFont(12)
        fullNameLabel.textColor = .darkGray
        
        //rating
        ratingStars.settings.updateOnTouch = false
        ratingStars.settings.starSize = 12
        ratingStars.settings.filledColor = .flatYellowDark
        ratingStars.settings.emptyBorderColor = .black
        ratingStars.settings.filledBorderColor = .black
        
        //tags
        tags.font = UIFont.mammaFoodieFontBold(9)
        tags.textColor = .darkGray
        
        //availability label
        availibilityLabel.font = UIFont.mammaFoodieFont(9)
        
    }
    
    func createStackViews(){
        leftStackView = UIStackView(arrangedSubviews: [usernameLabel, fullNameLabel, availibilityLabel])
        leftStackView.axis = .vertical
        leftStackView.distribution = .fillProportionally
        leftStackView.alignment = .leading
        
        
        ratingStars = CosmosView()

        rightStackView = UIStackView(arrangedSubviews: [followButton, ratingStars, tags])
        rightStackView.axis = .vertical
        rightStackView.distribution = .fillProportionally
        rightStackView.alignment = .center
        rightStackView.spacing = 2
    }
    
    func setImageViewCircular() {
        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.layer.cornerRadius = self.frame.height * profileImageHeightMultiplier / 2
        self.profileImageView.layer.borderColor = UIColor.black.cgColor
        self.profileImageView.layer.borderWidth = borderWidth
        self.profileImageView.clipsToBounds = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

