//
//  SelectAddressViewController.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class SelectAddressViewController: UIViewController {
    
    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "cross_icon"), middleButtonImage: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension SelectAddressViewController: NavBarViewDelegate {
    func leftBarButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    func middleBarButtonTapped(_ Sender: AnyObject) {}
    func rightBarButtonTapped(_ sender: AnyObject) {}
}
