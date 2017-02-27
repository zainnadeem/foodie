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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() || FBSDKAccessToken.current() != nil {
            let pageVC = UserPageViewController()
            self.window?.rootViewController = pageVC
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: [UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    }
    

   
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            
            print("there was an error logging in with google: \(error.localizedDescription)")
            
            return
        }
        
        print("successfully logged in with google")
        
        
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        // ...
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print("Failed to create a firebase user with google: \(error.localizedDescription)")
                return
            }
            
            print("Successfully created a firebase user with google")
            let signupVC = SignupViewController()
            self.window?.rootViewController = signupVC
        })
    }
//
//    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
//                withError error: NSError!) {
//        // Perform any operations when the user disconnects from app here.
//        // ...
//    }

    


}

