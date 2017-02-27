//
//  ProfileView.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Cosmos
import SnapKit
import ChameleonFramework

class ProfileView: UIView {
    
    let user: User
    
    var profileImageView: UIImageView!
    var ratingView: CosmosView!
    var followButton: UIButton?
    var likesLabel: UILabel!
    var bioTextView: UITextView?
    var websiteLabel: UILabel?
    
    var tableViewControl: UISegmentedControl!
    var tableView: UITableView!
    
    init(user: User, frame: CGRect) {
        self.user = user
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.user = User()
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        setupViewLayout()
    }
    
    func setupViewLayout() {
        self.backgroundColor = FlatSkyBlue()
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().dividedBy(2)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
}

extension ProfileView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
