//
//  ProfileViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green
        
        view.addSubview(ProfileView(user: User(), frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)))
    }


}
