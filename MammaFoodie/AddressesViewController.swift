//
//  AddressesViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/6/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class AddressesViewController: UIViewController {
    
    lazy var navBar:                NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "settings"), middleButtonImage: nil)
    lazy var tableView:             UITableView = UITableView()
    
    let store = DataStore.sharedInstance
    let addAddressButton: UIButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
         self.view.backgroundColor = .white
        self.navBar.middleButton.title = "Addresses"
        
        self.tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: infoTableViewCellIdentifier)
        
        self.setViewConstraints()
        self.setViewProperties()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        OperationQueue.main.addOperation { 
            self.tableView.reloadData()
        }
        
    }
    
    private func setViewConstraints(){
        
        self.view.addSubview(navBar)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.82)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.view.addSubview(addAddressButton)
        addAddressButton.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            
        }
    }
   
    func setViewProperties(){
        addAddressButton.setTitle("add address", for: .normal)
        addAddressButton.titleLabel?.font = UIFont.mammaFoodieFontBold(16)
        addAddressButton.setTitleColor(.white, for: .normal)
        addAddressButton.backgroundColor = .black
        addAddressButton.layer.cornerRadius = 10
        addAddressButton.layer.borderColor = UIColor.white.cgColor
        addAddressButton.layer.borderWidth = 1
        
        addAddressButton.addTarget(self, action: #selector(addAddressButtonTapped), for: .touchUpInside)
    }

    func addAddressButtonTapped(){
        let destinationVC = AddAddressViewController()
        self.present(destinationVC, animated: true, completion: nil)
        
    }

    
}

extension AddressesViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.currentUser.addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: infoTableViewCellIdentifier, for: indexPath) as! InfoTableViewCell
        cell.user = store.currentUser
        cell.address = store.currentUser.addresses[indexPath.row]
        cell.updateUIWithAddress()
        return cell
        
        
        
    }
}

extension AddressesViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 0, section: 0) { return self.view.bounds.width / 4 } else {
            return self.view.bounds.width / 4 }
    }
 

}


extension AddressesViewController : NavBarViewDelegate {
    
    func rightBarButtonTapped(_ sender: AnyObject) {

        
    }
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func middleBarButtonTapped(_ Sender: AnyObject) {
        let index = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: index, at: .top, animated: true)
    }
    
}
