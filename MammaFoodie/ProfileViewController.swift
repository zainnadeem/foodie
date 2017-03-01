//
//  ProfileViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileView: ProfileView!
    var user: User!
    var arrayForTableView: [Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView = ProfileView(user: User(), frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        profileView.tableView.delegate = self
        profileView.tableView.dataSource = self
        profileView.delegate = self
        self.view = profileView
        user = profileView.user
        arrayForTableView = user.dishes
        
    }


}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

extension ProfileViewController: ProfileTableViewDelegate {
    func updateTableView(for button: UIButton) {
        profileView.profileTableViewStatus = .menu
        switch profileView.profileTableViewStatus {
        case .menu: arrayForTableView = user.dishes
        case .reviews: arrayForTableView = user.reviews
        case .followers: arrayForTableView = user.followedBy
        case .following: arrayForTableView = user.follows
        }
        
        profileView.tableView.reloadData()
        
    }
}
