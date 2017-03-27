//
//  AddressTableViewCell.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/6/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    lazy var titleLabel                    : UILabel     = UILabel()
    lazy var addressLabel                  : UILabel     = UILabel()
    lazy var phoneNumberLabel              : UILabel     = UILabel()
    
    lazy var leftStackView              : UIStackView = UIStackView()

    lazy var checkButton                : UIButton = UIButton()
    
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
        
        checkButton.backgroundColor = .white
        checkButton.layer.cornerRadius = 15
        checkButton.titleLabel?.textColor = .white
        
        createStackViews()
        setViewConstraints()
        setViewProperties()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func updateUIWithAddress(){
        guard let address = self.address else { return }
        
        titleLabel.text = address.title
        var aptSuite = ""
        if address.aptSuite != "" { aptSuite = " \(address.aptSuite)" }
        addressLabel.text = "\(address.addressLine)\(aptSuite), \(address.city), \(address.state) \(address.postalCode)"
        phoneNumberLabel.text = address.phone
        
    }
    
    
    func updateUIWithPayment(){

    }
    
    func setViewConstraints() {
        
        contentView.addSubview(leftStackView)
        leftStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.left.equalToSuperview().offset(20)
        }
        
        contentView.addSubview(checkButton)
        checkButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(30)
        }
        
    }
    
    func setViewProperties(){
        
        titleLabel.font = UIFont.mammaFoodieFontBold(14)
        titleLabel.textColor = .black
        
        addressLabel.font = UIFont.mammaFoodieFont(14)
        addressLabel.textColor = .black
        
        phoneNumberLabel.font = UIFont.mammaFoodieFont(12)
        phoneNumberLabel.textColor = .black
        
        
    }
    
    func createStackViews(){
        leftStackView = UIStackView(arrangedSubviews: [titleLabel, addressLabel, phoneNumberLabel])
        leftStackView.axis = .vertical
        leftStackView.distribution = .fillProportionally
        leftStackView.alignment = .leading
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
