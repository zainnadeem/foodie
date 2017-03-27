//
//  PurchaseDishViewController.swift
//  
//
//  Created by Haaris Muneer on 3/12/17.
//
//

import UIKit
import Cosmos
import SnapKit
import SDWebImage
import SCLAlertView

class PurchaseDishViewController: UIViewController {
    
    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "cross_icon"), middleButtonImage: nil)
    
    var broadcast: Broadcast?
    var dish: Dish!
    
    let store = DataStore.sharedInstance
    
    lazy var dishImageView = UIImageView()
    lazy var ratingView = CosmosView()
    lazy var tableView = UITableView()
    let sections = ["name", "description", "price", "quantity"]
    
    lazy var purchaseButton: FormSubmitButton = FormSubmitButton(frame: CGRect())

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(dismissKeyboardGesture)
        tableView.addGestureRecognizer(dismissKeyboardGesture)
        
        setViewProperties()
        setViewConstraints()
        
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func setViewProperties() {
        
        navBar.delegate = self
        navBar.middleButton.title = "Purchase \(dish.name)"
        view.addSubview(navBar)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: textFieldTableViewCellIdentifier)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        let imageURL = URL(string: dish.mainImageURL)
        dishImageView.sd_setImage(with: imageURL)
        dishImageView.layer.borderColor = UIColor.black.cgColor
        dishImageView.layer.borderWidth = 3
        dishImageView.layer.cornerRadius = 10
        dishImageView.clipsToBounds = true
        view.addSubview(dishImageView)
        
        ratingView.rating = Double(dish!.averageRating)
        ratingView.settings.updateOnTouch = false
        ratingView.settings.starSize = 20
        view.addSubview(ratingView)
        
        purchaseButton.setTitle("Add to bag", for: .normal)
        purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
        view.addSubview(purchaseButton)
        
    }
    
    func setViewConstraints() {
        
        dishImageView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.centerX.equalToSuperview()
            make.height.equalTo(dishImageView.snp.width)
        }
        
        ratingView.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.top.equalTo(dishImageView.snp.bottom).offset(2)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalTo(ratingView.snp.bottom).offset(10)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        purchaseButton.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func purchaseButtonTapped() {
        let quantityCell = tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as! TextFieldTableViewCell
        if let quantity = Int(quantityCell.textField.text!){
            if self.dish.createdBy != store.currentUser.cart.first?.createdBy {
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false,
                    hideWhenBackgroundViewIsTapped: true
                )
                let alertView = SCLAlertView(appearance: appearance)
                alertView.addButton("Yes", action: {
                    for _ in 0..<quantity { self.store.currentUser.cart.append(self.dish) }
                    self.dismiss(animated: true, completion: nil)
                })
                alertView.addButton("Cancel", action: {})
                alertView.showError("Error", subTitle: "You can only purchase food from one chef at a time. Would you like to clear your cart and add this dish?")
            }
            else {
                for _ in 0..<quantity { self.store.currentUser.cart.append(self.dish) }
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
        else {
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false,
                hideWhenBackgroundViewIsTapped: true
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Ok", action: {})
            alertView.showError("Error", subTitle: "Please enter a valid quantity")
           
        }
    }
}

extension PurchaseDishViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = "Quantity"
            cell.textField.textAlignment = .left
            cell.textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
            cell.textField.keyboardType = .numberPad
            cell.textField.becomeFirstResponder()
            cell.removeBorders()
            return cell
        }
        else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: defaultReuseIdentifier)
            cell.textLabel?.font = UIFont.mammaFoodieFontBold(15)
            cell.textLabel?.textColor = UIColor.darkGray
            switch indexPath.section {
            case 0:
                cell.textLabel?.text = dish.name
            case 1:
                cell.textLabel?.numberOfLines = 2
                cell.textLabel?.font = UIFont.mammaFoodieFontBold(13)
                cell.textLabel?.text = dish.description
            case 2:
                var priceAsString = String(dish!.price)
                cell.textLabel?.text = priceAsString.convertPriceInCentsToDollars()
            default:
                print("cellForRowAtIndexPath should not reach here")
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension PurchaseDishViewController: NavBarViewDelegate {
    func leftBarButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    func middleBarButtonTapped(_ Sender: AnyObject) {}
    func rightBarButtonTapped(_ sender: AnyObject) {}
}
