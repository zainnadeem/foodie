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
        
        for view in searchBar.subviews {
            for subview in view.subviews {
                if subview.isKind(of: UITextField.self) {
                    let textField: UITextField = subview as! UITextField
                    textField.layer.backgroundColor = UIColor.green.cgColor
                }
            }
        }
        
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
