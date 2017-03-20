//
//  MainFeedViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Stripe


class MainFeedViewController: UIViewController {
    
    //NavBar
    lazy var navBar : NavBarView = NavBarView(withView: self.view, rightButtonImage: #imageLiteral(resourceName: "searchIcon"), leftButtonImage: #imageLiteral(resourceName: "icon-profile"), middleButtonImage: nil)
    
    
    //TableView
    var sections = ["~Featured Chefs~", "~Cooking Now~", "~Live Now~", "~Upcoming Broadcasts~"]
    
    lazy var tableView : UITableView = UITableView()
    
    let store = DataStore.sharedInstance
    
    let str = StripeUtil()
    
    //CollectionViews
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        
        
        self.navBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.navBar.middleButton.title = "Mamma Foodie"
        self.tableView.backgroundColor = .black
        self.view.backgroundColor = .black
        
        
        self.tableView.register(FeaturedChefTableViewCell.self, forCellReuseIdentifier: featuredChefTableViewCellIdentifier)
        self.tableView.register(CookingNowTableViewCell.self, forCellReuseIdentifier: cookingNowTableViewCellIdentifier)
        self.tableView.register(LiveNowTableViewCell.self, forCellReuseIdentifier: liveNowTableViewCellIdentifier)
        self.tableView.register(UpcomingBroadcastsTableViewCell.self, forCellReuseIdentifier: upcomingBroadcastsTableViewCellIdentifier)
        
        self.setViewConstraints()

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
            cell.fetchUsers()
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cookingNowTableViewCellIdentifier) as! CookingNowTableViewCell
            cell.layOutCollectionView()
            cell.fetchUsers()
            return cell
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: liveNowTableViewCellIdentifier) as!
            LiveNowTableViewCell
            cell.layOutCollectionView()
            cell.fetchUsers()
            return cell
            
        //default case upcomingbroadcasts
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: upcomingBroadcastsTableViewCellIdentifier) as! UpcomingBroadcastsTableViewCell
            cell.layOutCollectionView()
            cell.fetchUsers()
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let label = UILabel()
        label.text = sections[section]
        label.font = UIFont.mammaFoodieFontBold(15)
        
        
        label.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35)
        label.textAlignment = .center
        
        
        view.addSubview(label)
        
        return view
        
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
        
//        let stpCardParams1 = STPCardParams()
//        stpCardParams1.number = "4242424242424242"
//        stpCardParams1.last4()
//        stpCardParams1.expMonth = UInt(09)
//        stpCardParams1.expYear = UInt(19)
//        stpCardParams1.cvc = "989"
//        stpCardParams1.name = "Zain"
//        
//        let stpCardParams2 = STPCardParams()
//        stpCardParams2.number = "4012888888881881"
//        stpCardParams2.last4()
//        stpCardParams2.expMonth = UInt(09)
//        stpCardParams2.expYear = UInt(19)
//        stpCardParams2.cvc = "333"
//        stpCardParams2.name = "Omer"
//        
//        let stpCardParams3 = STPCardParams()
//        stpCardParams3.number = "4207670162371796"
//        stpCardParams3.last4()
//        stpCardParams3.expMonth = UInt(06)
//        stpCardParams3.expYear = UInt(20)
//        stpCardParams3.cvc = "720"
//        stpCardParams3.name = "Zain Nadeem"
//        
//        
//        
//        str.createUser(card: stpCardParams2) { (success) in
//            
//            self.str.createCharge(stripeId: self.store.currentUser.stripeId, amount: Int(50), currency: paymentCurrency) { (success) in
//                  
//            }
//        }
//        
//     
        
        
//
        
//        
//        str.createUser(card: stpCardParams1) { (success) in
//            print(success)
//            
//        }
//        
//          str.retrieveCustomer { (customer, error) in
//            
//            let paymentContext = STPPaymentContext.init(apiAdapter: StripeUtil.sharedClient)
//            paymentContext.paymentAmount = Int(20.00)
//            paymentContext.requestPayment()
// 
//        
//        }
        
//        str.createCard(stripeId: self.store.currentUser.stripeId, card: stpCardParams3) { (success) in
//            
//            
//            
//        }
  
    }
    
    
}

