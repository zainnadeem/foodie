//
//  DishAlertView.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/3/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit
import ChameleonFramework

class DishAlertView: UIView {
    
    var contentView: UIView!
    var nameLabel: UILabel!
    var editButton: UIButton!
    var deleteButton: UIButton!
    var buttonStackView: UIStackView!
    var backGroundView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setConstraints()
    }
    
    fileprivate func addViews() {
        
        backGroundView = UIView()
        backGroundView.alpha = 0.6
        backGroundView.backgroundColor = UIColor.black
        self.addSubview(backGroundView)
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 15
        self.addSubview(contentView)
        
        nameLabel = UILabel(text: "Test Dish")
        nameLabel.font = UIFont.mammaFoodieFont(36)
        nameLabel.textColor = UIColor.black
        contentView.addSubview(nameLabel)
        
        editButton = UIButton(type: .system)
        editButton.setTitle("Edit", for: .normal)
        editButton.backgroundColor = FlatSkyBlueDark()
        editButton.titleLabel?.font = UIFont.mammaFoodieFont(18)
        editButton.setTitleColor(FlatWhite(), for: .normal)
        editButton.layer.cornerRadius = 5
        deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.backgroundColor = FlatRed()
        deleteButton.titleLabel?.font = UIFont.mammaFoodieFont(18)
        deleteButton.setTitleColor(FlatWhite(), for: .normal)
        deleteButton.layer.cornerRadius = 5
        
        buttonStackView = UIStackView(arrangedSubviews: [editButton, deleteButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        buttonStackView.spacing = 10
        contentView.addSubview(buttonStackView)
    }
    
    fileprivate func setConstraints() {
        backGroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.75)
        }
        
        buttonStackView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.65)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    

}
