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


class SignupViewController: UIViewController {
    
    var userSelectedManualLogin: Bool!
    
    var email: String?
    var fullName: String?
    var userID: String?
    var pictureURL: NSURL?
    var credential: FIRAuthCredential?
    
    var profileImageView: UIImageView!
    var changePhotoLabel: UILabel!
    var textFieldStackView: UIStackView!
    var emailTextField = UITextField()
    var fullNameTextField = UITextField()
    var usernameTextField = UITextField()
    var passwordTextField = UITextField()
    var confirmPasswordTextField = UITextField()
    var completeButton: FoodieButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.flatMint
        
        setUpProfilePicture()
        setUpInputFields()
    }
    
    
    fileprivate func setUpProfilePicture() {
        let profileImage = UIImage(named: "profile_placeholder")
        profileImageView = UIImageView(image: profileImage)
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(75)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
        let imageViewTapped = UITapGestureRecognizer(target: self, action: #selector(displayImagePicker))
        profileImageView.addGestureRecognizer(imageViewTapped)
        profileImageView.isUserInteractionEnabled = true
        
        changePhotoLabel = UILabel()
        view.addSubview(changePhotoLabel)
        changePhotoLabel.text = "Change Profile Picture"
        changePhotoLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(5)
        }
    }
    
    fileprivate func setUpInputFields() {
        emailTextField.placeholder = "example@example.com"
        fullNameTextField.placeholder = "Full name"
        usernameTextField.placeholder = "Username"
        usernameTextField.autocapitalizationType = .none
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.placeholder = "Confirm password"
        confirmPasswordTextField.isSecureTextEntry = true
        
        if let email = self.email {
            emailTextField.text = email
        }
        if let fullName = self.fullName {
            fullNameTextField.text = fullName
        }
        
        textFieldStackView = UIStackView(arrangedSubviews: [emailTextField, fullNameTextField, usernameTextField, passwordTextField, confirmPasswordTextField])
        view.addSubview(textFieldStackView)
        textFieldStackView.distribution = .fillEqually
        textFieldStackView.axis = .vertical
        textFieldStackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
            make.centerY.equalToSuperview()
        }
        
        if userSelectedManualLogin == false {
            passwordTextField.isHidden = true
            confirmPasswordTextField.isHidden = true
        }
        
        completeButton = FoodieButton(type: .system)
//        completeButton.isEnabled = false
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        completeButton.titleLabel?.textAlignment = .center
        view.addSubview(completeButton)
        completeButton.backgroundColor = FlatWhite()
        completeButton.setTitle("Complete signup", for: .normal)
        completeButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(textFieldStackView.snp.bottom).offset(30)
            make.height.equalTo(50)
        }
        
    }
    
    func completeButtonTapped() {
//        let user = User(uid: <#T##String#>, username: <#T##String#>, fullName: <#T##String#>, bio: <#T##String#>, website: <#T##String#>, location: <#T##String#>, follows: <#T##[User]#>, followedBy: <#T##[User]#>, profileImage: <#T##UIImage?#>, dishes: <#T##[Dish]#>, reviews: <#T##[Review]#>, notifications: <#T##[Notification]#>, broadcasts: <#T##[Broadcast]#>, blockedUsers: <#T##[User]#>, totalLikes: <#T##Int#>, averageRating: <#T##Int#>, deviceTokens: <#T##[String]#>)
        FIRDatabase.database().reference().child("users/\(userID!)").setValue(["email" : emailTextField.text, "username" : usernameTextField.text, "fullName" : fullNameTextField.text])
        
        if let credential = credential {
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Failed to create a firebase user with facebook or google: \(error.localizedDescription)")
                    return
                }
            })
        }
        
        
        let pageVC = UserPageViewController()
        present(pageVC, animated: true, completion: nil)

    }
    
    func displayImagePicker() {
        let imagePicker = UIImagePickerController()
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    

}

extension SignupViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    fileprivate func validate(textField: UITextField) {
        if textField === emailTextField {
            
        }
            
        else if textField === fullNameTextField {
            
        }
            
        else if textField === usernameTextField {
            
        }
            
        else if textField === passwordTextField {
            
        }
            
        else if textField === confirmPasswordTextField {
            
        }
    }
}
