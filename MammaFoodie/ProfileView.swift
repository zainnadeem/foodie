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
import SDWebImage

//changes depending on which button was pressed
enum SelectedTableViewStatus {
    case menu, reviews, followers, following
}

class ProfileView: UIView, UITableViewDelegate {
    
    var profileTopStackView: UIStackView!
    lazy var profileImageView = UIImageView()
    lazy var ratingView = CosmosView()
    lazy var followButton = FollowButton()
    lazy var likesLabel = UILabel()
    lazy var bioTextView = UITextView()
    lazy var websiteTextView = UITextView()
    
    var menuButton: SegmentedControlButton!
    var reviewsButton: SegmentedControlButton!
    var followersButton: SegmentedControlButton!
    var followingButton: SegmentedControlButton!
    var lastTappedButton: SegmentedControlButton!
    var tableViewButtonStackView: UIStackView!
    var tableView: UITableView!
    var profileTableViewStatus: SelectedTableViewStatus = .menu
    
    weak var delegate: ProfileTableViewDelegate?
    
    var user: User! {
        didSet {
            let imageURL = URL(string: user.profileImageURL)
            profileImageView.sd_setImage(with: imageURL)
            ratingView.rating = user.averageRating
            likesLabel.text = "\(user.totalLikes) likes"
//            bioTextView.text = user.bio
            bioTextView.text = loremIpsumString
            websiteTextView.text = user.website
            if user === DataStore.sharedInstance.currentUser {
                self.followButton.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
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
        profileTableViewStatus = .menu
    }
    
}

//tableview button functions
extension ProfileView {
    
    func segmentedControlButtonTapped(sender: SegmentedControlButton) {
        lastTappedButton.isSelected = false
        sender.isSelected = true
        lastTappedButton = sender
        switch sender {
        case menuButton:
            profileTableViewStatus = .menu
        case reviewsButton:
            profileTableViewStatus = .reviews
        case followersButton:
            profileTableViewStatus = .followers
        case followingButton:
            profileTableViewStatus = .following
        default: print("should never reach here - segmentedControlButtonTapped")
        }
        self.delegate?.updateTableView(for: sender)
    }
    
}

//do all the auto layout here
extension ProfileView {
    func setupViewLayout() {
    
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.cornerRadius = 10
        profileImageView.clipsToBounds = true
        
        followButton.setTitle("Follow", for: .normal)
        
        likesLabel.text = "0 likes"
        likesLabel.font = UIFont.mammaFoodieFont(14)
        
        bioTextView.text = loremIpsumString
        bioTextView.isEditable = false
        
        websiteTextView.dataDetectorTypes = .link
        websiteTextView.isEditable = false
        websiteTextView.font = UIFont.mammaFoodieFont(12)
        websiteTextView.text = "mammafoodie.com"
        websiteTextView.backgroundColor = UIColor.clear
        websiteTextView.textAlignment = .center
        
        menuButton = SegmentedControlButton()
        menuButton.setTitle("Menu", for: .normal)
        menuButton.titleLabel?.textAlignment = .center
        menuButton.addTarget(self, action: #selector(segmentedControlButtonTapped(sender:)), for: .touchUpInside)
        reviewsButton = SegmentedControlButton()
        reviewsButton.setTitle("Reviews", for: .normal)
        reviewsButton.titleLabel?.textAlignment = .center
        reviewsButton.addTarget(self, action: #selector(segmentedControlButtonTapped(sender:)), for: .touchUpInside)
        followersButton = SegmentedControlButton()
        followersButton.setTitle("Followers", for: .normal)
        followersButton.titleLabel?.textAlignment = .center
        followersButton.addTarget(self, action: #selector(segmentedControlButtonTapped(sender:)), for: .touchUpInside)
        followingButton = SegmentedControlButton()
        followingButton.setTitle("Following", for: .normal)
        followingButton.titleLabel?.textAlignment = .center
        followingButton.addTarget(self, action: #selector(segmentedControlButtonTapped(sender:)), for: .touchUpInside)
        
        tableViewButtonStackView = UIStackView(arrangedSubviews: [menuButton, reviewsButton, followersButton, followingButton])
        tableViewButtonStackView.axis = .horizontal
        tableViewButtonStackView.distribution = .fillEqually
        self.addSubview(tableViewButtonStackView)
        
        
        profileTopStackView = UIStackView(arrangedSubviews: [profileImageView, ratingView, followButton, likesLabel, bioTextView, websiteTextView, tableViewButtonStackView])
        profileTopStackView.axis = .vertical
        profileTopStackView.distribution = .fill
        profileTopStackView.alignment = .center
        profileTopStackView.spacing = 5
        self.addSubview(profileTopStackView)
        profileTopStackView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().dividedBy(2.5)
            make.top.equalToSuperview().offset(84)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        followButton.snp.makeConstraints { (make) in
            make.width.equalTo(80)
        }

        bioTextView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
        
        websiteTextView.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalToSuperview()
        }
        
        tableViewButtonStackView.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width)
        }
        
        tableView = UITableView()
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(profileTopStackView.snp.bottom)
            make.bottom.width.centerX.equalToSuperview()
        }
    }
}

protocol ProfileTableViewDelegate: class {
    func updateTableView(for button: UIButton)
}

