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
    case searchViewController = 2
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
    
    
    func createInitialViewControllers() -> [UIViewController]? {
        
        let profileVC = ProfileViewController(nibName: nil, bundle: nil)
        let mainFeedVC = MainFeedViewController(nibName: nil, bundle: nil)
        let searchVC = SearchViewController(nibName: nil, bundle: nil)
        
        profileVC.accessibilityLabel = "profile VC"
        mainFeedVC.accessibilityLabel = "mainFeed VC"
        searchVC.accessibilityLabel = "search VC"
        
        return [profileVC, mainFeedVC, searchVC]
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
        
        self.setViewControllers([self.viewsArray[profileViewIndex]], direction: direction, animated: true) { (completed) in
            if completed {
                
                print("ProfileViewController")
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
