//
//  PlaceOrderViewController.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/13/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit
import Stripe

class PlaceOrderViewController: UIViewController {

    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "cross_icon"), middleButtonImage: nil)
    lazy var tableView = UITableView()
    lazy var deliveryView: DeliveryInfoView = DeliveryInfoView()
    lazy var paymentView: PaymentView = PaymentView()
    
    
    let store = DataStore.sharedInstance
    var deliveryFee: Int?
    
    let stripeUtil = StripeUtil()
    
    var purchaseCard: STPCard? = nil
    

    
    //Stripe
    lazy var paymentRow: CheckoutRowView = CheckoutRowView(title: "Payment", detail: "Select", theme: .default())
    lazy var shippingRow: CheckoutRowView = CheckoutRowView(title: "Shipping", detail: "Select", theme: .default())
    lazy var placeOrderButton: FormSubmitButton = FormSubmitButton()
    var numberFormatter: NumberFormatter!
    
    let settingsVC = StripeSettingsViewController()
    

    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var shippingString: String = String()
    
    var paymentInProgress: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                if self.paymentInProgress {
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.alpha = 1
                    self.placeOrderButton.alpha = 0
                }
                else {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                    self.placeOrderButton.alpha = 1
                }
            }, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpStripe()

        setViewProperties()
        setViewConstraints()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setViewProperties() {
        self.view.backgroundColor = .white
        
        navBar.delegate = self
        navBar.middleButton.title = "Your Order"
        view.addSubview(navBar)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartItemTableViewCell.self, forCellReuseIdentifier: cartItemCellIdentifier)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        setPlaceOrderButtonTitle()
        placeOrderButton.addTarget(self, action: #selector(placeOrderButtonTapped), for: .touchUpInside)
        
        self.paymentRow.onTap = { [weak self] _ in
            self?.addPaymentTapped()
        }
        
        view.addSubview(placeOrderButton)
        
    }
    
    func setViewConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
            make.top.equalTo(navBar.snp.bottom).offset(10)
        }
        
        view.addSubview(deliveryView)
        deliveryView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.80)
            make.top.equalTo(tableView.snp.bottom).offset(5)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        
        view.addSubview(shippingRow)
        shippingRow.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.80)
            make.top.equalTo(deliveryView.snp.bottom).offset(5)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        view.addSubview(paymentRow)
        paymentRow.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.80)
            make.top.equalTo(shippingRow.snp.bottom).offset(5)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        placeOrderButton.snp.makeConstraints { (make) in
            make.top.equalTo(paymentRow.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.80)
        }
    }
    
    func deleteCartItem(for sender: UIButton) {
        if let cell = sender.superview?.superview as? CartItemTableViewCell {
            let indexPath = tableView.indexPath(for: cell)
            store.currentUser.cart.remove(at: indexPath!.row)
            tableView.deleteRows(at: [indexPath!], with: .fade)
            setPlaceOrderButtonTitle()
            
            
        }
        
    }
    
    func placeOrderButtonTapped() {

        guard let card = purchaseCard else { return print("please select payment method") }
        
        let customer = self.store.currentUser
        var recipient: User = User()
        recipient.uid = self.store.currentUser.cart[0].createdBy
        
        recipient.observeUser { (user) in
            
            recipient = user
            
            self.stripeUtil.createCharge(stripeId: customer.stripeId, amount: customer.calculateCartTotalAsInt()!, currency: paymentCurrency, destination: recipient.stripeId) { (success) in
                
                if success {
                    self.store.currentUser.cart.removeAll()
                    self.dismiss(animated: true, completion: nil)
                }
                
                
            }
        }
        
     
    }

    
    func setPlaceOrderButtonTitle() {
        if let cartTotal = store.currentUser.calculateCartTotal() {
            placeOrderButton.setTitle("Place Order - \(cartTotal)", for: .normal)
            placeOrderButton.isEnabled = true
        }
        else {
            placeOrderButton.setTitle("Your cart is empty!", for: .normal)
            placeOrderButton.isEnabled = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpStripe(){
      


    }
}

extension PlaceOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.currentUser.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cartItemCellIdentifier, for: indexPath) as! CartItemTableViewCell
        cell.dish = store.currentUser.cart[indexPath.row]
        cell.deleteButton.addTarget(self, action: #selector(deleteCartItem(for:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension PlaceOrderViewController: NavBarViewDelegate {
    func leftBarButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    func middleBarButtonTapped(_ Sender: AnyObject) {}
    func rightBarButtonTapped(_ sender: AnyObject) {}
}


extension PlaceOrderViewController: STPAddCardViewControllerDelegate {

func addPaymentTapped() {
    
    let addCardViewController = STPAddCardViewController()
    addCardViewController.delegate = self
    // STPAddCardViewController must be shown inside a UINavigationController.
    let navigationController = UINavigationController(rootViewController: addCardViewController)
    self.present(navigationController, animated: true, completion: nil)
}
    
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        //set token & stripeID in parameters

        let params = ["source" : token.tokenId,
                      "id"     : self.store.currentUser.stripeId
                    ]
        
        self.stripeUtil.stripeAPICall(params: params, requestMethod: .POST, path: StripePath.source) { (success) in
            
                   self.dismiss(animated: true, completion: { 
                    if success{
                       
                        self.paymentRow.detail = (token.card?.last4())!
                        self.purchaseCard = token.card
                    
                        }
                   })
        }
        
    }
    
    
}

