//
//  ProfileView.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Cosmos
import SnapKit
import ChameleonFramework

class ProfileView: UIView {
    
    let user: User
    
    var profileTopStackView: UIStackView!
    var profileImageView: UIImageView!
    var ratingView: CosmosView!
    var followButton: UIButton!
    var likesLabel: UILabel!
    var bioTextView: UITextView!
    var websiteLabel: UILabel!
    
    var menuButton: UIButton!
    var reviewsButton: UIButton!
    var followersButton: UIButton!
    var followingButton: UIButton!
    var lastTappedButton: UIButton!
    var tableViewButtonStackView: UIStackView!
    var tableView: UITableView!
    
    init(user: User, frame: CGRect) {
        self.user = user
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.user = User()
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        backgroundColor = FlatWhite()
        setupViewLayout()
        menuButton.isSelected = true
        lastTappedButton = menuButton
    }
    
    
    
}

//tableview button functions
extension ProfileView {
    func menuButtonTapped() {
        lastTappedButton.isSelected = false
        menuButton.isSelected = true
        lastTappedButton = menuButton
    }
    
    func reviewsButtonTapped() {
        lastTappedButton.isSelected = false
        reviewsButton.isSelected = true
        lastTappedButton = reviewsButton
    }
    
    func followersButtonTapped() {
        lastTappedButton.isSelected = false
        followersButton.isSelected = true
        lastTappedButton = followersButton
    }
    
    func followingButtonTapped() {
        lastTappedButton.isSelected = false
        followingButton.isSelected = true
        lastTappedButton = followingButton
    }
}


fileprivate extension ProfileView {
    func setupViewLayout() {
        
        profileImageView = UIImageView(image: UIImage(named: "profile_placeholder"))
        ratingView = CosmosView()
        ratingView.settings.updateOnTouch = false
        followButton = UIButton(type: .system)
        followButton.setTitle("Follow", for: .normal)
        likesLabel = UILabel()
        likesLabel.text = "0 likes"
        bioTextView = UITextView()
        
        bioTextView.text = "Lorem ipsum dolor sit amet, option appareat te pro, feugait suavitate est ad. Verear iriure euismod cu eos. An eirmod antiopam consulatu sit, delicata salutandi vis ut, in ferri nullam quo. Nec at atqui velit postea, tota regione sit in, ut aeterno scripta eos. Vis dolor comprehensam ut, nominati antiopam mnesarchum ut sed, vel commodo habemus maluisset et. Eos ex commodo mentitum. Eu nec magna commodo nostrum, per vero insolens menandri ad, graeco pertinax sapientem ei usu. Adipisci deterruisset vel te, vocent fierent praesent at qui, te timeam integre fastidii sea."
        websiteLabel = UILabel()
        websiteLabel.font = UIFont.mammaFoodieFont(12)
        websiteLabel.text = "mammafoodie.com"
        
        
        menuButton = UIButton(type: .system)
        menuButton.setTitle("Menu", for: .normal)
        menuButton.titleLabel?.textAlignment = .center
        menuButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        reviewsButton = UIButton(type: .system)
        reviewsButton.setTitle("Reviews", for: .normal)
        reviewsButton.titleLabel?.textAlignment = .center
        reviewsButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        reviewsButton.addTarget(self, action: #selector(reviewsButtonTapped), for: .touchUpInside)
        followersButton = UIButton(type: .system)
        followersButton.setTitle("Followers", for: .normal)
        followersButton.titleLabel?.textAlignment = .center
        followersButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        followersButton.addTarget(self, action: #selector(followersButtonTapped), for: .touchUpInside)
        followingButton = UIButton(type: .system)
        followingButton.setTitle("Following", for: .normal)
        followingButton.titleLabel?.textAlignment = .center
        followingButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        followingButton.addTarget(self, action: #selector(followingButtonTapped), for: .touchUpInside)
        
        
        tableViewButtonStackView = UIStackView(arrangedSubviews: [menuButton, reviewsButton, followersButton, followingButton])
        tableViewButtonStackView.axis = .horizontal
        tableViewButtonStackView.distribution = .fillEqually
        self.addSubview(tableViewButtonStackView)
        
        
        profileTopStackView = UIStackView(arrangedSubviews: [profileImageView, ratingView, followButton, likesLabel, bioTextView, websiteLabel, tableViewButtonStackView])
        profileTopStackView.axis = .vertical
        profileTopStackView.distribution = .fill
        profileTopStackView.alignment = .center
        profileTopStackView.spacing = 5
        self.addSubview(profileTopStackView)
        profileTopStackView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().dividedBy(2)
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        bioTextView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
        
        tableViewButtonStackView.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width)
        }
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(profileTopStackView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
