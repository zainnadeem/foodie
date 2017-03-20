//
//  FloatingCartView.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/17/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit

class FloatingCartView: UIView {
    
    lazy var cartTotalLabel = UILabel()
    lazy var viewOrderLabel = UILabel(text: "View Order")
    lazy var numberOfItemsLabel = UILabel()
    
    let store = DataStore.sharedInstance
    let labelHeight = 30

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.flatRedDark
        
        setViewProperties()
        setViewConstraints()
        
    }
    
    func setViewProperties() {
        cartTotalLabel.font = UIFont.mammaFoodieFontBold(14)
        cartTotalLabel.textColor = .white
        cartTotalLabel.textAlignment = .center
        
        viewOrderLabel.font = UIFont.mammaFoodieFontBold(16)
        viewOrderLabel.textColor = .white
        viewOrderLabel.textAlignment = .center
        
        numberOfItemsLabel.backgroundColor = .clear
        numberOfItemsLabel.font = UIFont.mammaFoodieFontBold(14)
        numberOfItemsLabel.textColor = .white
        numberOfItemsLabel.layer.borderWidth = 1.5
        numberOfItemsLabel.layer.borderColor = UIColor.white.cgColor
        numberOfItemsLabel.layer.cornerRadius = 5
        numberOfItemsLabel.textAlignment = .center
        
    }
    
    func updateLabels() {
        cartTotalLabel.text = store.currentUser.calculateCartTotal()
        numberOfItemsLabel.text = "\(store.currentUser.cart.count)"
    }
    
    func setViewConstraints() {
        self.addSubview(cartTotalLabel)
        cartTotalLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        self.addSubview(viewOrderLabel)
        viewOrderLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        self.addSubview(numberOfItemsLabel)
        numberOfItemsLabel.snp.makeConstraints { (make) in
            make.height.width.equalTo(labelHeight)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
