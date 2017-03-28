//
//  SignupViewController.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit
import ChameleonFramework
import Firebase
import SDWebImage
import SCLAlertView

class SignupViewController: UIViewController {
    
    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: nil, middleButtonImage: nil)

    let store = DataStore.sharedInstance
    var userSelectedManualLogin: Bool!
    var mediaPickerHelper: MediaPickerHelper!
    
    var email: String?
    var fullName: String?
    var userID: String?
    var pictureURL: URL?
    var credential: FIRAuthCredential?
    
    var profileImageView: UIImageView!
    var changePhotoButton: UIButton!
    
    lazy var completeButton = UIButton()
    lazy var tableView = UITableView()
    let sections = ["Email", "Full Name", "Username"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        view.addSubview(navBar)
        self.navBar.middleButton.title = "Complete Signup"
        self.navBar.leftButton.title = "‹"
        self.navBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: textFieldTableViewCellIdentifier)
        tableView.register(FormTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: formTableViewHeaderViewIdentifier)
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(dismissGesture)
        tableView.addGestureRecognizer(dismissGesture)
        
        setUpProfilePicture()
        setUpInputFields()
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    
    fileprivate func setUpProfilePicture() {
        
        profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2.0
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(125)
            make.centerX.equalToSuperview()
            make.top.equalTo(navBar.snp.bottom).offset(5)
        }
        if let pictureURL = self.pictureURL {
            profileImageView.sd_setImage(with: pictureURL)
        }
        else {
            profileImageView.image = #imageLiteral(resourceName: "profile_placeholder")
        }
        
        let imageViewTapped = UITapGestureRecognizer(target: self, action: #selector(displayImagePicker))
        profileImageView.addGestureRecognizer(imageViewTapped)
        profileImageView.isUserInteractionEnabled = true
        
        changePhotoButton = UIButton(type: .system)
        view.addSubview(changePhotoButton)
        changePhotoButton.setTitle("Change Profile Picture", for: .normal)
        changePhotoButton.titleLabel?.font = UIFont.mammaFoodieFont(16)
        changePhotoButton.addTarget(self, action: #selector(displayImagePicker), for: .touchUpInside)
        changePhotoButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(2)
            make.height.equalTo(30)
        }
    }
    
    fileprivate func setUpInputFields() {
        
        
        completeButton.setTitle("Complete Signup", for: .normal)
        completeButton.titleLabel?.font = UIFont.mammaFoodieFontBold(16)
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.backgroundColor = .black
        completeButton.layer.cornerRadius = 10
        completeButton.layer.borderColor = UIColor.white.cgColor
        completeButton.layer.borderWidth = 1
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
        view.addSubview(completeButton)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(changePhotoButton.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.55)
            make.leading.trailing.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalToSuperview().offset(-5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
    }
    
    func completeButtonTapped() {
        let emailCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextFieldTableViewCell
        let fullNameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! TextFieldTableViewCell
        let usernameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! TextFieldTableViewCell
        if let credential = credential {
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Failed to create a firebase user with facebook or google: \(error.localizedDescription)")
                    return
                }
                guard let user = user else{ return }
                
                let firImage = FIRImage(image: self.profileImageView.image!)
                firImage.save(user.uid) { (downloadURL) in
                    
                    let newUser = User(uid: user.uid, username: usernameCell.textField.text!, fullName: fullNameCell.textField.text!, email: emailCell.textField.text!, bio: "", website: "", location: "", follows: [], followedBy: [], profileImageURL: downloadURL.absoluteString, dishes: [], reviews: [], notifications: [], broadcasts: [], blockedUsers: [], cart: [], totalLikes: 0, averageRating: 0, deviceTokens: [], isAvailable: false, tags: [""], addresses: [], stripeCustomerId: "", stripeAccountId: "")
                    
                    self.store.currentUser = newUser
                    self.store.currentUser.updateUserInfo()
                    
                    
                    
                    guard let id = self.userID else { return }
                    DatabaseReference.tokens(token: id).reference().setValue(user.uid)

                }

            })
            
        }
        
        let pageVC = UserPageViewController()
        present(pageVC, animated: true, completion: nil)

    }
    
    func displayImagePicker() {
        mediaPickerHelper = MediaPickerHelper(viewController: self) { (image) in
            print("in the MediaPickerHelper")
            if let image = image as? UIImage {
                OperationQueue.main.addOperation({
                    self.profileImageView.image = image
                })
            }
        }
    }
    
    func preFillTextFields() {
        let emailCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextFieldTableViewCell
        emailCell.textField.placeholder = "example@example.com"
        
        let fullNameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! TextFieldTableViewCell
        fullNameCell.textField.placeholder = "example@example.com"
        
        let userNameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! TextFieldTableViewCell
        userNameCell.textField.placeholder = "Username"
        userNameCell.textField.autocapitalizationType = .none
        
        if let email = self.email {
            emailCell.textField.text = email
        }
        if let fullName = self.fullName {
            fullNameCell.textField.text = fullName
        }
    }
    
    

}

extension SignupViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCellIdentifier) as! TextFieldTableViewCell
        switch indexPath.section {
        case 0:
            cell.textField.placeholder = "Email"
            if let email = self.email { cell.textField.text = email }
        case 1:
            cell.textField.placeholder = "Full Name"
            if let fullName = self.fullName { cell.textField.text = fullName }
        case 2:
            cell.textField.placeholder = "Username"
            cell.textField.autocapitalizationType = .none
        default: print("we shouldn't get here...")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = FormTableViewHeaderView(reuseIdentifier: formTableViewHeaderViewIdentifier)
        headerView.label.text = sections[section]
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return formTableViewSectionHeaderHeight
    }
    
}

extension SignupViewController : NavBarViewDelegate {
    
    func rightBarButtonTapped(_ sender: AnyObject) {}
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func middleBarButtonTapped(_ Sender: AnyObject) {}
    
}
