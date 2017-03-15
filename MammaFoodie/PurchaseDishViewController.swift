//
//  PurchaseDishViewController.swift
//  
//
//  Created by Haaris Muneer on 3/12/17.
//
//

import UIKit
import SnapKit

class PurchaseDishViewController: UIViewController {
    
    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: nil, middleButtonImage: nil)
    
    var dish: Dish!
    
    lazy var dishImageView = UIImageView()
    lazy var purchaseButton = UIButton(type: .system)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        navBar.delegate = self
        navBar.middleButton.title = "Purchase \(dish.name)"
        
        setViewProperties()
        setViewConstraints()
        
    }
    
    func setViewProperties() {
        dishImageView.image = dish.mainImage
        dishImageView.layer.borderColor = UIColor.black.cgColor
        dishImageView.layer.borderWidth = 3
        dishImageView.layer.cornerRadius = 10
        dishImageView.clipsToBounds = true
    }
    
    func setViewConstraints() {
        
        self.view.addSubview(dishImageView)
        dishImageView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(5)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.centerX.equalToSuperview()
            make.height.equalTo(dishImageView.snp.width)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}

extension PurchaseDishViewController: NavBarViewDelegate {
    func leftBarButtonTapped(_ sender: AnyObject) {}
    func middleBarButtonTapped(_ Sender: AnyObject) {}
    func rightBarButtonTapped(_ sender: AnyObject) {}
}
