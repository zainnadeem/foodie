//
//  SignupViewController.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit

class SignupViewController: UIViewController {
    
    var userSelectedManualLogin: Bool!
    
    var profileImageView: UIImageView!
    var changePictureLabel: UILabel!
    var textFieldStackView: UIStackView!
    var emailTextField: UITextField!
    var fullNameTextField: UITextField!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField?
    var confirmPasswordTextField: UITextField?
    var finishButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        finishButton.isEnabled = false

        
    }
    
    func setUpInputFields() {
        
    }
    
    func finishButtonTapped() {
        
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
