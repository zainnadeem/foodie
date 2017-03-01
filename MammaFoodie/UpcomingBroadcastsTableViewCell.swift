//
//  UpcomingBroadcastsTableViewCell.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class UpcomingBroadcastsTableViewCell: UITableViewCell{
    
    let upcomingBroadcastsCollectionViewCellIdentifier = "upcomingBroadcastsCollectionViewCell"
    
    let upcomingBroadcastsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    
    var usersWithUpcomingBroadcasts: [User] = [User]()
    
    let store = DataStore.sharedInstance
    
    func layOutCollectionView(){
        
        upcomingBroadcastsCollectionView.delegate = self
        upcomingBroadcastsCollectionView.dataSource = self
        
        upcomingBroadcastsCollectionView.register(UpcomingBroadcastsCollectionViewCell.self, forCellWithReuseIdentifier: upcomingBroadcastsCollectionViewCellIdentifier)
        
        let upcomingBroadcastsLayout = UICollectionViewFlowLayout()
        upcomingBroadcastsLayout.scrollDirection = .horizontal
        
        upcomingBroadcastsCollectionView.isPagingEnabled = true
        upcomingBroadcastsCollectionView.collectionViewLayout = upcomingBroadcastsLayout
        
        upcomingBroadcastsCollectionView.backgroundColor = UIColor.white
        
        setViewConstraints()
        
    }
    
    func setViewConstraints() {
        
        self.contentView.addSubview(upcomingBroadcastsCollectionView)
        upcomingBroadcastsCollectionView.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    func fetchUsers(){
        //Fetch Users from firebase
        usersWithUpcomingBroadcasts = store.createDummyUsers()
        
    }
    
}

extension UpcomingBroadcastsTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersWithUpcomingBroadcasts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: upcomingBroadcastsCollectionViewCellIdentifier, for: indexPath) as! UpcomingBroadcastsCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = collectionCellCornerRadius
        cell.user = usersWithUpcomingBroadcasts[indexPath.row]
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.width / 4, height:self.contentView.frame.height)
    }
    
}


extension UpcomingBroadcastsTableViewCell: UICollectionViewDelegate { }

extension UpcomingBroadcastsTableViewCell: UICollectionViewDelegateFlowLayout { }
