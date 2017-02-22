//
//  LoginViewController.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/22/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import SnapKit


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var logoView: UIImageView!
    var loginButton: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        setUpViews()
    }
    
    func setUpViews() {
        let logoImage = UIImage(named: "placeholder")
        logoView = UIImageView(image: logoImage)
        view.addSubview(logoView)
        logoView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.75)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(logoView.snp.width)
        }
        
        view.addSubview(loginButton)
        loginButton.setTitle("Log in with Facebook", for: .normal)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottomMargin).offset(30)
            make.centerX.equalToSuperview()
        }

    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print("there was an error while logging in: " + error.localizedDescription)
                return
            }
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
