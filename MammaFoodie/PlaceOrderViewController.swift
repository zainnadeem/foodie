//
//  PlaceOrderViewController.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/13/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class PlaceOrderViewController: UIViewController {
    
    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: nil, middleButtonImage: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension PlaceOrderViewController: NavBarViewDelegate {
    func leftBarButtonTapped(_ sender: AnyObject) {}
    func middleBarButtonTapped(_ Sender: AnyObject) {}
    func rightBarButtonTapped(_ sender: AnyObject) {}
}
