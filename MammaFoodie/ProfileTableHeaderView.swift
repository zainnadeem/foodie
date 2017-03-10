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

extension UISearchBar {
    
    private func getViewElement<T>(type: T.Type) -> T? {
        
        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    
    func setTextFieldColor(color: UIColor) {
        
        if let textField = getViewElement(type: UITextField.self) {
            switch searchBarStyle {
            case .minimal:
                textField.layer.backgroundColor = color.cgColor
                textField.layer.cornerRadius = 6
                
            case .prominent, .default:
                textField.backgroundColor = color
            }
        }
    }
}

protocol TableViewHeaderDelegate: class {
    
    func didEnterSearchTerm()
    
}
