//
//  FormTableViewHeaderView.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/10/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit

class FormTableViewHeaderView: UITableViewHeaderFooterView {
    
    lazy var label = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(label)
        label.font = UIFont.mammaFoodieFontBold(15)
        label.textAlignment = .center
        
        label.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.left.equalToSuperview()
            make.height.equalTo(35)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
