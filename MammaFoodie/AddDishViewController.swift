//
//  AddDishViewController.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/7/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit

class AddDishViewController: UIViewController {
    
    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "icon-profile"), middleButtonImage: nil)
    
    var sendingViewController: UIViewController?
    let store = DataStore.sharedInstance
    
    lazy var tableView = UITableView()
    lazy var addButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navBar.delegate = self
        navBar.middleButton.title = "Add a New Dish"
        
        addButton.setTitle("Add Dish", for: .normal)
        addButton.titleLabel?.font = UIFont.mammaFoodieFontBold(16)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .black
        addButton.layer.cornerRadius = 10
        addButton.layer.borderColor = UIColor.white.cgColor
        addButton.layer.borderWidth = 1
        addButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(navBar)
        
        setConstraints()
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.leading.trailing.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func dismissAction() {
        let newDish = Dish(uid: store.currentUser.uid, name: "Pizza", description: "delicious", mainImage: #imageLiteral(resourceName: "profile_placeholder"), price: 10, likedBy: [], averageRating: 0)
        store.currentUser.dishes.append(newDish)
        newDish.save { (url) in
            print("The dish was successfully saved with download URL \(url)")
        }
        if let profileVC = sendingViewController as? ProfileViewController {
            self.dismiss(animated: true) {
                profileVC.profileView.tableView.reloadData()
            }
        }
    
    }


}

extension AddDishViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}

extension AddDishViewController: NavBarViewDelegate {
    func rightBarButtonTapped(_ sender: AnyObject) {
        
    }
    
    func middleBarButtonTapped(_ Sender: AnyObject) {
        
    }
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
