//
//  MainFeedViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/24/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class MainFeedViewController: UIViewController {
    
    
    let featuredChefCollectionView = UICollectionView()
    let cookingNowCollectionView = UICollectionView()
    let liveNowCollectionView = UICollectionView()
    let upcomingBroadcastsCollectionView = UICollectionView()
    
    
    let featuredChefCollectionViewIdentifier = "featuredChefCollectionViewCell"
    let cookingNowCollectionViewIdentifier = "cookingNowCollectionViewCell"
    let liveNowCollectionViewIdentifier = "liveNowCollectionViewCell"
    let upcomingBroadcastsViewIdentifier = "upcomingBroadcastsViewCell"
    
    lazy var navBar : NavBarView = NavBarView(withView: self.view, rightButtonImage: #imageLiteral(resourceName: "searchIcon"), leftButtonImage: #imageLiteral(resourceName: "icon-profile"), middleButtonImage: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initializeCollectionViews()
        self.setViewConstraints()
        self.createLayout()
        self.view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
    }

}



extension MainFeedViewController: UICollectionViewDelegate {
    
    func initializeCollectionViews(){

        featuredChefCollectionView.delegate = self
        featuredChefCollectionView.delegate = self
        
        cookingNowCollectionView.delegate = self
        cookingNowCollectionView.dataSource = self
        
        liveNowCollectionView.delegate = self
        liveNowCollectionView.delegate = self
        
        
        upcomingBroadcastsCollectionView.delegate = self
        upcomingBroadcastsCollectionView.delegate = self
        
        
        featuredChefCollectionView.register(FeaturedChefCollectionViewCell.self, forCellWithReuseIdentifier: featuredChefCollectionViewIdentifier)
        cookingNowCollectionView.register(CookingNowCollectionViewCell.self, forCellWithReuseIdentifier: cookingNowCollectionViewIdentifier)
        liveNowCollectionView.register(LiveNowCollectionViewCell.self, forCellWithReuseIdentifier: liveNowCollectionViewIdentifier)
        upcomingBroadcastsCollectionView.register(UpcomingBroadcastsCollectionViewCell.self, forCellWithReuseIdentifier: upcomingBroadcastsViewIdentifier)
  
    }
    

    }

//Set View Constraints
extension MainFeedViewController {
    
    func setViewConstraints(){
        
        self.view.addSubview(navBar)
        
        view.addSubview(featuredChefCollectionView)
        featuredChefCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.20)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        view.addSubview(cookingNowCollectionView)
        cookingNowCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(featuredChefCollectionView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.20)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(liveNowCollectionView)
        liveNowCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(cookingNowCollectionView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.20)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(upcomingBroadcastsCollectionView)
        upcomingBroadcastsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(liveNowCollectionView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.20)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }

    }
    
    func createLayout(){
        
        let featuredChefLayout = UICollectionViewFlowLayout()
        featuredChefLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        featuredChefLayout.itemSize = CGSize(width: 70, height: 70)
        
        featuredChefCollectionView.collectionViewLayout = featuredChefLayout
        
        let cookingNowLayout = UICollectionViewFlowLayout()
        cookingNowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        cookingNowLayout.itemSize = CGSize(width: 70, height: 70)
        
        cookingNowCollectionView.collectionViewLayout = featuredChefLayout
        
        let liveNowLayout = UICollectionViewFlowLayout()
        liveNowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        liveNowLayout.itemSize = CGSize(width: 70, height: 70)
        
        liveNowCollectionView.collectionViewLayout = featuredChefLayout
        
        let upcomingBroadcastLayout = UICollectionViewFlowLayout()
        upcomingBroadcastLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        upcomingBroadcastLayout.itemSize = CGSize(width: 70, height: 70)
        
        upcomingBroadcastsCollectionView.collectionViewLayout = featuredChefLayout

        
    }
}

extension MainFeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch collectionView {
        
        case featuredChefCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featuredChefCollectionViewIdentifier, for: indexPath) as! FeaturedChefCollectionViewCell
            cell.updateUI()
            return cell

        case cookingNowCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cookingNowCollectionViewIdentifier, for: indexPath) as! CookingNowCollectionViewCell
            cell.updateUI()
            return cell

        case liveNowCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveNowCollectionViewIdentifier, for: indexPath) as! LiveNowCollectionViewCell
            cell.updateUI()
            return cell

        case upcomingBroadcastsCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: upcomingBroadcastsViewIdentifier, for: indexPath) as! UpcomingBroadcastsCollectionViewCell
            cell.updateUI()
            return cell

        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: upcomingBroadcastsViewIdentifier, for: indexPath) as! UpcomingBroadcastsCollectionViewCell
            cell.updateUI()
            return cell
        }
    }
    
}



