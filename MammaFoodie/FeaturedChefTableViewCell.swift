//
//  FeaturedChefTableViewCell.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class FeaturedChefTableViewCell: UITableViewCell{
    
    let featuredChefCollectionViewIdentifier = "featuredChefCollectionViewCell"
   
    let featuredChefCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    
    var featuredChefs: [User] = [User]()
    
    let store = DataStore.sharedInstance

    
    func layOutCollectionView(){
        
        featuredChefCollectionView.delegate = self
        featuredChefCollectionView.dataSource = self
        
        featuredChefCollectionView.register(FeaturedChefCollectionViewCell.self, forCellWithReuseIdentifier: featuredChefCollectionViewIdentifier)
        
        let featuredChefLayout = UICollectionViewFlowLayout()
        featuredChefLayout.scrollDirection = .horizontal
       
        featuredChefCollectionView.isPagingEnabled = true
        featuredChefCollectionView.collectionViewLayout = featuredChefLayout
        
        featuredChefCollectionView.backgroundColor = UIColor.white
        
        setViewConstraints()
        
    }
    
        func setViewConstraints() {
            
            self.contentView.addSubview(featuredChefCollectionView)
            featuredChefCollectionView.snp.makeConstraints { (make) in
                make.height.equalToSuperview()
                make.width.equalToSuperview()
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
        }
    
    
    func fetchUsers(){
        //Fetch Users from firebase
        featuredChefs = store.createDummyUsers()
        
    }
    
}

extension FeaturedChefTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredChefs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featuredChefCollectionViewIdentifier, for: indexPath) as! FeaturedChefCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = collectionCellCornerRadius
        cell.user = featuredChefs[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.width, height:self.contentView.frame.height)
    }
    
}


extension FeaturedChefTableViewCell: UICollectionViewDelegate { }

extension FeaturedChefTableViewCell: UICollectionViewDelegateFlowLayout { }


