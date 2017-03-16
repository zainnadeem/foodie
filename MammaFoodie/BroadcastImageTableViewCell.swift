//
//  DishImageTableViewCell.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/15/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class BroadcastImageTableViewCell: UITableViewCell {

    lazy var titleLabel                  : UILabel     = UILabel()
    lazy var broadcastImageView          : UIImageView = UIImageView()
    
    lazy var leftStackView              : UIStackView = UIStackView()
    lazy var rightStackView             : UIStackView = UIStackView()
    
    lazy var borderWidth                  : CGFloat =       3.0
    lazy var profileImageHeightMultiplier : CGFloat =      (0.5)
    
    
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
        
    
        setImageViewCircular()
    }
    
    
    func setViewConstraints() {
        
        contentView.addSubview(broadcastImageView)
        broadcastImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(broadcastImageView.snp.height)
            make.left.equalToSuperview().offset(10)
        }
        
        contentView.addSubview(leftStackView)
        leftStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.left.equalTo(broadcastImageView.snp.right).offset(10)
        }
        
        contentView.addSubview(rightStackView)
        rightStackView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.height.equalToSuperview().multipliedBy(0.6)
            make.centerY.equalToSuperview()
        }
        
        
    }
    
    func setViewProperties(){

        titleLabel.font = UIFont.mammaFoodieFont(12)
        titleLabel.textColor = .darkGray
        titleLabel.text = "Cover Image"
        
        setImageViewCircular()

        
    }
    
    func createStackViews(){
        leftStackView = UIStackView(arrangedSubviews: [titleLabel])
        leftStackView.axis = .vertical
        leftStackView.distribution = .fillProportionally
        leftStackView.alignment = .leading
        
        
        rightStackView = UIStackView(arrangedSubviews: [])
        rightStackView.axis = .vertical
        rightStackView.distribution = .fillProportionally
        rightStackView.alignment = .center
        rightStackView.spacing = 2
    }
    
    func setImageViewCircular() {
        self.broadcastImageView.contentMode = .scaleAspectFill
        self.broadcastImageView.isUserInteractionEnabled = true
        self.broadcastImageView.layer.cornerRadius = self.frame.height * profileImageHeightMultiplier / 2
        self.broadcastImageView.layer.borderColor = UIColor.black.cgColor
        self.broadcastImageView.layer.borderWidth = borderWidth
        self.broadcastImageView.clipsToBounds = true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
