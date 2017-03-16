//
//  AddDishViewController.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/7/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit
import SCLAlertView

class AddDishViewController: UIViewController {
    
    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: #imageLiteral(resourceName: "icon-profile"), middleButtonImage: nil)
    
    var sendingViewController: UIViewController?
    var mediaPickerHelper: MediaPickerHelper!
    let store = DataStore.sharedInstance
    
    
    lazy var tableView = UITableView()
    lazy var addButton: FormSubmitButton = FormSubmitButton(frame: CGRect())

    let sections = ["Title", "Description", "Price", "Picture"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setViewProperties()
        setViewConstraints()
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func setViewProperties() {
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(dismissGesture)
        tableView.addGestureRecognizer(dismissGesture)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddImageTableViewCell.self, forCellReuseIdentifier: addImageTableViewCelIdentifier)
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: textFieldTableViewCellIdentifier)
        tableView.register(MoneyTextFieldTableViewCell.self, forCellReuseIdentifier: moneyTextFieldTableViewCellIdentifier)
        
        navBar.delegate = self
        navBar.middleButton.title = "Add a New Dish"
        
        addButton.setTitle("Add Dish", for: .normal)
        
        addButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }
    
    
    func setViewConstraints() {
        
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(navBar)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.82)
            make.leading.trailing.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalToSuperview().offset(-5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func dismissAction() {
        
        saveDish { (success) in
            
            if success {
                if let profileVC = self.sendingViewController as? ProfileViewController {
                    self.dismiss(animated: true) {
                        profileVC.profileView.tableView.reloadData()
                    }
                }
            }
        }
        
    }
    
    func saveDish(completion: @escaping (Bool) -> ()) {
        
        let titleCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextFieldTableViewCell
        let descriptionCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! TextFieldTableViewCell
        let priceCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! TextFieldTableViewCell
        let imageCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as! AddImageTableViewCell
        let title = titleCell.textField.text
        let description = descriptionCell.textField.text
        let price = priceCell.textField.text
        
        
        let image = imageCell.dishImageView.image
        
        if validateFields(title: title, description: description, price: price, image: image) {
            let priceInCents = Int(Float(price!)! * 100)
            let newDish = Dish(uid: store.currentUser.uid, name: title!, description: description!, mainImage: image!, mainImageURL: "", price: priceInCents, likedBy: [], averageRating: 0)
            
            newDish.save { (url) in
                print("The dish was successfully saved! Its image can be downloaded at \(url)")
                newDish.mainImageURL = url.absoluteString
                self.store.currentUser.dishes.append(newDish)
            }
            completion(true)
        }
        else { completion(false) }
        
        
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
    
    func validateFields(title: String?, description: String?, price: String?, image: UIImage?) -> Bool {
        print("validating now")
//        let alertController = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
//            alertController.dismiss(animated: true, completion: nil)
//        }
//        alertController.addAction(okAction)
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("OK") {
            print("ok button tapped")
        }

        let titleFieldCheck = title != "" && title != nil
        let descriptionFieldCheck = description != "" && description != nil
        
        let priceFieldCheck = price?.isValidCurrency()
        
        let imageCheck = image != #imageLiteral(resourceName: "add_dish")
        
        if !titleFieldCheck {
            alertView.showError("Error", subTitle: "Please enter a name for your dish")
            return false
        }
        
        if !descriptionFieldCheck {
            alertView.showError("Error", subTitle: "Please enter a description for your dish")
            return false
        }
        
        if !priceFieldCheck! {
            alertView.showError("Error", subTitle: "Please enter a valid price")
            return false
        }
        
        if !imageCheck {
            alertView.showError("Error", subTitle: "Please select an image for your dish")
            return false
        }
        return true
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
            
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: moneyTextFieldTableViewCellIdentifier, for: indexPath) as! MoneyTextFieldTableViewCell
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
        return formTableViewSectionHeaderHeight
    }
}

extension AddDishViewController: NavBarViewDelegate {
    func rightBarButtonTapped(_ sender: AnyObject) {}
    
    func middleBarButtonTapped(_ Sender: AnyObject) {}
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
