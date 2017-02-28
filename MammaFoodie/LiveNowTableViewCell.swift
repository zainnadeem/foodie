//
//  LiveNowTableViewCell.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class LiveNowTableViewCell: UITableViewCell{
    
    let liveNowCellIdentifier = "liveNowCollectionViewCell"
    
    let liveNowCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    
    func layOutCollectionView(){
        
        liveNowCollectionView.delegate = self
        liveNowCollectionView.dataSource = self
        
       liveNowCollectionView.register(LiveNowCollectionViewCell.self, forCellWithReuseIdentifier: liveNowCellIdentifier)
        
        let liveNowLayout = UICollectionViewFlowLayout()
        liveNowLayout.scrollDirection = .horizontal
        
        liveNowCollectionView.isPagingEnabled = true
        liveNowCollectionView.collectionViewLayout = liveNowLayout
        
        liveNowCollectionView.backgroundColor = UIColor.white
        
        setViewConstraints()
        
    }
    
    func setViewConstraints() {
        
        self.contentView.addSubview(liveNowCollectionView)
        liveNowCollectionView.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
}

extension LiveNowTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveNowCellIdentifier, for: indexPath) as! LiveNowCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = collectionCellCornerRadius
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.width / 2, height:self.contentView.frame.height)
    }
    
}


extension LiveNowTableViewCell: UICollectionViewDelegate { }

extension LiveNowTableViewCell: UICollectionViewDelegateFlowLayout { }
