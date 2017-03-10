//
//  AddAddressViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/3/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class AddAddressViewController: UIViewController {
    
    lazy var navBar:                NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "settings"), middleButtonImage: nil)
    
    lazy var tableView:              UITableView = UITableView()
    lazy var saveButton:             UIButton    = UIButton()
    
    let store = DataStore.sharedInstance
    
    var sections = ["Title e.g home, work", "Address*","Apt/Suite#","City*", "State*", "Postal Code*", "Cross Street", "Phone*"]
    
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navBar.middleButton.title = "Add Address"
        self.navBar.delegate = self

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: textViewTableViewCellIdentifier)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultReuseIdentifier)
        self.tableView.register(FormTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: formTableViewHeaderViewIdentifier)
        
        setViewConstraints()
        setViewProperties()

    }
    
    func setViewConstraints(){
       
        self.view.addSubview(navBar)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.82)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.view.addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            
        }
    }
    
    func setViewProperties(){
        saveButton.setTitle("save", for: .normal)
        saveButton.titleLabel?.font = UIFont.mammaFoodieFontBold(16)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .black
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.borderWidth = 1
 
        saveButton.addTarget(self, action: #selector(saveAddress), for: .touchUpInside)
    
    }
    
    
    func saveAddress(){

        let titleCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextFieldTableViewCell
        let addressCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! TextFieldTableViewCell
        let aptSuiteCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! TextFieldTableViewCell
        let cityCell = tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as! TextFieldTableViewCell
        let stateCell = tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as! TextFieldTableViewCell
        let postalCell = tableView.cellForRow(at: IndexPath(row: 0, section: 5)) as! TextFieldTableViewCell
        let crossStreetCell = tableView.cellForRow(at: IndexPath(row: 0, section: 6)) as! TextFieldTableViewCell
        let phoneCell = tableView.cellForRow(at: IndexPath(row: 0, section: 7)) as! TextFieldTableViewCell

        
        let address = Address.init()
        
        if let title        = titleCell.textField.text          { address.title = title }
        if let addressLine  = addressCell.textField.text        { address.addressLine = addressLine }
        if let aptSuite     = aptSuiteCell.textField.text       { address.aptSuite = aptSuite }
        if let city         = cityCell.textField.text           { address.city = city }
        if let state        = stateCell.textField.text          { address.state = state }
        if let postal       = postalCell.textField.text         { address.postalCode = postal }
        if let crossStreet  = crossStreetCell.textField.text    { address.crossStreet = crossStreet }
        if let phone        = phoneCell.textField.text          { address.phone = phone }

        //save to firebase 
        
        //add to current user
        store.currentUser.addresses.append(address)
        self.dismiss(animated: true, completion: nil)
    
    }
}

extension AddAddressViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: textViewTableViewCellIdentifier, for: indexPath) as! TextFieldTableViewCell
        cell.textField.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = FormTableViewHeaderView(reuseIdentifier: formTableViewHeaderViewIdentifier)
        view.label.text = sections[section]
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    
    
}

extension AddAddressViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(indexPath.section)
        print(indexPath.row)
    }

    
}


//NavBar
extension AddAddressViewController : NavBarViewDelegate {
    
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


extension AddAddressViewController : UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
    }
    
    fileprivate func validate(textField: UITextField) {

    }
}


