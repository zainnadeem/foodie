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

class PurchaseDishViewController: UIViewController {
    
    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "icon-profile"), middleButtonImage: nil)
    
    var dish: Dish!
    
    let store = DataStore.sharedInstance
    
    lazy var dishImageView = UIImageView()
    lazy var ratingView = CosmosView()
    lazy var nameLabel = UILabel()
    lazy var descriptionTextView = UITextView()
    lazy var priceLabel = UILabel()
    lazy var quantityTextField = UITextField()
    
    lazy var purchaseButton: FormSubmitButton = FormSubmitButton(frame: CGRect())
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        setViewProperties()
        setViewConstraints()
        
    }
    
    func setViewProperties() {
        
        navBar.delegate = self
        navBar.middleButton.title = "Purchase \(dish.name)"
        view.addSubview(navBar)
        
        dishImageView.image = dish.mainImage
        dishImageView.layer.borderColor = UIColor.black.cgColor
        dishImageView.layer.borderWidth = 3
        dishImageView.layer.cornerRadius = 10
        dishImageView.clipsToBounds = true
        view.addSubview(dishImageView)
        
        ratingView.rating = Double(dish.averageRating)
        ratingView.settings.updateOnTouch = false
        ratingView.settings.starSize = 40
        view.addSubview(ratingView)
        
        nameLabel.text = dish.name
        nameLabel.font = UIFont.mammaFoodieFont(20)
        view.addSubview(nameLabel)
        
        descriptionTextView.text = dish.description
        descriptionTextView.font = UIFont.mammaFoodieFont(16)
        descriptionTextView.textAlignment = .left
        view.addSubview(descriptionTextView)
        
        var priceAsString = String(dish.price)
        priceLabel.text = priceAsString.convertPriceInCentsToDollars()
        priceLabel.font = UIFont.mammaFoodieFont(20)
        view.addSubview(priceLabel)
        
        quantityTextField.font = UIFont.mammaFoodieFont(20)
        quantityTextField.keyboardType = .numberPad
        quantityTextField.textAlignment = .left
        quantityTextField.placeholder = "Quantity"
        view.addSubview(quantityTextField)
        
        purchaseButton.setTitle("Add to bag", for: .normal)
        purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
        view.addSubview(purchaseButton)
        
    }
    
    func setViewConstraints() {
        
        dishImageView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(5)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.centerX.equalToSuperview()
            make.height.equalTo(dishImageView.snp.width)
        }
        
        ratingView.snp.makeConstraints { (make) in
            make.width.equalTo(dishImageView)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.top.equalTo(dishImageView.snp.bottom).offset(2)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalTo(ratingView.snp.bottom).offset(20)
        }
        
        descriptionTextView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.height.equalTo(100)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionTextView.snp.bottom).offset(5)
        }
        
        quantityTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
        }
        
        purchaseButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func purchaseButtonTapped() {
        if let quantity = Int(quantityTextField.text!){
            for _ in 0..<quantity {
                self.store.currentUser.cart.append(self.dish)
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    

}

extension PurchaseDishViewController: NavBarViewDelegate {
    func leftBarButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    func middleBarButtonTapped(_ Sender: AnyObject) {}
    func rightBarButtonTapped(_ sender: AnyObject) {}
}
