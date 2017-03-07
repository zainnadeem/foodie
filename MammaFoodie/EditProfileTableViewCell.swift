//
//  EditProfileTableViewCell.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/6/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import ChameleonFramework
import Cosmos

class EditProfileTableViewCell: UITableViewCell {

    lazy var profileImageView           : UIImageView = UIImageView()
    lazy var usernameLabel              : UILabel     = UILabel()
    lazy var fullNameLabel              : UILabel     = UILabel()
    lazy var locationLabel              : UILabel     = UILabel()
    
    lazy var editLabel                  : UILabel     = UILabel()
    
    lazy var leftStackView              : UIStackView = UIStackView()
    lazy var rightStackView             : UIStackView = UIStackView()
    
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

        profileImageView.sd_setImage(with: URL(string: user.profileImageURL))
        usernameLabel.text = user.username
        fullNameLabel.text = user.fullName
        locationLabel.text = user.location
            
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
        
        
    }
    
    func setViewProperties(){
        //username
        usernameLabel.font = UIFont.mammaFoodieFontBold(14)
        usernameLabel.textColor = .black
        
        //fullname
        fullNameLabel.font = UIFont.mammaFoodieFont(12)
        fullNameLabel.textColor = .darkGray
        
        //location Label
        locationLabel.font = UIFont.mammaFoodieFont(10)
        locationLabel.textColor = .lightGray
        
        //editLabel
        editLabel.font = UIFont.mammaFoodieFontBold(10)
        editLabel.textColor = .lightGray
 //     editLabel.text = "edit"
        
        
    }
    
    func createStackViews(){
        leftStackView = UIStackView(arrangedSubviews: [usernameLabel, fullNameLabel, locationLabel])
        leftStackView.axis = .vertical
        leftStackView.distribution = .fillProportionally
        leftStackView.alignment = .leading
        
        
        rightStackView = UIStackView(arrangedSubviews: [editLabel])
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
