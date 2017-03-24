//
//  SelectDishViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/13/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class SelectDishViewController: UIViewController {
    
    var user: User?
    var dishesToSearch = [Dish]()
    var filteredDishes = [Dish]()
    
    
    let store = DataStore.sharedInstance
    
    lazy var navBar : NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: nil, middleButtonImage: nil)
    
    lazy var searchBar: UISearchBar = UISearchBar()
    
    lazy var tableView: UITableView = UITableView()
    
    var presentingVC:    ScheduleBroadcastViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        navBar.middleButton.title = "Add Dish"
        navBar.leftButton.title = "back"

        
        user = self.store.currentUser
        
        if let dishes = user?.dishes{
            dishesToSearch = dishes
        }

        
        setViewConstraints()
        
        self.navBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
        searchBar.searchBarStyle = .minimal
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white

        self.tableView.register(DishTableViewCell.self, forCellReuseIdentifier: dishCellIdentifier)
        searchBar.becomeFirstResponder()
        
    }
    
    
    func setViewConstraints() {
        
        self.view.addSubview(navBar)
        
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
    
    
}

extension SelectDishViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text != ""{
            return self.filteredDishes.count
        }else{
            return self.dishesToSearch.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: dishCellIdentifier, for: indexPath) as! DishTableViewCell
        
        var dish: Dish
        
        if searchBar.text != ""{
            dish = self.filteredDishes[indexPath.row]
        }else{
            dish = self.dishesToSearch[indexPath.row]
        }
        
        cell.dish = dish
        
        return cell
    }
}

extension SelectDishViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var dish: Dish
        
        if searchBar.text != ""{
            dish = self.filteredDishes[indexPath.row]
        }else{
            dish = self.dishesToSearch[indexPath.row]
        }
        
        searchBar.resignFirstResponder()
        
        presentingVC?.dishLabel.text = dish.name
        presentingVC?.dish = dish
        _ = navigationController?.popToViewController(self.presentingVC!, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  self.view.bounds.width / 4
    }
    
}

extension SelectDishViewController: UISearchBarDelegate {
    
    //Mark: Search
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredDishes = self.dishesToSearch.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.description.localizedCaseInsensitiveContains(searchText) }
        
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SelectDishViewController : NavBarViewDelegate {
    
    func rightBarButtonTapped(_ sender: AnyObject) {

        
    }
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        
        
        _ = navigationController?.popToViewController(self.presentingVC!, animated: true)
   
    }
    
    func middleBarButtonTapped(_ Sender: AnyObject) {
        let index = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: index, at: .top, animated: true)
    }
    
}

