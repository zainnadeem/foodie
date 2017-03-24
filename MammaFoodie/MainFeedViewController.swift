//
//  MainFeedViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Stripe
import GoogleSignIn

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let pageVC = self.parent as? UserPageViewController {
            pageVC.setUpCartView()
        }
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
        
        
        
        let uri = "MammaFoodie://"
        let authorizeURL = "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=\(stripeClientId)&scope=read_write"
         UIApplication.shared.openURL(NSURL(string: authorizeURL)! as URL)
        
//        let request = NSURLRequest(url: URL(string: authorizeURL)!)
//        let urlWebView = UIWebView()
//        self.view = urlWebView
//        
//        urlWebView.loadRequest(request as URLRequest)
        
        
//        let params = [         "AUTHORIZE_URI"      : "https://connect.stripe.com/oauth/authorize"
//                               "response_type"      : "code",
//                               "scope"              : "read_write",
//                               "client_id"          : stripeClientId
//                    ]
        
        
//
//        let stripeUtil = StripeUtil()
//        
//        stripeUtil.stripeAPICall(params: params, requestMethod: .GET, path: StripePath.authorize) { (success) in
//            
//        }
    
    }
//    
//    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
//    {
//        if let URL = request.url?.absoluteString
//        {
//            // This should be the redirect URL that you pass it can be anything like local host mentioned above.
//            if URL.hasPrefix(backendBaseURL)
//            {
//                // Now you can simply do some string manipulation to pull out the relevant components.
//                // I'm not sure what sort of token or how you get it back but assuming the redirect URL is
//                // YourRedirectURL&code=ACCESS_TOKEN and you want access token heres how you would get it.
//                var code : String?
//                if let URLParams = request.url?.query?.components(separatedBy: "&")
//                {
//                    for param in URLParams
//                    {
//                        let keyValue = param.components(separatedBy: "=")
//                        let key = keyValue.first
//                        if key == "code"
//                        {
//                            code = keyValue.last
//                        }
//                    }
//                }
//                // Here if code != nil then it has the ACCESS_TOKEN and you are done! If its nil something went wrong.
//                return false // So that the webview doesnt redirect to the dummy URL you passed.
//            }
//        }
//        return true
//    }
    
    
}

