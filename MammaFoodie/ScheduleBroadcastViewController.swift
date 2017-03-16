//
//  ScheduleBroadcastViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/7/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class ScheduleBroadcastViewController: UIViewController {
    
    lazy var navBar:                NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: nil, middleButtonImage: nil)
    lazy var tableView:             UITableView = UITableView()

    lazy var titleLabel:             UILabel            = UILabel()
    lazy var descriptionLabel:       UILabel            = UILabel()
    lazy var timeLabel:              UILabel            = UILabel()
    lazy var dishLabel:              UILabel            = UILabel()
    lazy var coverImageView:         UIImageView        = UIImageView()
    
    lazy var saveButton:             UIButton    = UIButton()
    
    var dish: Dish?
    var mediaPickerHelper: MediaPickerHelper!
    
    
    let store = DataStore.sharedInstance
    
    enum SectionType {
        case ScheduleBroadcast
    }
    
    enum Item {
        case title
        case description
        case time
        case dish
        case image
    }
    
    struct Section {
        var type: SectionType
        var items: [Item]
    }
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        navBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navBar.leftButton.title = "back"
        self.navBar.middleButton.title = "Schedule a Broadcast"
        
        self.tableView.register(BroadcastImageTableViewCell.self, forCellReuseIdentifier: broadcastImageTableViewCellIdentifier)
        
        sections = [
            Section(type: .ScheduleBroadcast, items: [.title, .description, .time, .dish, .image]),
        ]
        
        self.setViewConstraints()
        self.setViewProperties()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    private func setViewConstraints(){
        
        self.view.addSubview(navBar)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.69)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.view.addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.1)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            
        }
        
    }
    private func setViewProperties(){
        saveButton.setTitle("save", for: .normal)
        saveButton.titleLabel?.font = UIFont.mammaFoodieFontBold(16)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .black
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.borderWidth = 1
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    
    func saveButtonTapped(){
       
        //validate broadcast fields
        let user = self.store.currentUser
        let broadcast = Broadcast(title: self.titleLabel.text!, scheduledTime: self.timeLabel.text!, userUID: self.store.currentUser.uid)
        broadcast.offeredDish = self.dish
        
        user.broadcasts.append(broadcast)
        //save to Broadcast to firebase
        store.currentUser.updateUserInfo()
        _ = navigationController?.popViewController(animated: true)
       
        
    }
}

extension ScheduleBroadcastViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: defaultReuseIdentifier)
            
            switch sections[indexPath.section].items[indexPath.row] {
                
            case .title:
                cell.textLabel?.text = "Title"
                cell.detailTextLabel?.text = self.titleLabel.text
                cell.accessoryType = .disclosureIndicator
                
            case .description:
                cell.textLabel?.text = "Description"
                cell.detailTextLabel?.text = self.descriptionLabel.text
                cell.accessoryType = .disclosureIndicator
                
            case .time:
                cell.textLabel?.text = "Time"
                cell.detailTextLabel?.text = self.timeLabel.text
                
            case .dish:
                cell.textLabel?.text = "Dish"
                cell.detailTextLabel?.text = self.dishLabel.text
                
            case .image:
                let imageCell =  tableView.dequeueReusableCell(withIdentifier: broadcastImageTableViewCellIdentifier, for: indexPath) as! BroadcastImageTableViewCell
                imageCell.broadcastImageView.image = coverImageView.image
                return imageCell
                
            default:
                print("should not reach this point (cellForRow)")
            }
            
            cell.textLabel?.font = UIFont.mammaFoodieFontBold(12)
            cell.textLabel?.textColor = UIColor.darkGray
            cell.detailTextLabel?.font = UIFont.mammaFoodieFont(12)
            cell.detailTextLabel?.textColor = UIColor.darkGray
            
            return cell

    }
}


extension ScheduleBroadcastViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch sections[indexPath.section].items[indexPath.row] {
            
        case .title:
            print("Show title View")
            let destinationVC = BroadcastTitleViewController()
            self.navigationController?.pushViewController(destinationVC, animated: true)
            destinationVC.textField.text = titleLabel.text
            destinationVC.presentingVC = self
            
            
        case .description:
            print("Show description View")
            let destinationVC = BroadcastDescriptionViewController()
            self.navigationController?.pushViewController(destinationVC, animated: true)
            destinationVC.textView.text = descriptionLabel.text
            destinationVC.presentingVC = self
            
            
        case .time:
            print("Show date Picker View")
            let destinationVC = DatePickerViewController()
            self.navigationController?.pushViewController(destinationVC, animated: true)
            if timeLabel.text != "" { print( "assign date ")}
            destinationVC.presentingVC = self
            
            
        case .dish:
            print("Show table view of dishes to select + ability to add a dish")
            let destinationVC = SelectDishViewController()
            self.navigationController?.pushViewController(destinationVC, animated: true)
            destinationVC.presentingVC = self
            
            
        case .image:
            print("Show ability to pick cover Image")
            
            mediaPickerHelper = MediaPickerHelper(viewController: self) { (image) in
                print("in the MediaPickerHelper")
                if let image = image as? UIImage {
                    OperationQueue.main.addOperation({
                        self.coverImageView.image = image
                        self.tableView.reloadData()
                    })
                    
                }
            }

            
            
        default:
            print("should not reach this point (cellForRow)")
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.width / 6 
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.mammaFoodieFont(12)
        header.textLabel?.textColor = UIColor.red
    }
    
}

extension ScheduleBroadcastViewController : NavBarViewDelegate {
    
    func rightBarButtonTapped(_ sender: AnyObject) {
        if let pageVC = self.parent as? UserPageViewController {
            pageVC.navigateToProfileViewController(.forward)
        }
        
    }
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    func middleBarButtonTapped(_ Sender: AnyObject) {
        let index = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: index, at: .top, animated: true)
    }
    
}


