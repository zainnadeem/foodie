//
//  SearchViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
//    var userForView: User?
//    var UsersToSearch = [User]()
//    var filteredUsers = [User]()
//    var selectedUser: User?
//    
//    lazy var navBar : NavBarView = NavBarView(withView: self.view, rightButtonImage: #imageLiteral(resourceName: "searchIcon"), leftButtonImage: #imageLiteral(resourceName: "icon-profile"), middleButtonImage: nil)
//    
//    lazy var searchBar: UISearchBar = UISearchBar()
//    
//    lazy var tableView: UITableView = UITableView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor.clear
//        view.isOpaque = false
//        searchBar.becomeFirstResponder()
//        
//        
//    }
//    
//    
//    func setViewConstraints() {
//        
//        self.view.addSubview(navBar)
//        
//        self.view.addSubview(searchBar)
//        searchBar.snp.makeConstraints { (make) in
//            make.top.equalTo(navBar.snp.bottom)
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.3)
//        }
//        
//        
//        self.view.addSubview(tableView)
//        tableView.snp.makeConstraints { (make) in
//            make.top.equalTo(searchBar.snp.bottom)
//            make.bottom.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//        }
//        
//        
//    }
//    
//
//    
//    
//    // Mark - UITableView
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searchBar.text != ""{
//            return self.filteredUsers.count
//        }else{
//            return self.UsersToSearch.count
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchUserTableViewCell
//        
//        var user: User
//        
//        if searchBar.text != ""{
//            user = self.filteredUsers[indexPath.row]
//        }else{
//            user = self.UsersToSearch[indexPath.row]
//        }
//        
//        cell.updateUI(user: user)
//        
//        return cell
//    }
//    
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        var user: User
//        
//        if searchBar.text != ""{
//            user = self.filteredUsers[indexPath.row]
//        }else{
//            user = self.UsersToSearch[indexPath.row]
//        }
//        
//        
//        searchBar.resignFirstResponder()
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    //Mark: Search
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        
//    }
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredUsers = self.UsersToSearch.filter { $0.fullName.localizedCaseInsensitiveContains(searchText) }
//        tableView.reloadData()
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        self.dismiss(animated: true, completion: nil)
//    }
    

    
}
