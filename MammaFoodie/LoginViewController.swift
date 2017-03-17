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
import GoogleSignIn


class LoginViewController: UIViewController {
    
    var logoView: UIImageView!
    var fbLoginButton: FBSDKLoginButton!
    var googleLoginButton: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        fbLoginButton = FBSDKLoginButton()
        fbLoginButton.readPermissions = ["public_profile", "email"]
        fbLoginButton.delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        googleLoginButton = GIDSignInButton()
        
        setUpViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        
        view.addSubview(fbLoginButton)
        fbLoginButton.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottomMargin).offset(30)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(googleLoginButton)
        googleLoginButton.snp.makeConstraints { (make) in
            make.top.equalTo(fbLoginButton.snp.bottomMargin).offset(20)
            make.centerX.equalToSuperview()
        }

    }

}

extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("there was an error while logging in with facebook: \(error.localizedDescription)")
            return
        }
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, picture.width(300).height(300)"]).start { (connection, result, error) in
            if error != nil {
                print("there was an error with the fb graph request: \(error?.localizedDescription)")
            }
            print("result: \(result)")
            if let result = result as? [String: Any] {
                let signupVC = SignupViewController()
                
                let email = result["email"] as! String
                let fullName: String = result["name"] as! String
                let pictureDict = result["picture"] as! [String: Any]
                let pictureData = pictureDict["data"] as! [String: Any]
                let pictureURL = pictureData["url"] as! String
                let id = result["id"] as! String
                
                FirebaseAPIClient.checkForUserToken(for: id, completion: { (userExists) in
                    if(userExists) {
                        let nav1 = UINavigationController()
                        let mainView = UserPageViewController()
                        nav1.viewControllers = [mainView]
                        nav1.setNavigationBarHidden(true, animated: false)
                        nav1.view.backgroundColor = .white
                        OperationQueue.main.addOperation({
                            self.present(nav1, animated: true, completion: nil)
                        })
                    }
                    else {
                        signupVC.email = email
                        signupVC.fullName = fullName
                        signupVC.userID = id
                        signupVC.pictureURL = URL(string: pictureURL)
                        signupVC.userSelectedManualLogin = false
                        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                        signupVC.credential = credential
                        OperationQueue.main.addOperation({
                            self.present(signupVC, animated: true, completion: nil)
                        })
                    }
                })
                
                
                
            }
            
        }
        
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out of Facebook")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LoginViewController: GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            
            print("there was an error while logging in: " + error.localizedDescription)
            
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        // ...
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            // ...
            if let error = error {
                
                print("there was an error while logging in: " + error.localizedDescription)
                
                return
            }
        }
    }
}
