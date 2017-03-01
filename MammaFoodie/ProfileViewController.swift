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
        makeDummyData()
        
        profileView.tableView.register(DishTableViewCell.self, forCellReuseIdentifier: dishCellIdentifier)
        profileView.tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: reviewCellIdentifier)
        profileView.tableView.register(UserTableViewCell.self, forCellReuseIdentifier: followCellIdentifier)
        
    }
    
    fileprivate func makeDummyData() {
        user = User()
        let dish1 = Dish(uid: "111", name: "pizza", description: "delicious", mainImage: UIImage(), price: 10, likedBy: [], averageRating: 0)
        user.dishes.append(dish1)
        
        let review1 = Review(description: "good", rating: 5, reviewCreatedByUID: "123", reviewForUID: "1234")
        user.reviews.append(review1)
        user.reviews.append(review1)
        arrayForTableView = user.dishes
        
        let otherUser1 = User()
        let otherUser2 = User()
        user.follows.append(otherUser1)
        user.follows.append(otherUser2)
        user.followedBy.append(otherUser1)
        user.followedBy.append(otherUser2)
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
        let cell: UITableViewCell
        switch profileView.profileTableViewStatus {
        case .menu: cell = tableView.dequeueReusableCell(withIdentifier: dishCellIdentifier) as! DishTableViewCell
            (cell as! DishTableViewCell).dish = user.dishes[indexPath.row]
        case .reviews: cell = tableView.dequeueReusableCell(withIdentifier: reviewCellIdentifier) as! ReviewTableViewCell
            (cell as! ReviewTableViewCell).review = user.reviews[indexPath.row]
        case .followers: cell = tableView.dequeueReusableCell(withIdentifier: followCellIdentifier) as! UserTableViewCell
            (cell as! UserTableViewCell).user = user.followedBy[indexPath.row]
        case .following: cell = tableView.dequeueReusableCell(withIdentifier: followCellIdentifier) as! UserTableViewCell
            (cell as! UserTableViewCell).user = user.follows[indexPath.row]

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch profileView.profileTableViewStatus {
        case .menu: return 75
        case .reviews: return 120
        case .followers, .following: return 60
        }
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
