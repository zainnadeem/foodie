//
//  AddressTableViewCell.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/6/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    lazy var rightTopLabel                  : UILabel     = UILabel()
    lazy var rightMiddleLabel               : UILabel     = UILabel()
    lazy var rightBottomLabel               : UILabel     = UILabel()
    
    lazy var leftTopLabel                  : UILabel     = UILabel()
    lazy var leftMiddleLabel               : UILabel     = UILabel()
    lazy var leftBottomLabel               : UILabel     = UILabel()
    
    lazy var leftStackView              : UIStackView = UIStackView()
    lazy var rightStackView             : UIStackView = UIStackView()
    
    var address: Address?

    var user: User! {
        didSet {
            
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
    
    
    func updateUIWithAddress(){
        guard let address = self.address else { return }
        
        leftTopLabel.text = address.title
        leftMiddleLabel.text = address.phone
        
        rightTopLabel.text = "\(address.addressLine), \(address.aptSuite)"
        rightMiddleLabel.text = "\(address.city), \(address.state)"
        rightBottomLabel.text = "\(address.postalCode)"
    }
    
    
    func updateUIWithPayment(){

    }
    
    func setViewConstraints() {
        
        contentView.addSubview(leftStackView)
        leftStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.left.equalToSuperview().offset(5)
        }
        
        contentView.addSubview(rightStackView)
        rightStackView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.height.equalToSuperview().multipliedBy(0.6)
            make.centerY.equalToSuperview()
        }
        
        
    }
    
    func setViewProperties(){
        //right side
        rightTopLabel.font = UIFont.mammaFoodieFontBold(14)
        rightTopLabel.textColor = .black
        
        rightMiddleLabel.font = UIFont.mammaFoodieFontBold(12)
        rightMiddleLabel.textColor = .black
        
        rightBottomLabel.font = UIFont.mammaFoodieFontBold(10)
        rightBottomLabel.textColor = .black
        
        //right side
        leftTopLabel.font = UIFont.mammaFoodieFontBold(14)
        leftTopLabel.textColor = .black
        
        leftMiddleLabel.font = UIFont.mammaFoodieFontBold(12)
        leftMiddleLabel.textColor = .black
        
        leftBottomLabel.font = UIFont.mammaFoodieFontBold(10)
        leftBottomLabel.textColor = .black
        
        
    }
    
    func createStackViews(){
        leftStackView = UIStackView(arrangedSubviews: [leftTopLabel, leftMiddleLabel, leftBottomLabel])
        leftStackView.axis = .vertical
        leftStackView.distribution = .fillProportionally
        leftStackView.alignment = .leading
        
        
        rightStackView = UIStackView(arrangedSubviews: [rightTopLabel, rightMiddleLabel, rightBottomLabel])
        rightStackView.axis = .vertical
        rightStackView.distribution = .fillProportionally
        rightStackView.alignment = .trailing
        rightStackView.spacing = 2
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
