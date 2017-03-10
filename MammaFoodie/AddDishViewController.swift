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
    
    var sendingViewController: UIViewController?
    
    lazy var tableView = UITableView()
    lazy var addButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addButton.setTitle("Add Dish", for: .normal)
        addButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        setConstraints()
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.leading.trailing.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom).offset(10)
        }
    }
    
    func dismissAction() {
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
