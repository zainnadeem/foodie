//
//  DishTableViewCell.swift
//  
//
//  Created by Haaris Muneer on 2/27/17.
//
//

import UIKit
import Cosmos
import SnapKit

class DishTableViewCell: UITableViewCell {
    
    lazy var dishImageView = UIImageView()
    lazy var titleLabel = UILabel()
    lazy var descriptionLabel = UILabel()
    lazy var titleDescriptionStackView = UIStackView()
    lazy var ratingView = CosmosView()
    lazy var priceLabel = UILabel()
    lazy var priceRatingStackView =  UIStackView()

    var dish: Dish! {
        didSet {
            dishImageView.image = dish.mainImage
            titleLabel.text = dish.name
            descriptionLabel.text = dish.description
            let priceAsString = String(dish.price)
            priceLabel.text = priceAsString.convertPriceInCentsToDollars()
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpLayout() {
        dishImageView = UIImageView(image: UIImage(named: "profile_placeholder"))
        //        titleLabel = UILabel(text: "Buffalo Chicken Fingers")
        titleLabel.font = UIFont.mammaFoodieFont(14)
        //        descriptionLabel = UILabel(text: "Packed with blue cheese, carrots, celery, and lots of other delicious stuff that is getting truncated")
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.font = UIFont.mammaFoodieFont(12)
        ratingView = CosmosView()
        ratingView.text = "(3)"
        ratingView.settings.starSize = 12
        ratingView.setContentCompressionResistancePriority(1000, for: .horizontal)
        //        priceLabel = UILabel(text: "$12.34")
        priceLabel.font = UIFont.mammaFoodieFont(14)
        
        titleDescriptionStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        titleDescriptionStackView.axis = .vertical
        titleDescriptionStackView.distribution = .fillProportionally
        titleDescriptionStackView.alignment = .leading
        
        priceRatingStackView = UIStackView(arrangedSubviews: [priceLabel, ratingView])
        priceRatingStackView.axis = .vertical
        priceRatingStackView.distribution = .fillProportionally
        priceRatingStackView.alignment = .trailing
        
        
        
        setConstraints()
    }
    
    func setConstraints() {
        
//        contentView.addSubview(dishImageView)
        contentView.addSubview(titleDescriptionStackView)
        contentView.addSubview(priceRatingStackView)
        
//        dishImageView.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.75)
//            make.width.equalTo(dishImageView.snp.height)
//            make.left.equalToSuperview().offset(10)
//        }
        
        titleDescriptionStackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(priceRatingStackView.snp.left)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
        priceRatingStackView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
            make.left.equalTo(titleDescriptionStackView.snp.right)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
