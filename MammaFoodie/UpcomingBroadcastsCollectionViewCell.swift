//
//  UpcomingBroadcastsCollectionViewCell.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage

class UpcomingBroadcastsCollectionViewCell: UICollectionViewCell {
 
    
    
    lazy var backgroundImageView    : UIImageView = UIImageView()
    lazy var topTitle               : UILabel     = UILabel()
    lazy var bottomTitle            : UILabel     = UILabel()
    lazy var darkView               : UIView      = UIView()
    lazy var broadcastTime          : UILabel     = UILabel()
    
    var ratingStars                 : CosmosView!
    var availabilityIcon            : UIImageView = UIImageView()
    
    let store = DataStore.sharedInstance
    
    
    var user: User! {
        
        didSet{
            
            self.updateUI()
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewConstraints()
        setViewProperties()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateUI(){
        
        topTitle.text = user.fullName
        bottomTitle.text = user.bio
        
        backgroundImageView.sd_setImage(with: URL(string: user.profileImageURL))
        backgroundImageView.contentMode = .scaleAspectFill
        
        ratingStars.rating = Double(user.averageRating)
        broadcastTime.text = "Today at 2:15"
        
        
    }
    
    func setViewConstraints(){
        
        self.contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.contentView.addSubview(darkView)
        darkView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        
 
        
        
        self.contentView.addSubview(topTitle)
        topTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(0.85)
            make.centerX.equalToSuperview()
            
        }
    
        self.contentView.addSubview(broadcastTime)
        broadcastTime.snp.makeConstraints { (make) in
            make.top.equalTo(topTitle.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.85)
            make.centerX.equalToSuperview()
    
        }
    
        self.contentView.addSubview(bottomTitle)
        bottomTitle.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalToSuperview().multipliedBy(0.85)
            make.centerX.equalToSuperview()
        }
        
        ratingStars = CosmosView()
        
        self.contentView.addSubview(ratingStars)
        ratingStars.snp.makeConstraints{ (make) in
            make.bottom.equalTo(bottomTitle.snp.top)
            make.centerX.equalToSuperview()
        }
        
    }
    
    func setViewProperties(){
        
        //background Image
        
        
        //darkview
        self.darkView.backgroundColor = UIColor.black
        self.darkView.alpha = 0.35
        
        //toptitle
        self.topTitle.font = UIFont.mammaFoodieFontBold(20)
        self.topTitle.adjustsFontSizeToFitWidth = true
        self.topTitle.textColor = UIColor.white
        self.topTitle.textAlignment = .center
        self.topTitle.text = "top title Not Set"
        
        //bottom
        self.bottomTitle.font = UIFont.mammaFoodieFont(20)
        self.bottomTitle.adjustsFontSizeToFitWidth = true
        self.bottomTitle.textColor = UIColor.white
        self.bottomTitle.textAlignment = .center
        self.bottomTitle.text = "bottom title Not Set"
        
        //rating
        ratingStars.settings.updateOnTouch = false
        ratingStars.settings.starSize = 12
        ratingStars.settings.filledColor = .white
        ratingStars.settings.emptyBorderColor = .white
        ratingStars.settings.filledBorderColor = .white
        
        
        //time icon
        self.broadcastTime.font = UIFont.mammaFoodieFontBold(10)
        self.broadcastTime.adjustsFontSizeToFitWidth = true
        self.broadcastTime.textColor = UIColor.white
        self.broadcastTime.textAlignment = .center
        self.broadcastTime.text = "bottom title Not Set"
        
        
        
    }
    
    
}


