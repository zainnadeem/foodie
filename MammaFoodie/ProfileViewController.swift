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
        user = User()
        let dish1 = Dish(uid: "111", name: "pizza", description: "delicious", mainImage: UIImage(), price: 10, likedBy: [], averageRating: 0)
        user.dishes.append(dish1)
        
        let review1 = Review(description: "good", rating: 5, reviewCreatedByUID: "123", reviewForUID: "1234")
        user.reviews.append(review1)
        user.reviews.append(review1)
        arrayForTableView = user.dishes
        
        profileView.tableView.register(DishTableViewCell.self, forCellReuseIdentifier: dishCellIdentifier)
        
    }


}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("TableView array count: \(arrayForTableView.count)")
        return arrayForTableView.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DishTableViewCell = tableView.dequeueReusableCell(withIdentifier: dishCellIdentifier) as! DishTableViewCell
        cell.dish = user.dishes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension ProfileViewController: ProfileTableViewDelegate {
    func updateTableView(for button: UIButton) {
        switch profileView.profileTableViewStatus {
        case .menu: arrayForTableView = user.dishes
        case .reviews: arrayForTableView = user.reviews
        case .followers: arrayForTableView = user.followedBy
        case .following: arrayForTableView = user.follows
        }
        
        profileView.tableView.reloadData()
        
    }
}
