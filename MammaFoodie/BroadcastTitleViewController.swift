//
//  BroadcastTitleViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/13/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import ChameleonFramework

class BroadcastTitleViewController: UIViewController {
   lazy var navBar:                 NavBarView      = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: nil, middleButtonImage: nil)
   lazy var topLabel:               UILabel         = UILabel()
   lazy var textField:              UITextField     = UITextField()
   
   var presentingVC:    ScheduleBroadcastViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.navBar.leftButton.title = "back"
        self.navBar.delegate = self
        
        textField.delegate = self
        
        setConstraints()
        setViewProperties()

    }
    
    fileprivate func setConstraints() {
        
        self.view.addSubview(navBar)
        
        self.view.addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.04)
            make.leading.trailing.equalToSuperview()
        }
        
        self.view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.leading.trailing.equalToSuperview()
        }
        
    }
    
    fileprivate func setViewProperties(){
        
        topLabel.font = UIFont.mammaFoodieFontBold(12)
        topLabel.textAlignment = .center
        topLabel.textColor = .white
        topLabel.text = "Please name your broadcast"
        
        
        textField.font = UIFont.mammaFoodieFont(15)
        textField.textAlignment = .left
        textField.backgroundColor = .white
        textField.textAlignment = .center
        
        
        
        
        
    }

}


//NavBar
extension BroadcastTitleViewController : NavBarViewDelegate {
    
    func rightBarButtonTapped(_ sender: AnyObject) {
        
        
    }
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        print("return value to subtitle of tableview cell")
        
        presentingVC?.titleLabel.text = textField.text
        _ = navigationController?.popToViewController(self.presentingVC!, animated: true)
        
       
        
    }
    
    func middleBarButtonTapped(_ Sender: AnyObject) {
        
    }
    
}


extension BroadcastTitleViewController : UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    fileprivate func validate(textField: UITextField) {
        
    }
}
