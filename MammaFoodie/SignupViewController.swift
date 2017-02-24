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
    var pictureURL: String?
    
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
        usernameTextField.placeholder = "username"
        passwordTextField.placeholder = "***"
        confirmPasswordTextField.placeholder = "***"
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
        FIRDatabase.database().reference().child("users").childByAutoId().setValue(["email" : emailTextField.text, "username" : usernameTextField.text, "fullName" : fullNameTextField.text])

    }
    
    func displayImagePicker() {
        let imagePicker = UIImagePickerController()
        present(imagePicker, animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        validate(textField: textField)
        
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

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
