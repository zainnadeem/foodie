//
//  ProfileViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SCLAlertView
import ChameleonFramework

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
        profileView = ProfileView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        profileView.tableView.delegate = self
        profileView.tableView.dataSource = self
        profileView.delegate = self
        self.view = profileView
        self.view.addSubview(navBar)
        makeDummyData()
        profileView.user = user
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
        
        user = store.currentUser
        
        let review1 = Review(description: "good", rating: 5, reviewCreatedByUID: "123", reviewForUID: "1234")
        user.reviews.append(review1)
        user.reviews.append(review1)
        arrayForTableView = user.dishes
        
        let otherUser1 = User(uid: "123", username: "sulu_candles", fullName: "Sulu Candles", email: "sulu@gmail.com", profileImageURL: "google.com")
        let otherUser2 = User(uid: "456", username: "ghee_buttersnaps", fullName: "Ghee Buttersnaps", email: "ghee@gmail.com", profileImageURL: "wikipedia.org")
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
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false,
                hideWhenBackgroundViewIsTapped: true
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Edit") {
                print("edit button tapped")
            }
            alertView.addButton("Delete", backgroundColor: FlatRed(), textColor: .white, showDurationStatus: false, action: { 
                print("delete button tapped")
            })
            alertView.showEdit(cell.dish.name, subTitle: cell.dish.description)

//            alertView.nameLabel.text = cell.dish.name
//            view.addSubview(alertView)
//            alertView.snp.makeConstraints({ (make) in
//                make.edges.equalToSuperview()
//            })
//            alertView.alpha = 0
//            UIView.animate(withDuration: 0.4) {
//                self.alertView.alpha = 1
//            }
//            let hideGesture = UITapGestureRecognizer(target: self, action: #selector(hideAlertView))
//            alertView.backGroundView.addGestureRecognizer(hideGesture)
            
        }
    }
    
//    func hideAlertView() {
//        UIView.animate(withDuration: 0.2) { 
//            self.alertView.alpha = 0
//        }
//        
//    }
    
    func blockUserTapped(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            print ("block user tapped")
            let cell = sender.view as! UserTableViewCell
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false,
                hideWhenBackgroundViewIsTapped: true
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Block", backgroundColor: FlatRed(), textColor: .white, showDurationStatus: false, action: {
                print("block button tapped")
                if let followingIndex = self.store.currentUser.follows.index(where: { $0 === cell.user }) {
                    self.store.currentUser.follows.remove(at: followingIndex)
                }
                if let followedIndex = self.store.currentUser.followedBy.index(where: { $0 === cell.user }) {
                    self.store.currentUser.followedBy.remove(at: followedIndex)
                }
                self.store.currentUser.blockedUsers.append(cell.user)
                
            })
            alertView.showWarning(cell.user.username, subTitle: "(\(cell.user.fullName))")
        }
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
