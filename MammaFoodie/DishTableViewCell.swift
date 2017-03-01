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
    
    var dishImageView: UIImageView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var titleDescriptionStackView: UIStackView!
    var ratingView: CosmosView!
    var priceLabel: UILabel!
    var priceRatingStackView: UIStackView!
    var dish: Dish!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //        dishImageView = UIImageView(image: dish.mainImage)
        //        titleLabel = UILabel(text: dish.name)
        //        descriptionLabel = UILabel(text: dish.description)
        //        ratingView = CosmosView()
        //        priceLabel = UILabel(text: String(dish.price))
        dishImageView = UIImageView(image: UIImage(named: "profile_placeholder"))
        titleLabel = UILabel(text: "Buffalo Chicken Fingers")
        titleLabel.font = UIFont.mammaFoodieFontBold(14)
        descriptionLabel = UILabel(text: "Packed with blue cheese, carrots, celery, and lots of other delicious stuff that is getting truncated")
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.font = UIFont.mammaFoodieFont(12)
        ratingView = CosmosView()
        ratingView.text = "(3)"
        ratingView.settings.starSize = 15
        priceLabel = UILabel(text: "$12.34")
        priceLabel.font = UIFont.mammaFoodieFont(14)
        
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setConstraints() {
        
//        contentView.addSubview(dishImageView)
        titleDescriptionStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        contentView.addSubview(titleDescriptionStackView)
        priceRatingStackView = UIStackView(arrangedSubviews: [priceLabel, ratingView])
        contentView.addSubview(priceRatingStackView)
        
        titleDescriptionStackView.axis = .vertical
        titleDescriptionStackView.distribution = .fillProportionally
        titleDescriptionStackView.alignment = .leading
        
        priceRatingStackView.axis = .vertical
        priceRatingStackView.distribution = .fillProportionally
        priceRatingStackView.alignment = .trailing
        ratingView.setContentCompressionResistancePriority(1000, for: .horizontal)
        
        
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
