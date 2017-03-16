//
//  BroadcastDescriptionViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/15/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class BroadcastDescriptionViewController: UIViewController {
    
    lazy var navBar:                 NavBarView      = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: nil, middleButtonImage: nil)
    lazy var topLabel:               UILabel         = UILabel()
    lazy var textView:              UITextView     = UITextView()
    
    var presentingVC:    ScheduleBroadcastViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.navBar.leftButton.title = "back"
        self.navBar.delegate = self
        
        textView.delegate = self
        
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
        
        self.view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.leading.trailing.equalToSuperview()
        }
        
    }
    
    fileprivate func setViewProperties(){
        
        topLabel.font = UIFont.mammaFoodieFontBold(12)
        topLabel.textAlignment = .center
        topLabel.textColor = .white
        topLabel.text = "Describe your broadcast"
        
        
        textView.font = UIFont.mammaFoodieFont(15)
        textView.textAlignment = .left
        textView.backgroundColor = .white
        textView.textAlignment = .center
        
        
        
        
    }
    
}


//NavBar
extension BroadcastDescriptionViewController : NavBarViewDelegate {
    
    func rightBarButtonTapped(_ sender: AnyObject) {
        
        
    }
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        print("return value to subtitle of tableview cell")
        
        presentingVC?.descriptionLabel.text = textView.text
        _ = navigationController?.popToViewController(self.presentingVC!, animated: true)
        
        
        
    }
    
    func middleBarButtonTapped(_ Sender: AnyObject) {
        
    }
    
}


extension BroadcastDescriptionViewController : UITextViewDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    fileprivate func validate(textField: UITextField) {
        
    }
}

