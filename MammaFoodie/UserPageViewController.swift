//
//  UserPageViewController.swift
//
//
//  Created by Zain Nadeem on 2/24/17.
//
//

import Foundation
import UIKit
import SnapKit

enum UserPageViewControllerIndices : Int {
    case settingViewController = 0
    case profileViewController = 1
    case mainFeedViewController = 2
    case searchViewController = 3
}

class UserPageViewController: UIPageViewController {
    
    var viewsArray : [UIViewController]!
    
    var cartView: FloatingCartView = FloatingCartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        self.accessibilityLabel = "Main User Page View Controller"
        
        self.dataSource = self
        self.delegate = self
        
        // Do any additional setup after loading the view.
        
        self.viewsArray = self.createInitialViewControllers()
        
        self.setViewControllers([self.viewsArray[UserPageViewControllerIndices.mainFeedViewController.rawValue]], direction: .forward, animated: true) { (completed) in
            
            if completed {
                print("Successfully set initial view controller")
            } else {
                print("Unsuccessfully set view controller")
            }
            
            for viewController in self.viewControllers! {
                print("PageVC contains: \(viewController.accessibilityLabel)")
            }
        }
    }
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createInitialViewControllers() -> [UIViewController]? {
        
        let settingsVC = SettingsViewController(nibName: nil, bundle: nil)
        let profileVC = ProfileViewController(nibName: nil, bundle: nil)
        profileVC.user = DataStore.sharedInstance.currentUser
        let mainFeedVC = MainFeedViewController(nibName: nil, bundle: nil)
        let searchVC = SearchViewController(nibName: nil, bundle: nil)
        
        
        settingsVC.accessibilityLabel = "settingsVC"
        profileVC.accessibilityLabel = "profile VC"
        mainFeedVC.accessibilityLabel = "mainFeed VC"
        searchVC.accessibilityLabel = "search VC"
        
        
        return [settingsVC, profileVC, mainFeedVC, searchVC]
    }
    
    func setUpCartView() {
        if !(DataStore.sharedInstance.currentUser.cart.isEmpty) {
            cartView.updateLabels()
            view.addSubview(cartView)
            cartView.snp.makeConstraints { (make) in
                make.bottom.centerX.width.equalToSuperview()
                make.height.equalTo(50)
            }
            let cartTapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPlaceOrderView))
            cartView.addGestureRecognizer(cartTapGesture)
        }
        else {
            cartView.removeFromSuperview()
        }
    }
    
    func presentPlaceOrderView() {
        let placeOrderVC = PlaceOrderViewController()
        self.present(placeOrderVC, animated: true, completion: nil)
    }
    
}

extension UserPageViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = self.viewControllers?.first else { return nil }
        
        guard let index = self.viewsArray.index(of: currentVC) else { return nil }
        
        if index == 0 {
            return nil
        } else {
            return self.viewsArray[index - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = self.viewControllers?.first else { return nil }
        
        guard let index = self.viewsArray.index(of: currentVC) else { return nil }
        
        if index == self.viewsArray.count - 1 {
            return nil
        } else {
            return self.viewsArray[index + 1]
        }
        
    }
    
    func navigateToSettingsViewController(_ direction: UIPageViewControllerNavigationDirection){
        
        let profileViewIndex = UserPageViewControllerIndices.settingViewController.rawValue
        
        self.setViewControllers([self.viewsArray[profileViewIndex]], direction: direction, animated: true) { (completed) in
            if completed {
                
                print("transitioned to settings")
            }
        }
    }
    
    func navigateToProfileViewController(_ direction: UIPageViewControllerNavigationDirection){
        
        let profileViewIndex = UserPageViewControllerIndices.profileViewController.rawValue
        
        self.setViewControllers([self.viewsArray[profileViewIndex]], direction: direction, animated: true) { (completed) in
            if completed {
                
                print("transitioned to profile")
            }
        }
    }
    
    
    
    func navigateToMainFeedViewController(_ direction: UIPageViewControllerNavigationDirection){
        
        let mainFeedVC = UserPageViewControllerIndices.mainFeedViewController.rawValue
        
        self.setViewControllers([self.viewsArray[mainFeedVC]], direction: direction, animated: true) { (completed) in
            if completed {
                
                
                print("Transitioned to mainFeed")
            }
        }
    }
    
    func navigateToSearchViewController(_ direction: UIPageViewControllerNavigationDirection){
        
        let searchVC = UserPageViewControllerIndices.searchViewController.rawValue
        
        self.setViewControllers([self.viewsArray[searchVC]], direction: direction, animated: true) { (completed) in
            if completed {
                
                
                print("Transitioned to search")
            }
        }
    }
    
    
}
