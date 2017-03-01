//
//  ProfileTableHeaderView.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    weak var delegate: TableViewHeaderDelegate?
    
    var searchBar: UISearchBar!
    
    @IBAction func didEnterSearchTerm(_ sender: AnyObject) {
        delegate?.didEnterSearchTerm()
    }
    

}

protocol TableViewHeaderDelegate: class {
    
    static var buttonIndex: Int { get set }
    
    func didEnterSearchTerm()
    
}
