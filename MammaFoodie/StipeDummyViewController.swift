//
//  StipeDummyViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/16/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class StipeDummyViewController: UIViewController {

    
    var user: User?
    var dishesToSearch = [Dish]()
    let store = DataStore.sharedInstance
    
    lazy var navBar : NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: nil, middleButtonImage: nil)
    
    lazy var searchBar: UISearchBar = UISearchBar()
    
    lazy var tableView: UITableView = UITableView()
    
    var presentingVC:    ScheduleBroadcastViewController?
    
    let settingsVC = StripeSettingsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        navBar.middleButton.title = "Add Dish"
        navBar.leftButton.title = "back"
        
        user = self.store.currentUser
        
        
        let dish1 = Dish.init(uid: "1", name: "chicken wings", description: "bacon", mainImage: nil, price: Int(12.00), likedBy: [], averageRating: 3)
        let dish2 = Dish.init(uid: "1", name: "homemade pizza", description: "marinara", mainImage: nil, price: Int(12.00), likedBy: [], averageRating: 3)
        let dish3 = Dish.init(uid: "1", name: "cookies", description: "chocolate", mainImage: nil, price: Int(9.00), likedBy: [], averageRating: 3)
        
        dishesToSearch = [dish1, dish2, dish3]
        
        
        //dishesToSearch = self.store.currentUser.dishes
        
        setViewConstraints()
        
        self.navBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self


        
        self.tableView.register(DishTableViewCell.self, forCellReuseIdentifier: dishCellIdentifier)
      
        
    }
    
    
    func setViewConstraints() {
        
        self.view.addSubview(navBar)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
    
    
}

extension StipeDummyViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return self.dishesToSearch.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: dishCellIdentifier, for: indexPath) as! DishTableViewCell
        
        var dish: Dish
        

            dish = self.dishesToSearch[indexPath.row]

        cell.dish = dish
        
        return cell
    }
}

extension StipeDummyViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var dish: Dish
        

        dish = self.dishesToSearch[indexPath.row]

        
        let product = dish.name
        let price = dish.price
        
        let checkoutViewController = CheckoutViewController(product: product,
                                                            price: price,
                                                            settings: self.settingsVC.settings)
        
        self.navigationController?.pushViewController(checkoutViewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  self.view.bounds.width / 4
    }
    
}


extension StipeDummyViewController : NavBarViewDelegate {
    
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
