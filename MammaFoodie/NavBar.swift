//
//  NavBar.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

protocol NavBarViewDelegate : class {
    func rightBarButtonTapped(_ sender : AnyObject)
    func leftBarButtonTapped(_ sender : AnyObject)
    func middleBarButtonTapped(_ Sender : AnyObject)
}

class NavBarView: UIView {
    
    let navBarimageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    let navBarHeightMultiple : CGFloat = 0.10
    let navBarImageInset = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
    let navBarMiddleImageInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    
    var leftButton = UIBarButtonItem()
    var rightButton = UIBarButtonItem()
    var middleButton = UIBarButtonItem()
    
    var topToolBar: UIToolbar = UIToolbar()
    weak var delegate : NavBarViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(withView view : UIView, rightButtonImage : UIImage?, leftButtonImage : UIImage?, middleButtonImage: UIImage?) {
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * navBarHeightMultiple)
        super.init(frame: frame)
        self.createToolBar(leftButtonImage, right: rightButtonImage, middle: middleButtonImage)
    }
    
    init(frame: CGRect, rightButtonImage:UIImage, leftBarButtonImage:UIImage, middleButtonImage: UIImage) {
        super.init(frame: frame)
        self.createToolBar(leftBarButtonImage, right: rightButtonImage, middle: middleButtonImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createToolBar(_ left : UIImage?, right : UIImage?, middle : UIImage?){

        self.topToolBar.barTintColor = UIColor.white
        self.topToolBar.alpha = 1
        self.topToolBar.isTranslucent = true
        
        topToolBar.layer.borderColor = UIColor.black.cgColor
        var barButtons: [UIBarButtonItem] = [UIBarButtonItem]()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        
        leftButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: #selector(leftBarButtonTapped))
        leftButton.tintColor = UIColor.black
        leftButton.image = left
        
        rightButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: #selector(rightBarButtonTapped))
        rightButton.tintColor = UIColor.black
        rightButton.image = right
        
        
        middleButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: #selector(middleBarButtonTapped))
        
        middleButton.tintColor = UIColor.black
        middleButton.image = middle
        
        
        barButtons.append(leftButton)
        barButtons.append(flexSpace)
        barButtons.append(middleButton)
        barButtons.append(flexSpace)
        barButtons.append(rightButton)
        
        
        
        topToolBar.items = barButtons
        rightButton.imageInsets = navBarImageInset
        leftButton.imageInsets = navBarImageInset
        middleButton.imageInsets = navBarImageInset
        
        
        self.addSubview(topToolBar)
        self.constrainViews()
        
    }
    
    
    func constrainViews() {
        self.topToolBar.translatesAutoresizingMaskIntoConstraints = false
        self.topToolBar.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.topToolBar.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.topToolBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.topToolBar.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func rightBarButtonTapped(_ sender: AnyObject) {

        if let delegate = self.delegate {
            delegate.rightBarButtonTapped(sender)
        } else {
            print("I think you forgot to set the delegate for NavBarViewDelegate")
        }
    }
    
    func leftBarButtonTapped(_ sender: AnyObject) {

        if let delegate = self.delegate {
            delegate.leftBarButtonTapped(sender)
        } else {
            print("I think you forgot to set the delegate for NavBarViewDelegate")
        }
    }
    func middleBarButtonTapped(_ sender: AnyObject) {

        if let delegate = self.delegate {
            delegate.middleBarButtonTapped(sender)
        } else {
            print("I think you forgot to set the delegate for NavBarViewDelegate")
        }
    }
    
}
