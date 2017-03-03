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
    
    var searchBar: UISearchBar!
    
    func didEnterSearchTerm(_ sender: AnyObject) {
        delegate?.didEnterSearchTerm()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        searchBar = UISearchBar()
        self.contentView.addSubview(searchBar)
        searchBar.searchBarStyle = .minimal
                
        
        setConstraints()
        
    }
    
    func setConstraints() {
        searchBar.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    

}

protocol TableViewHeaderDelegate: class {
    
    static var buttonIndex: Int { get set }
    
    func didEnterSearchTerm()
    
}
