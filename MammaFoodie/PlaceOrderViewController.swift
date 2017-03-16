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
    lazy var placeOrderButton: FormSubmitButton = FormSubmitButton()
    
    let store = DataStore.sharedInstance
    var deliveryFee: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewProperties()
        setViewConstraints()

    }
    
    func setViewProperties() {
        
        navBar.delegate = self
        navBar.middleButton.title = "Your Order"
        view.addSubview(navBar)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartItemTableViewCell.self, forCellReuseIdentifier: cartItemCellIdentifier)
        
        setPlaceOrderButtonTitle()
        placeOrderButton.addTarget(self, action: #selector(placeOrderButtonTapped), for: .touchUpInside)
        
        view.addSubview(placeOrderButton)
        
    }
    
    func setViewConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(navBar.snp.bottom).offset(10)
        }
        
        placeOrderButton.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func deleteCartItem(for sender: UIButton) {
        if let cell = sender.superview as? UITableViewCell {
            let indexPath = tableView.indexPath(for: cell)
            store.currentUser.cart.remove(at: indexPath!.row)
            tableView.deleteRows(at: [indexPath!], with: .fade)
        }
        
    }
    
    func placeOrderButtonTapped() {
        
    }
    
    func setPlaceOrderButtonTitle() {
        var cartTotal = store.currentUser.cart.reduce(0) { return $0 + $1.price }
        if let deliveryFee = deliveryFee {
            cartTotal = cartTotal + deliveryFee
        }
        var cartTotalAsString = String(cartTotal)
        cartTotalAsString = cartTotalAsString.convertPriceInCentsToDollars()
        placeOrderButton.setTitle("Place Order - \(cartTotalAsString)", for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}

extension PlaceOrderViewController: NavBarViewDelegate {
    func leftBarButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    func middleBarButtonTapped(_ Sender: AnyObject) {}
    func rightBarButtonTapped(_ sender: AnyObject) {}
}
