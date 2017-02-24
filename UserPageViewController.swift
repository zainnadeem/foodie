//
//  UserPageViewController.swift
//  
//
//  Created by Zain Nadeem on 2/24/17.
//
//

import Foundation
import UIKit

enum UserPageViewControllerIndices : Int {
    case profileViewController = 0
    case mainFeedViewController = 1
    case searchViewController = 3
}

class UserPageViewController: UIPageViewController {
    
    var viewsArray : [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accessibilityLabel = "Main User Page View Controller"
        
        self.dataSource = self
        self.delegate = self
        
        // Do any additional setup after loading the view.
        
        self.viewsArray = self.createInitialViewControllers()
        
        self.setViewControllers([self.viewsArray[UserPageViewControllerIndices.userVideoFeed.rawValue]], direction: .forward, animated: true) { (completed) in
            
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createInitialViewControllers() -> [UIViewController]? {
        
        //let userSettingsVC = SideMenuViewController(nibName: nil, bundle: nil)
        let newUserFeed = UserVideoFeedViewController(nibName: nil, bundle: nil)
        let newUserDealsFeed = UserDealsFeedViewController(nibName: nil, bundle: nil)
        
        newUserFeed.accessibilityLabel = "New user feed VC"
        newUserDealsFeed.accessibilityLabel = "New user deal feed"
        // userSettingsVC.accessibilityLabel = "New User Settings"
        
        return [newUserFeed, newUserDealsFeed]
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
    
    
    func navigateToProfileViewController(_ direction: UIPageViewControllerNavigationDirection){
        
        let profileViewIndex = UserPageViewControllerIndices.profileViewController.rawValue
        
        self.setViewControllers([self.viewsArray[userDealIndex]], direction: direction, animated: true) { (completed) in
            if completed {
                let userRoars = self.viewsArray[userDealIndex] as! UserDealsFeedViewController
                userRoars.segmentedController.selectedSegmentIndex = 0
                userRoars.getUserData()
                
                
                
                print("Transitioned to Deals")
            }
        }
    }
    

    
    func navigateToFeedViewController(_ direction: UIPageViewControllerNavigationDirection){
        
        let userVideoFeedIndex = UserPageViewControllerIndices.userVideoFeed.rawValue
        
        self.setViewControllers([self.viewsArray[userVideoFeedIndex]], direction: direction, animated: true) { (completed) in
            if completed {
                print("Transitioned to Feed")
            }
        }    }
    
    
}
