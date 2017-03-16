//
//  ProfileViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //NavBar
    lazy var navBar : NavBarView = NavBarView(withView: self.view, rightButtonImage: #imageLiteral(resourceName: "home_icon"), leftButtonImage: #imageLiteral(resourceName: "settings"), middleButtonImage: nil)
    
    var profileView: ProfileView!
    var user: User!
    var arrayForTableView: [Any]!
    var filteredArray: [Any]!
    let alertView = DishAlertView()
    
    let store = DataStore.sharedInstance
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.delegate = self
        
        
        profileView = ProfileView(user: user, frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        profileView.tableView.delegate = self
        profileView.tableView.dataSource = self
        profileView.delegate = self
        self.view = profileView
        self.view.addSubview(navBar)
        makeDummyData()
        navBar.middleButton.title = user.username
        
        profileView.tableView.register(DishTableViewCell.self, forCellReuseIdentifier: dishCellIdentifier)
        profileView.tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: reviewCellIdentifier)
        profileView.tableView.register(UserTableViewCell.self, forCellReuseIdentifier: followCellIdentifier)
        profileView.tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: profileHeaderIdentifier)
        
    }
    
    func showAddDishVC() {
        let addDishVC = AddDishViewController()
        addDishVC.sendingViewController = self
        self.present(addDishVC, animated: true, completion: nil)
    }
    
    fileprivate func makeDummyData() {

//        user = User(uid: "123456", username: "carrot_slat", fullName: "Carrot Slat", email: "carrot@slat.com", bio: "sup", website: "mammafoodie.com", location: "Long Beach", follows: [], followedBy: [], profileImageURL: store.currentUser.profileImageURL, dishes: [], reviews: [], notifications: [], broadcasts: [], blockedUsers: [], totalLikes: 500, averageRating: 5, deviceTokens: [], isAvailable: true, tags: ["carrots, chocolate, Indian, Meatballs"], addresses: [])
//        let dish1 = Dish(uid: "111", name: "pizza", description: "delicious", mainImage: UIImage(), price: 10, likedBy: [], averageRating: 0)
//        user.dishes.append(dish1)
        
        user = store.currentUser
        
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
        return arrayForTableView.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch profileView.profileTableViewStatus {
        case .menu: cell = tableView.dequeueReusableCell(withIdentifier: dishCellIdentifier) as! DishTableViewCell
            (cell as! DishTableViewCell).dish = user.dishes[indexPath.row]
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(deleteDishTapped))
            cell.addGestureRecognizer(longPressGesture)
        case .reviews: cell = tableView.dequeueReusableCell(withIdentifier: reviewCellIdentifier) as! ReviewTableViewCell
            (cell as! ReviewTableViewCell).review = user.reviews[indexPath.row]
        case .followers: cell = tableView.dequeueReusableCell(withIdentifier: followCellIdentifier) as! UserTableViewCell
            (cell as! UserTableViewCell).user = user.followedBy[indexPath.row]
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(blockUserTapped))
            cell.addGestureRecognizer(longPressGesture)
        case .following: cell = tableView.dequeueReusableCell(withIdentifier: followCellIdentifier) as! UserTableViewCell
            (cell as! UserTableViewCell).user = user.follows[indexPath.row]
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(blockUserTapped))
            cell.addGestureRecognizer(longPressGesture)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch profileView.profileTableViewStatus {
        case .menu:
            let purchaseDishVC = PurchaseDishViewController()
            purchaseDishVC.dish = self.user.dishes[indexPath.row]
            self.present(purchaseDishVC, animated: true, completion: nil)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: profileHeaderIdentifier) as! ProfileTableHeaderView
        headerView.addItemButton.addTarget(self, action: #selector(showAddDishVC), for: .touchUpInside)
        switch profileView.profileTableViewStatus {
        case .reviews, .followers, .following: headerView.addItemButton.isHidden = true
        default: headerView.addItemButton.isHidden = false
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch profileView.profileTableViewStatus {
        case .menu: return 75
        case .reviews: return 120
        case .followers, .following: return 60
        }
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
//            self.user.dishes.remove(at: indexPath.row)
//            print("delete action tapped!")
//        }
//        
//        let blockFollower = UITableViewRowAction(style: .destructive, title: "Block") { (action, index) in
//            self.user.blockedUsers.append(self.user.followedBy[indexPath.row])
//            print("blockFollower action tapped!")
//        }
//        
//        let blockFollowing = UITableViewRowAction(style: .destructive, title: "Block") { (action, index) in
//            self.user.blockedUsers.append(self.user.follows[indexPath.row])
//            print("blockFollowing action tapped!")
//        }
//        
//        switch profileView.profileTableViewStatus {
//        case .menu: return [delete]
//        case .reviews: return nil
//        case .followers: return [blockFollower]
//        case .following: return [blockFollowing]
//        }
//    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        switch profileView.profileTableViewStatus {
//        case .reviews: return false
//        case .menu, .followers, .following: return true
//        }
//        return true
//    }
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        
//    }
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

//Long press gesture handlers for TableView cells
extension ProfileViewController {
    
    func deleteDishTapped(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            print ("delete dish tapped")
            let cell = sender.view as! DishTableViewCell
            alertView.nameLabel.text = cell.dish.name
            
            view.addSubview(alertView)
            alertView.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            alertView.alpha = 0
            UIView.animate(withDuration: 0.4) {
                self.alertView.alpha = 1
            }
            let hideGesture = UITapGestureRecognizer(target: self, action: #selector(hideAlertView))
            alertView.backGroundView.addGestureRecognizer(hideGesture)
        }
    }
    
    func hideAlertView() {
        UIView.animate(withDuration: 0.2) { 
            self.alertView.alpha = 0
        }
        
    }
    
    func blockUserTapped() {
        print ("block user tapped")
    }
}

//NavBar
extension ProfileViewController : NavBarViewDelegate {
    
    func rightBarButtonTapped(_ sender: AnyObject) {
        if let pageVC = self.parent as? UserPageViewController {
            pageVC.navigateToMainFeedViewController(.forward)
        }
    }
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        if let pageVC = self.parent as? UserPageViewController {
            pageVC.navigateToSettingsViewController(.reverse)
        }
    }
    
    func middleBarButtonTapped(_ Sender: AnyObject) {
        
        let scheduleBroadcastVC = ScheduleBroadcastViewController()
        self.navigationController?.pushViewController(scheduleBroadcastVC, animated: true)
        
    }
    
}

extension ProfileViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = user.dishes.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
        
        
        profileView.tableView.reloadData()
    }
}
