//
//  MainFeedViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit


class MainFeedViewController: UIViewController {
    
    //NavBar
    lazy var navBar : NavBarView = NavBarView(withView: self.view, rightButtonImage: #imageLiteral(resourceName: "searchIcon"), leftButtonImage: #imageLiteral(resourceName: "icon-profile"), middleButtonImage: nil)
    
    
    //TableView
    var sections = ["Featured Chefs", "Cooking Now", "Live Now", "Upcoming Broadcasts"]
    lazy var tableView : UITableView = UITableView()
    
    
    //CollectionViews
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navBar.middleButton.title = "Mamma Foodie"
        
        self.tableView.register(FeaturedChefTableViewCell.self, forCellReuseIdentifier: featuredChefTableViewCellIdentifier)
        self.tableView.register(CookingNowTableViewCell.self, forCellReuseIdentifier: cookingNowTableViewCellIdentifier)
        self.tableView.register(LiveNowTableViewCell.self, forCellReuseIdentifier: liveNowTableViewCellIdentifier)
        self.tableView.register(UpcomingBroadcastsTableViewCell.self, forCellReuseIdentifier: upcomingBroadcastsTableViewCellIdentifier)
        
        self.setViewConstraints()
        self.view.backgroundColor = UIColor.red
    }
    
}

extension MainFeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: featuredChefTableViewCellIdentifier) as! FeaturedChefTableViewCell
            cell.layOutCollectionView()
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cookingNowTableViewCellIdentifier) as! CookingNowTableViewCell
            cell.layOutCollectionView()
            return cell
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: liveNowTableViewCellIdentifier) as!
            LiveNowTableViewCell
            cell.layOutCollectionView()
            return cell
            
        //default case upcomingbroadcasts
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: upcomingBroadcastsTableViewCellIdentifier) as! UpcomingBroadcastsTableViewCell
            cell.layOutCollectionView()
            return cell
        }
        
    }
    
}

extension MainFeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return self.view.frame.height * featuredChefCollectionViewHeightMultiplier
        case 1:
            return self.view.frame.height * cookingNowCollectionViewHeightMultiplier
        case 2:
            return self.view.frame.height * liveNowCollectionViewHeightMultiplier
        case 3:
            return self.view.frame.height * upcomingBroadcastsCollectionViewHeightMultiplier
            
        default:
            return 0
        }
    }
    
    
}

//Set View Constraints
extension MainFeedViewController {
    
    func setViewConstraints(){
        
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

//NavBar
extension MainFeedViewController : NavBarViewDelegate {
    
    func rightBarButtonTapped(_ sender: AnyObject) {
        if let pageVC = self.parent as? UserPageViewController {
            pageVC.navigateToSearchViewController(.forward)
        }

    }
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        if let pageVC = self.parent as? UserPageViewController {
            pageVC.navigateToProfileViewController(.reverse)
        }
 
    }
    
    func middleBarButtonTapped(_ Sender: AnyObject) {
  
    }
    
}




