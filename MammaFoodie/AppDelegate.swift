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
import SCLAlertView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    let store = DataStore.sharedInstance

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

        //Stripe
        STPPaymentConfiguration.shared().publishableKey = stripePublishableKey
        
        let address1 = Address(title: "home", addressLine: "11 Broadway", aptSuite: "Suite 260", city: "New York", state: "NY", postalCode: "10004", crossStreet: "", phone: "5555555555")

        let address2 = Address(title: "work", addressLine: "1000 Broadway", aptSuite: "", city: "New York", state: "NY", postalCode: "10010", crossStreet: "", phone: "2222222222")
        
//        PostmatesAPIClient.checkIfDeliveryIsAvailable(pickupAddress: "41 E 7th St, New York, NY", dropOffAddress: "11 Broadway, New York, NY") { (success, response) in
//            print("hello")
//            if success {
//                print(response)
//            }
//        }
        
        PostmatesAPIClient.createDeliveryRequest(manifest: "Delicious food", pickupAddress: address1, dropoffAddress: address2) { (success, response) in
            print("hello")
            if success {
                print(response)
            }
        }
        

        
        if FBSDKAccessToken.current() != nil {
            let token = FBSDKAccessToken.current().userID
            store.getCurrentUserWithToken(token: token!, {
                OperationQueue.main.addOperation({
                    self.setUpNavigationController()
                })
                
                
            })
            
        } else {
            let loginVC = LoginViewController()
            self.window?.rootViewController = loginVC
        }
        
        

        let uberClient = UberAPIClient(pickup: address1, dropoff: address2, chef: User(), purchasingUser: self.store.currentUser)
        
                        uberClient.getDeliveryQuote(completion: { (quoteID) in
                            print(quoteID)
                        })
        
        
        
        guard let signIn = GIDSignIn.sharedInstance() else { fatalError() }
        signIn.scopes = ["https://www.googleapis.com/auth/plus.stream.read", "https://www.googleapis.com/auth/plus.me", "https://www.googleapis.com/auth/plus.login"]
        signIn.clientID = FIRApp.defaultApp()?.options.clientID
        signIn.delegate = self
        if signIn.hasAuthInKeychain() {
            signIn.signInSilently()
        }
        

        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        
        if url.scheme == "mammafoodie-uber" {
            let urlString = url.relativeString
            let codeRange = urlString.range(of: "code=")
            let authCode = urlString.substring(from: (codeRange?.upperBound)!)
            print(authCode)
            UberAPIClient.getAccessToken(authorizationCode: authCode, completion: { (response) in
                print(response)
                guard let response = response else { print("no response from uber authorization"); return }
                if let accessToken = response["access_token"] as? String, let refreshToken = response["refresh_token"] as? String {
                    self.store.currentUser.uberAccessToken = accessToken
                    self.store.currentUser.uberRefreshToken = refreshToken
                    self.store.currentUser.registerUberTokens(accessToken: accessToken, refreshToken: refreshToken)
                }
            })
        }
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: [UIApplicationOpenURLOptionsKey.annotation])
        
        
        
        //receive stripe oauth token
        if url.scheme == "mammafoodie"{
            let query = url.query?.replacingPercentEscapes(using: String.Encoding.utf8)
            let data: Data? = query?.data(using: String.Encoding.utf8)
            var json = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String : AnyObject]
            
            let errorString: String? = (json?["error"] as? String)
            
            var accessToken: String? = (json?["access_token"] as? String)
           
            var stripePubKey: String? = (json?["stripe_publishable_key"] as? String)
            
            var stripeUserId: String? = (json?["stripe_user_id"] as? String)
            
            if errorString != nil {
            
                print(errorString)
            
            } else {
                
                self.store.currentUser.stripeAccountId = stripeUserId!
                self.store.currentUser.registerStripeAccountId(id: stripeUserId!)
                
                showSuccess()
            }
        }
        
        
        
        return handled

    }

    func getQueryStringParameter(url: String?, param: String) -> String? {
        if let url = url, let urlComponents = URLComponents(string: url), let queryItems = (urlComponents.queryItems) {
            return queryItems.filter({ (item) in item.name == param }).first?.value!
        }
        return nil
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
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
                print("User exists!")
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
        if signIn.hasAuthInKeychain() {
            var token = String()
            
            if let user = signIn.currentUser{
                token = user.userID
            }
            
            store.getCurrentUserWithToken(token: token, {
                OperationQueue.main.addOperation({
                    self.setUpNavigationController()
                })
                
                
            })
            
        } else {
            let loginVC = LoginViewController()
            self.window?.rootViewController = loginVC
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


    func showSuccess(){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            hideWhenBackgroundViewIsTapped: true
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Successful") {}

        alertView.showWarning("Great!", subTitle: "You're all set up to receive payments!")
    }
    
    
    
}



