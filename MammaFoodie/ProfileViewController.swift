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
    var navBar : NavBarView!
    
    var profileView: ProfileView!
    var user: User!
    var arrayForTableView: [Any]!
    var filteredArray: [Any]!
    
    let store = DataStore.sharedInstance
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        OperationQueue.main.addOperation {
            self.user = self.store.currentUser
            self.user.dishes = self.store.currentUser.dishes
            self.profileView.tableView.reloadData()
        }
        
        if let pageVC = self.parent as? UserPageViewController {
            pageVC.setUpCartView()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        
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
        
        let review1 = Review(description: "good", rating: 5, reviewCreatedByUID: "123", reviewForUID: "1234")
        user.reviews.append(review1)
        user.reviews.append(review1)
        arrayForTableView = user.dishes
        
        let otherUser1 = User(uid: "123", username: "sulu_candles", fullName: "Sulu Candles", email: "sulu@gmail.com", profileImageURL: "https://firebasestorage.googleapis.com/v0/b/mamma-foodie.appspot.com/o/images%2Fwearing-apron-in-the-kitchen.jpg?alt=media&token=2c903cc7-f143-4bab-bdc5-9a48ebd50d2e")
        let otherUser2 = User(uid: "456", username: "ghee_buttersnaps", fullName: "Ghee Buttersnaps", email: "ghee@gmail.com", profileImageURL: "https://firebasestorage.googleapis.com/v0/b/mamma-foodie.appspot.com/o/images%2Fimages.jpg?alt=media&token=89af4243-8189-4039-949b-5047e5cc9602")
        user.follows.append(otherUser1)
        user.follows.append(otherUser2)
        user.followedBy.append(otherUser1)
        user.followedBy.append(otherUser2)
    }

    func setUpNavBar() {
        if let pageVC = self.parent as? UserPageViewController {
            self.navBar = NavBarView(withView: self.view, rightButtonImage: #imageLiteral(resourceName: "home_icon"), leftButtonImage: #imageLiteral(resourceName: "settings"), middleButtonImage: nil)
        }
        else {
            self.navBar = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "back_arrow"), middleButtonImage: nil)
            self.navBar.leftButton.title = "‹"
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch profileView.profileTableViewStatus {
        case .menu:         return user.dishes.count
        case .reviews:      return user.reviews.count
        case .followers:    return user.followedBy.count
        case .following:    return user.follows.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch profileView.profileTableViewStatus {
        case .menu:
            let cell = tableView.dequeueReusableCell(withIdentifier: dishCellIdentifier, for: indexPath) as! DishTableViewCell
            cell.dish = user.dishes[indexPath.row]
            if user === store.currentUser {
                let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(deleteDishTapped))
                cell.addGestureRecognizer(longPressGesture)
            }
            return cell
        case .reviews:
            let cell = tableView.dequeueReusableCell(withIdentifier: reviewCellIdentifier, for: indexPath) as! ReviewTableViewCell
            cell.review = user.reviews[indexPath.row]
            return cell
        case .followers:
            let cell = tableView.dequeueReusableCell(withIdentifier: followCellIdentifier, for: indexPath) as! UserTableViewCell
            let cellUser = user.followedBy[indexPath.row]
            cell.user = cellUser
            cell.followButton.setTitle(isFollowing: true)
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(blockUserTapped))
            cell.addGestureRecognizer(longPressGesture)
            return cell
        case .following:
            let cell = tableView.dequeueReusableCell(withIdentifier: followCellIdentifier, for: indexPath) as! UserTableViewCell
            let cellUser = user.followedBy[indexPath.row]
            cell.user = cellUser
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(blockUserTapped))
            cell.addGestureRecognizer(longPressGesture)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch profileView.profileTableViewStatus {
        case .menu:
//            if self.user === self.store.currentUser {
//                <#code#>
//            }
//            else {
                let purchaseDishVC = PurchaseDishViewController()
                purchaseDishVC.dish = self.user.dishes[indexPath.row]
                self.present(purchaseDishVC, animated: true, completion: nil)
//            }
        case .followers, .following:
            let profileVC = ProfileViewController()
            let cell = tableView.cellForRow(at: indexPath) as! UserTableViewCell
            profileVC.user = cell.user
            self.navigationController?.pushViewController(profileVC, animated: true)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: profileHeaderIdentifier) as! ProfileTableHeaderView
        
        if user.stripeAccountId != "" {
            headerView.addItemButton.removeTarget(self, action: #selector(setUpStripeAlert), for: .touchUpInside)
            headerView.addItemButton.addTarget(self, action: #selector(showAddDishVC), for: .touchUpInside)

        }else{
            headerView.addItemButton.removeTarget(self, action: #selector(showAddDishVC), for: .touchUpInside)
            headerView.addItemButton.addTarget(self, action: #selector(setUpStripeAlert), for: .touchUpInside)

        }
   
        switch profileView.profileTableViewStatus {
        case .reviews, .followers, .following: headerView.addItemButton.isHidden = true
        default:
            headerView.addItemButton.isHidden = !(user === store.currentUser)
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
    
    func setUpStripeAlert(){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            hideWhenBackgroundViewIsTapped: true
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Okay") {
            
            if let pageVC = self.parent as? UserPageViewController {
                pageVC.navigateToSettingsViewController(.reverse)
            }
        
        }
        
        alertView.showNotice("Missing Information", subTitle: "Please set up your stripe connect account in settings")
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
        
        OperationQueue.main.addOperation {
            self.profileView.tableView.reloadData()
        }
        
        
    }
}

//Long press gesture handlers for TableView cells
extension ProfileViewController {
    
    func deleteDishTapped(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            print ("delete dish tapped")
            let cell = sender.view as! DishTableViewCell
            guard let dish = cell.dish else { print("ERROR: please try again later"); return }
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
                let index = self.user.dishes.index{$0 === dish}
                self.user.dishes.remove(at: index!)
            })
            alertView.showEdit(dish.name, subTitle: cell.dish.description)

        }
    }
    
    
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
        else {
            self.navigationController?.popViewController(animated: true)
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
