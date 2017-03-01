//
//  ReviewTableViewCell.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Cosmos
import SnapKit

class ReviewTableViewCell: UITableViewCell {

    var usernameLabel: UILabel!
    var ratingView: CosmosView!
    var dateLabel: UILabel!
    var ratingDateStackView: UIStackView!
    var descriptionTextView: UITextView!
    
    var review: Review!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        usernameLabel = UILabel(text: "Cherry Dude")
        usernameLabel.font = UIFont.mammaFoodieFontBold(14)
        ratingView = CosmosView()
        ratingView.settings.starSize = 12
        dateLabel = UILabel(text: "Feb 29, 2016")
        dateLabel.font = UIFont.mammaFoodieFont(12)
        descriptionTextView = UITextView()
        descriptionTextView.text = loremIpsumString
        descriptionTextView.font = UIFont.mammaFoodieFont(12)
        
        
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setConstraints() {
        ratingDateStackView = UIStackView(arrangedSubviews: [ratingView, dateLabel])
        ratingDateStackView.axis = .horizontal
        ratingDateStackView.alignment = .center
        ratingDateStackView.distribution = .fillEqually
        ratingDateStackView.spacing = 5
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(5)
        }
        
        ratingDateStackView.snp.makeConstraints { (make) in
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.left.equalTo(usernameLabel)
        }
        
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(ratingDateStackView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.left.equalTo(usernameLabel)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}