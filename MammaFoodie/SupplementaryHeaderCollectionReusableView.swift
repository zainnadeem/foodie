//
//  SupplementaryHeaderCollectionReusableView.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class SupplementaryHeaderCollectionReusableView: UICollectionReusableView {
    
    let headerLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLabel()
        
    }
    
    
    //////////////////////////////////////////////////////////////////////////////
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    
    }
    
    func setUpLabel(){
        
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
    }
    

        
}
