//
//  AppDelegate.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 2/22/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn
import IQKeyboardManagerSwift
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    let store = DataStore.sharedInstance

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Stripe
        STPPaymentConfiguration.shared().publishableKey = stripePublishableKey

        FIRApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        guard let signIn = GIDSignIn.sharedInstance() else { fatalError() }
        signIn.scopes = ["https://www.googleapis.com/auth/plus.stream.read", "https://www.googleapis.com/auth/plus.me", "https://www.googleapis.com/auth/plus.login"]
        signIn.clientID = FIRApp.defaultApp()?.options.clientID
        signIn.delegate = self
        if signIn.hasAuthInKeychain() {
            signIn.signInSilently()
        }
        
        if signIn.hasAuthInKeychain() || FBSDKAccessToken.current() != nil {
            
            var token = String()
            if let user = signIn.currentUser{
                token = user.userID
            } else{
                token = FBSDKAccessToken.current().userID
            }
            
            store.getCurrentUserWithToken(token: token, { 
                OperationQueue.main.addOperation({ 
                    self.setUpNavigationController()
                })
            })
            

//
//            
//            let pageVC = UserPageViewController()
//            self.window?.rootViewController = pageVC


        }
        
        else {
            let loginVC = LoginViewController()
            self.window?.rootViewController = loginVC
        }
        
        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: [UIApplicationOpenURLOptionsKey.annotation])
        
        if (url.scheme == "mammafoodie") {
            let queryParams: [Any] = url.query!.components(separatedBy: "&")
            var codeParam: [Any] = queryParams.filter { NSPredicate(format: "SELF BEGINSWITH %@", "code=").evaluate(with: $0) }
            let codeQuery: String? = (codeParam[0] as? String)
            let code: String? = codeQuery?.replacingOccurrences(of: "code=", with: "")
            print("My code is \(code)")
            // Finish the OAuth flow with this code
            return true
        }
        
       
        
        
        return handled
    }
   
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            
            print("there was an error logging in with google: \(error.localizedDescription)")
            
            return
        }
        
        print("successfully logged in with google")
        
        
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        FirebaseAPIClient.checkForUserToken(for: user.userID) { (userExists) in
            if userExists {
                OperationQueue.main.addOperation({ 
                    self.setUpNavigationController()
                })
                
            }
            else {
                let signupVC = SignupViewController()
                signupVC.credential = credential
                signupVC.userID = user.userID
                signupVC.fullName = user.profile.name
                signupVC.email = user.profile.email
                signupVC.userSelectedManualLogin = false
                signupVC.pictureURL = user.profile.imageURL(withDimension: 300)
                OperationQueue.main.addOperation({ 
                    self.window?.rootViewController = signupVC
                })
                
            }
        }
        
        
    }

    func setUpNavigationController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav1 = UINavigationController()
        let mainView = UserPageViewController()
        nav1.viewControllers = [mainView]
        nav1.setNavigationBarHidden(true, animated: false)
        nav1.view.backgroundColor = .white
        self.window!.rootViewController = nav1
        self.window?.makeKeyAndVisible()
    }



    
   

}

