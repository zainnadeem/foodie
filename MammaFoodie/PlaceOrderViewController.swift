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

class PlaceOrderViewController: UIViewController, STPPaymentContextDelegate {

    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "cross_icon"), middleButtonImage: nil)
    lazy var tableView = UITableView()
    lazy var deliveryView: DeliveryInfoView = DeliveryInfoView()
    lazy var paymentView: PaymentView = PaymentView()
    
    
    let store = DataStore.sharedInstance
    var deliveryFee: Int?

    
    //Stripe
    var paymentContext: STPPaymentContext!
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
            
            if let total = self.store.currentUser.calculateCartTotalAsInt(){
                paymentContext.paymentAmount = total
            }
            
        }
        
    }
    
    func placeOrderButtonTapped() {
        self.paymentInProgress = true
        

        self.paymentContext.requestPayment()
        store.currentUser.cart.removeAll()
        self.dismiss(animated: true, completion: nil)
         
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
      
        
//        assert(stripePublishableKey.hasPrefix("pk_"), "You must set your Stripe publishable key at the top of CheckoutViewController.swift to run this app.")
//        assert(backendBaseURL != nil, "You must set your backend base url at the top of CheckoutViewController.swift to run this app.")
//
//        APIClient.sharedClient.baseURLString = backendBaseURL!
//        
//        let settings = self.settingsVC.settings
//        let config = STPPaymentConfiguration.shared()
//        config.publishableKey = stripePublishableKey
//        config.appleMerchantIdentifier = appleMerchantID
//        config.companyName = companyName
//        config.requiredBillingAddressFields = settings.requiredBillingAddressFields
//        config.requiredShippingAddressFields = settings.requiredShippingAddressFields
//        config.shippingType = settings.shippingType
//        config.additionalPaymentMethods = settings.additionalPaymentMethods
//        config.smsAutofillDisabled = !settings.smsAutofillEnabled
//        
//        let paymentContext = STPPaymentContext(apiAdapter: APIClient.sharedClient,
//                                               configuration: config,
//                                               theme: settings.theme)
//        
//        let userInformation = STPUserInformation()
//        paymentContext.prefilledInformation = userInformation
//        
//        if let total = self.store.currentUser.calculateCartTotalAsInt(){
//            paymentContext.paymentAmount = total
//        }
//        
//        paymentContext.paymentCurrency = paymentCurrency
//        self.paymentContext = paymentContext
//        
//        self.paymentRow = CheckoutRowView(title: "Payment", detail: "Select Payment",
//                                          theme: settings.theme)
//        var shippingString = "Contact"
//        if config.requiredShippingAddressFields.contains(.postalAddress) {
//            shippingString = config.shippingType == .shipping ? "Shipping" : "Delivery"
//        }
//        
//        self.shippingString = shippingString
//        self.shippingRow = CheckoutRowView(title: self.shippingString,
//                                           detail: "Enter \(self.shippingString) Info",
//            theme: settings.theme)
//        var localeComponents: [String: String] = [
//            NSLocale.Key.currencyCode.rawValue: paymentCurrency,
//            ]
//        localeComponents[NSLocale.Key.languageCode.rawValue] = NSLocale.preferredLanguages.first
//        let localeID = NSLocale.localeIdentifier(fromComponents: localeComponents)
//        let numberFormatter = NumberFormatter()
//        numberFormatter.locale = Locale(identifier: localeID)
//        numberFormatter.numberStyle = .currency
//        numberFormatter.usesGroupingSeparator = true
//        self.numberFormatter = numberFormatter
//        self.paymentContext.delegate = self
//        paymentContext.hostViewController = self
//        
//        self.paymentRow.onTap = { [weak self] _ in
//            self?.paymentContext.presentPaymentMethodsViewController()
//        }
//        self.shippingRow.onTap = { [weak self] _ in
//            self?.paymentContext.presentShippingViewController()
//        }
        
    }
    // MARK: STPPaymentContextDelegate
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
//        APIClient.sharedClient.completeCharge(paymentResult, amount: self.paymentContext.paymentAmount,
//                                              completion: completion)
        let stpAddress = STPAddress()
        stpAddress.name = "Zain"
        stpAddress.city = "Hicksville"
        stpAddress.state = "NY"
        stpAddress.country = "United States"
        stpAddress.phone = "516-244-2916"
        stpAddress.postalCode = "11801"
        
        let card = STPCard()
        
        card.address = stpAddress
        card.number = "4242424242424242"
        card.expYear = 19
        card.expMonth =  05
        card.cvc = "111"
        let stripeUtl = StripeUtil()
        
        
        stripeUtl.createUser(card: card) { (success) in
            
        }
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        self.paymentInProgress = false
        let title: String
        let message: String
        switch status {
        case .error:
            title = "Error"
            message =  error?.localizedDescription ?? ""
        case .success:
            title = "Success"
            message = "You will reveive conformation from your Chef soon!"
        case .userCancellation:
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        self.paymentRow.loading = paymentContext.loading
        if let paymentMethod = paymentContext.selectedPaymentMethod {
            self.paymentRow.detail = paymentMethod.label
        }
        else {
            self.paymentRow.detail = "Select Payment"
        }
        if let shippingMethod = paymentContext.selectedShippingMethod {
            self.shippingRow.detail = shippingMethod.label
        }
        else {
            self.shippingRow.detail = "Enter \(self.shippingString) Info"
        }
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            // Need to assign to _ because optional binding loses @discardableResult value
            // https://bugs.swift.org/browse/SR-1681
            _ = self.navigationController?.popViewController(animated: true)
        })
        let retry = UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.paymentContext.retryLoading()
        })
        alertController.addAction(cancel)
        alertController.addAction(retry)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didUpdateShippingAddress address: STPAddress, completion: @escaping STPShippingMethodsCompletionBlock) {
        let upsGround = PKShippingMethod()
        upsGround.amount = 0
        upsGround.label = "UPS Ground"
        upsGround.detail = "Arrives in 3-5 days"
        upsGround.identifier = "ups_ground"
        let upsWorldwide = PKShippingMethod()
        upsWorldwide.amount = 10.99
        upsWorldwide.label = "UPS Worldwide Express"
        upsWorldwide.detail = "Arrives in 1-3 days"
        upsWorldwide.identifier = "ups_worldwide"
        let fedEx = PKShippingMethod()
        fedEx.amount = 5.99
        fedEx.label = "FedEx"
        fedEx.detail = "Arrives tomorrow"
        fedEx.identifier = "fedex"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if address.country == nil || address.country == "US" {
                completion(.valid, nil, [upsGround, fedEx], fedEx)
            }
            else if address.country == "AQ" {
                let error = NSError(domain: "ShippingError", code: 123, userInfo: [NSLocalizedDescriptionKey: "Invalid Shipping Address",
                                                                                   NSLocalizedFailureReasonErrorKey: "We can't ship to this country."])
                completion(.invalid, error, nil, nil)
            }
            else {
                fedEx.amount = 20.99
                completion(.valid, nil, [upsWorldwide, fedEx], fedEx)
            }
        }
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
