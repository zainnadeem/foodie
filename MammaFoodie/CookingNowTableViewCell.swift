//
//  CookingNowTableViewCell.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class CookingNowTableViewCell:  UITableViewCell{
    
    let cookingNowCellIdentifier = "cookingNowCollectionViewCell"
    
    let cookingNowCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    
    func layOutCollectionView(){
        
        cookingNowCollectionView.delegate = self
        cookingNowCollectionView.dataSource = self
        
        cookingNowCollectionView.register(CookingNowCollectionViewCell.self, forCellWithReuseIdentifier: cookingNowCellIdentifier)
        
        let cookingNowLayout = UICollectionViewFlowLayout()
        cookingNowLayout.scrollDirection = .horizontal
        
        cookingNowCollectionView.isPagingEnabled = true
        cookingNowCollectionView.collectionViewLayout = cookingNowLayout
        
        cookingNowCollectionView.backgroundColor = UIColor.white
        
        setViewConstraints()
        
    }
    
    func setViewConstraints() {
        
        self.contentView.addSubview(cookingNowCollectionView)
        cookingNowCollectionView.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
}

extension CookingNowTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cookingNowCellIdentifier, for: indexPath) as! CookingNowCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = collectionCellCornerRadius
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.width / 3, height:self.contentView.frame.height)
    }
    
}


extension CookingNowTableViewCell: UICollectionViewDelegate { }

extension CookingNowTableViewCell: UICollectionViewDelegateFlowLayout { }
