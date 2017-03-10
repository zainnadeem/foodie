//
//  AddDishViewController.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/7/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit

class AddDishViewController: UIViewController {
    
    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "icon-profile"), middleButtonImage: nil)
    
    var sendingViewController: UIViewController?
    var mediaPickerHelper: MediaPickerHelper!
    let store = DataStore.sharedInstance
    
    lazy var tableView = UITableView()
    lazy var addButton = UIButton(type: .system)

    let sections = ["Title", "Description", "Price", "Picture"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddImageTableViewCell.self, forCellReuseIdentifier: addImageTableViewCelIdentifier)
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: textFieldTableViewCellIdentifier)
        
        navBar.delegate = self
        navBar.middleButton.title = "Add a New Dish"
        
        addButton.setTitle("Add Dish", for: .normal)
        addButton.titleLabel?.font = UIFont.mammaFoodieFontBold(16)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .black
        addButton.layer.cornerRadius = 10
        addButton.layer.borderColor = UIColor.white.cgColor
        addButton.layer.borderWidth = 1
        addButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(navBar)
        
        setConstraints()
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.82)
            make.leading.trailing.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func dismissAction() {
        let newDish = Dish(uid: store.currentUser.uid, name: "Pizza", description: "delicious", mainImage: #imageLiteral(resourceName: "profile_placeholder"), price: 10, likedBy: [], averageRating: 0)
        store.currentUser.dishes.append(newDish)
        newDish.save { (url) in
            print("The dish was successfully saved with download URL \(url)")
        }
        if let profileVC = sendingViewController as? ProfileViewController {
            self.dismiss(animated: true) {
                profileVC.profileView.tableView.reloadData()
            }
        }
    }
    
    func displayImagePicker() {
        mediaPickerHelper = MediaPickerHelper(viewController: self) { (image) in
            print("in the MediaPickerHelper")
            if let image = image as? UIImage {
                OperationQueue.main.addOperation({
                    let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as! AddImageTableViewCell
                    cell.dishImageView.image = image
                })
                
            }
        }
    }


}

extension AddDishViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: addImageTableViewCelIdentifier, for: indexPath) as! AddImageTableViewCell
            let imageViewTapped = UITapGestureRecognizer(target: self, action: #selector(displayImagePicker))
            cell.dishImageView.addGestureRecognizer(imageViewTapped)
            cell.dishImageView.isUserInteractionEnabled = true
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 3: return 200
        default: return 44
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = FormTableViewHeaderView(reuseIdentifier: formTableViewHeaderViewIdentifier)
        view.label.text = sections[section]
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
}

extension AddDishViewController: NavBarViewDelegate {
    func rightBarButtonTapped(_ sender: AnyObject) {
        
    }
    
    func middleBarButtonTapped(_ Sender: AnyObject) {
        
    }
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
