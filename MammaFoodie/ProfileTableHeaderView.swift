//
//  ProfileTableHeaderView.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    weak var delegate: TableViewHeaderDelegate?
    
    lazy var searchBar = UISearchBar()
    lazy var addItemButton = UIButton(type: .system)
    
    
    func didEnterSearchTerm(_ sender: AnyObject) {
        delegate?.didEnterSearchTerm()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(searchBar)
        searchBar.searchBarStyle = .minimal
        searchBar.isHidden = true
        
        addItemButton.setTitle("+", for: .normal)
        addItemButton.titleLabel?.font = UIFont.mammaFoodieFont(30)
        self.contentView.addSubview(addItemButton)
        setConstraints()
        
    }
    
    func setConstraints() {
        searchBar.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        addItemButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.left.equalTo(searchBar.snp.right).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

protocol TableViewHeaderDelegate: class {
    
    func didEnterSearchTerm()
    
}
