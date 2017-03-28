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

    lazy var usernameLabel = UILabel ()
    lazy var ratingView = CosmosView()
    lazy var dateLabel = UILabel()
    var ratingDateStackView: UIStackView!
    lazy var descriptionTextView = UITextView()
    
    var review: Review! {
        didSet {
            usernameLabel.text = review.reviewCreatedByUID
            ratingView.rating = Double(review.rating)
            dateLabel.text = review.createdTime
            descriptionTextView.text = loremIpsumString
//            descriptionTextView.text = review.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        usernameLabel.font = UIFont.mammaFoodieFont(14)
        ratingView.settings.starSize = 12
        dateLabel.font = UIFont.mammaFoodieFont(12)
        
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false
        descriptionTextView.font = UIFont.mammaFoodieFont(12)
        descriptionTextView.textContainerInset = .zero
        descriptionTextView.textContainer.lineFragmentPadding = 0
        
        ratingDateStackView = UIStackView(arrangedSubviews: [ratingView, dateLabel])
        ratingDateStackView.axis = .horizontal
        ratingDateStackView.alignment = .center
        ratingDateStackView.distribution = .fillEqually
        ratingDateStackView.spacing = 5
        
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setConstraints() {
       
        
        contentView.addSubview(usernameLabel)
        contentView.addSubview(ratingDateStackView)
        contentView.addSubview(descriptionTextView)
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
        }
        
        ratingDateStackView.snp.makeConstraints { (make) in
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.left.equalTo(usernameLabel)
        }
        
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(ratingDateStackView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.left.equalTo(usernameLabel)
            make.height.equalTo(30)
//            make.right.equalToSuperview().offset(10)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
