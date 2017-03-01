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

class SearchUserTableViewCell: UITableViewCell {
    
    lazy var profileImageView           : UIImageView = UIImageView()
    lazy var usernameLabel              : UILabel     = UILabel()
    lazy var fullNameLabel              : UILabel     = UILabel()
    
    lazy var labelStackView             : UIStackView = UIStackView()
    lazy var followButton               : UIButton    = UIButton()
    
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
    }
    
    
    func setViewConstraints() {
       
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(profileImageView.snp.height)
            make.left.equalToSuperview().offset(10)
        }
        
         contentView.addSubview(labelStackView)
        labelStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }
        
        contentView.addSubview(followButton)
        followButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25)
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
        }
    }
    
    func setViewProperties(){
        
        usernameLabel.font = UIFont.mammaFoodieFontBold(14)
        fullNameLabel.font = UIFont.mammaFoodieFont(12)
        
        followButton = UIButton(type: .system)
        followButton.setTitle("Follow", for: .normal)
        followButton.titleLabel?.font = UIFont.mammaFoodieFont(14)
        
        followButton.setTitleColor(FlatWhite(), for: .normal)
        followButton.backgroundColor = FlatSkyBlueDark()
        
        labelStackView = UIStackView(arrangedSubviews: [usernameLabel, fullNameLabel])
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillProportionally
        labelStackView.alignment = .leading
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

