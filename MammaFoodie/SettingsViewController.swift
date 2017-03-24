//
//  SettingsViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/3/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Firebase

import Stripe

import FBSDKLoginKit
import GoogleSignIn
import SCLAlertView


class SettingsViewController: UIViewController {
    
    lazy var navBar:                NavBarView = NavBarView(withView: self.view, rightButtonImage: #imageLiteral(resourceName: "icon-profile"), leftButtonImage: nil, middleButtonImage: nil)
    lazy var tableView:             UITableView = UITableView()
    
    var paymentContext: STPPaymentContext!
    
    let store = DataStore.sharedInstance
    
    let companyName = "Emoji Apparel"
    let paymentCurrency = "usd"

    
    enum SectionType {
        case YourAccount
        case Support
        case Logout
    }
    
    enum Item {
        case EditProfile
        case Payment
        case Address
        case SubmitFeedback
        case Terms
        case LogoutUser
    }
    
    struct Section {
        var type: SectionType
        var items: [Item]
    }
    
    var sections = [Section]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navBar.middleButton.title = "Settings"
        
        self.tableView.register(EditProfileTableViewCell.self, forCellReuseIdentifier: editProfileTableViewCellIdentifier)
        
        sections = [
            Section(type: .YourAccount, items: [.EditProfile, .Payment, .Address]),
            Section(type: .Support, items: [.SubmitFeedback, .Terms]),
            Section(type: .Logout, items: [.LogoutUser]),
        ]
        
        self.setViewConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
        
        if let pageVC = self.parent as? UserPageViewController {
            pageVC.setUpCartView()
        }
    }
    
    private func setViewConstraints(){
        
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

extension SettingsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath == IndexPath(row: 0, section: 0) {
            
            let cell  = tableView.dequeueReusableCell(withIdentifier: editProfileTableViewCellIdentifier, for: indexPath) as! EditProfileTableViewCell
            cell.user = store.currentUser
            cell.accessoryType = .disclosureIndicator
            return cell
            
        }else{
            
            let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: defaultReuseIdentifier)
            
            switch sections[indexPath.section].items[indexPath.row] {
                
            case .Payment:
                cell.textLabel?.text = "Payment"
                cell.accessoryType = .disclosureIndicator
                
            case .Address:
                cell.textLabel?.text = "Address"
                cell.accessoryType = .disclosureIndicator
                
            case .SubmitFeedback:
                cell.textLabel?.text = "Submit Feedback"
                
            case .Terms:
                cell.textLabel?.text = "Terms"
                
            case .LogoutUser:
                cell.textLabel?.text = "Logout"
                
            default:
                print("should not reach this point (cellForRow)")
            }
            
            cell.textLabel?.font = UIFont.mammaFoodieFontBold(12)
            cell.textLabel?.textColor = UIColor.darkGray
            cell.detailTextLabel?.font = UIFont.mammaFoodieFont(10)
            cell.detailTextLabel?.textColor = UIColor.darkGray
            
            return cell
        }
    }
}

extension SettingsViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch sections[indexPath.section].items[indexPath.row] {
            
        case .EditProfile:
            let destinationVC = EditProfileViewController()
            destinationVC.modalTransitionStyle = .crossDissolve
            self.present(destinationVC, animated: true, completion: nil)
            
        case .Payment:
            print("Show Payment Methods")
            
            
        case .Address:
            let destinationVC = AddressesViewController()
            destinationVC.modalTransitionStyle = .crossDissolve
            self.present(destinationVC, animated: true, completion: nil)
            
        case .SubmitFeedback:
            self.openMailForFeedback()
            print("Open Mail Client")

            
        case .Terms:
            print("Open Terms")
            
            
        case .LogoutUser:
            self.logOutUser()
            print("Show Logout")
            
            
        default:
            print("should not reach this point (cellForRow)")
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 0, section: 0) { return self.view.bounds.width / 4 } else {
            return self.view.bounds.width / 6 }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch sections[section].type {
        case .YourAccount:
            return "Your Account"
            
        case .Support:
            return "Support"
            
        case .Logout:
            return "Logout"
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.mammaFoodieFont(12)
        header.textLabel?.textColor = UIColor.red
    }
    
}

extension SettingsViewController : NavBarViewDelegate {
    
    func rightBarButtonTapped(_ sender: AnyObject) {
        if let pageVC = self.parent as? UserPageViewController {
            pageVC.navigateToProfileViewController(.forward)
        }
        
    }
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        if let pageVC = self.parent as? UserPageViewController {
            
        }
        
    }
    
    func middleBarButtonTapped(_ Sender: AnyObject) {
        let index = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: index, at: .top, animated: true)
    }
    
}


//Mark : Table View functions
extension SettingsViewController {
    
    func  openMailForFeedback(){
        let email = "haaris@mammafoodie.com"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.shared.open(url as! URL, options: [:], completionHandler: nil)
    }
    
     func logOutUser(){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            hideWhenBackgroundViewIsTapped: true
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Cancel") {}
        alertView.addButton("Log out") { 
            print("Logout tapped")
            
            do {
                try FIRAuth.auth()?.signOut()
                if FBSDKAccessToken.current() != nil {
                    FBSDKLoginManager().logOut()
                }
                if GIDSignIn.sharedInstance().hasAuthInKeychain() {
                    GIDSignIn.sharedInstance().signOut()
                }
                
                //                self.store.currentUser?.unregisterToken()
                
            }catch{
                print("error \(error)")
            }
            
            let loginVC = LoginViewController()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let transition = CATransition()
            transition.type = kCATransitionFade
            
            appDelegate.window!.setRootViewController(loginVC, transition: transition)
        }
        alertView.showWarning("Wait!", subTitle: "Are you sure you want to log out?")
    }
    
}

extension SettingsViewController : STPPaymentContextDelegate {
    
    //This method is called, as you might expect, when the payment context's contents change, e.g. when the user selects a new payment method or enters shipping info. This is a good place to update your UI:
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        //        self.activityIndicator.animating = paymentContext.loading
        //        self.paymentButton.enabled = paymentContext.selectedPaymentMethod != nil
        //        self.paymentLabel.text = paymentContext.selectedPaymentMethod?.label
        //        self.paymentIcon.image = paymentContext.selectedPaymentMethod?.image
    }
    
    //This method is called when the user has successfully selected a payment method and completed their purchase. You should pass the contents of the paymentResult object to your backend, which should then finish charging your user using the create charge API. When this API request is finished, call the provided completion block with nil as its only argument if the call succeeded, or, if an error occurred, with that error as the argument instead.
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didCreatePaymentResult paymentResult: STPPaymentResult,
                        completion: @escaping STPErrorBlock) {
        
        //        myAPIClient.createCharge(paymentResult.source.stripeID, completion: { (error: Error?) in
        //            if let error = error {
        //                completion(error)
        //            } else {
        //                completion(nil)
        //            }
        //        })
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didFinishWith status: STPPaymentStatus,
                        error: Error?) {
        
        //        switch status {
        //        case .error:
        //            self.showError(error)
        //        case .success:
        //            self.showReceipt()
        //        case .userCancellation:
        //            return // Do nothing
        //        }
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didFailToLoadWithError error: Error) {
        //   self.navigationController?.popViewController(animated: true)
        // Show the error to your user, etc.
    }
    
    func choosePaymentButtonTapped() {
        self.paymentContext.presentPaymentMethodsViewController()
    }
    
    
    
    
}








