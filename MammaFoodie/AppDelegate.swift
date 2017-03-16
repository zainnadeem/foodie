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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    let store = DataStore.sharedInstance

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() || FBSDKAccessToken.current() != nil {
            
            var token = String()
            if let user = GIDSignIn.sharedInstance().currentUser{
                token = GIDSignIn.sharedInstance().currentUser.userID
            }else{
                token = FBSDKAccessToken.current().userID
            }
            
            store.getCurrentUserWithToken(token: token, { 
                let pageVC = UserPageViewController()
                self.window?.rootViewController = pageVC
            })
            
            
        }

        
//        let pageVC = UserPageViewController()
//        self.window?.rootViewController = pageVC
        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: [UIApplicationOpenURLOptionsKey.annotation])
        
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
        let signupVC = SignupViewController()
        signupVC.credential = credential
        signupVC.userID = user.userID
        signupVC.fullName = user.profile.name
        signupVC.email = user.profile.email
        signupVC.userSelectedManualLogin = false
        signupVC.pictureURL = user.profile.imageURL(withDimension: 300)
        self.window?.rootViewController = signupVC
        
    }
//
//    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
//                withError error: NSError!) {
//        // Perform any operations when the user disconnects from app here.
//        // ...
//    }

    


}

