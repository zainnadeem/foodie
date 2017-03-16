//
//  PaymentView.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/16/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit

class PaymentView: UIView {

    lazy var paymentLabel = UILabel(text: "Payment Info")
    lazy var deliveryLabel = UILabel(text: "Delivery Info")
    var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        paymentLabel.font = UIFont.mammaFoodieFontBold(14)
        paymentLabel.textAlignment = .center
        paymentLabel.backgroundColor = UIColor.flatSkyBlue
        deliveryLabel.font = UIFont.mammaFoodieFontBold(14)
        deliveryLabel.textAlignment = .center
        deliveryLabel.backgroundColor = UIColor.flatMint
        
        stackView = UIStackView(arrangedSubviews: [paymentLabel, deliveryLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
