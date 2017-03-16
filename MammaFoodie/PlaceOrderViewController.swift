//
//  PlaceOrderViewController.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/13/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit

class PlaceOrderViewController: UIViewController {
    
    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "cross_icon"), middleButtonImage: nil)
    
    lazy var tableView = UITableView()
    lazy var deliveryView: DeliveryInfoView = DeliveryInfoView()
    lazy var paymentView: PaymentView = PaymentView()
    lazy var placeOrderButton: FormSubmitButton = FormSubmitButton()
    
    let store = DataStore.sharedInstance
    var deliveryFee: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewProperties()
        setViewConstraints()

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
            make.height.equalToSuperview().multipliedBy(0.45)
            make.top.equalTo(navBar.snp.bottom).offset(10)
        }
        
        view.addSubview(deliveryView)
        deliveryView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.80)
            make.top.equalTo(tableView.snp.bottom).offset(5)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        
        view.addSubview(paymentView)
        paymentView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.80)
            make.top.equalTo(deliveryView.snp.bottom).offset(5)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        placeOrderButton.snp.makeConstraints { (make) in
            make.top.equalTo(paymentView.snp.bottom).offset(5)
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
        store.currentUser.cart.removeAll()
        self.dismiss(animated: true, completion: nil)
        // ???
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
