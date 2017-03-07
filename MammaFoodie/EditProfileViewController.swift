//
//  EditProfileViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/7/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    //username fullname bio city image
    
    lazy var navBar:             NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "settings"), middleButtonImage: nil)
    lazy var profileImageView:       UIImageView = UIImageView()
    lazy var tableView:          UITableView = UITableView()
    lazy var saveButton:         UIButton    = UIButton()
    
    var sections = ["username", "fullname", "website", "tags", "bio"]
    let store = DataStore.sharedInstance
    
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navBar.middleButton.title = "Edit Profile"
        
        self.navBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: textFieldTableViewCellIdentifier)
        self.tableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: textViewTableViewCellIdentifier)
        
        setViewConstraints()
        setViewProperties()
        
    }
    
   
    func setViewConstraints(){
        
        self.view.addSubview(navBar)
        
        self.view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(5)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.centerX.equalToSuperview()
        }
        
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.6)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.view.addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.1)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)

            
        }
    }
    
    func setViewProperties(){

        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.layer.cornerRadius = 10
        self.profileImageView.layer.borderColor = UIColor.black.cgColor
        self.profileImageView.layer.borderWidth = 2
        self.profileImageView.clipsToBounds = true
        self.profileImageView.image = store.currentUser.profileImage

        saveButton.setTitle("save", for: .normal)
        saveButton.titleLabel?.font = UIFont.mammaFoodieFontBold(16)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .black
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.borderWidth = 1
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
    }
    
    
    
    func saveButtonTapped(){
        let userNameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextFieldTableViewCell
        let fullNameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! TextFieldTableViewCell
        let websiteCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! TextFieldTableViewCell
        let tagsCell = tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as! TextFieldTableViewCell
        let bioCell = tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as! TextViewTableViewCell
        
        if let username     = userNameCell.textField.text     { store.currentUser.username   = username }
        if let fullName     = fullNameCell.textField.text     { store.currentUser.fullName   = fullName }
        if let website      = websiteCell.textField.text      { store.currentUser.website    = website }
        if let tags         = tagsCell.textField.text         { store.currentUser.tags       = tags.components(separatedBy: ",")}
        if let bio          = bioCell.textView.text           { store.currentUser.bio        = bio }

        
        //save to firebase
        self.dismiss(animated: true, completion: nil)
        
    }
}

extension EditProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath == IndexPath(row: 0, section: 4){
            let cell  = tableView.dequeueReusableCell(withIdentifier: textViewTableViewCellIdentifier, for: indexPath) as! TextViewTableViewCell
            cell.textView.delegate = self
            return cell
        }else{
            let cell  = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.delegate = self
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let label = UILabel()
        label.text = sections[section]
        label.font = UIFont.mammaFoodieFontBold(15)
        
        
        label.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35)
        label.textAlignment = .center
        
        
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    
}

extension EditProfileViewController: UITableViewDelegate, UITextViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(indexPath.section)
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 0, section: 4){
            return self.view.frame.height / 3
        }else{
            return 44
        }
    }
    
    
}


//NavBar
extension EditProfileViewController : NavBarViewDelegate {
    
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


extension EditProfileViewController : UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    fileprivate func validate(textField: UITextField) {
        
    }
}

