//
//  DatePickerViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/12/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController, UIPickerViewDelegate {
 
    lazy var datePicker: UIDatePicker = UIDatePicker()
    lazy var navBar: NavBarView = NavBarView(withView: self.view, rightButtonImage: nil, leftButtonImage: nil, middleButtonImage: nil)
    
    var presentingVC:    ScheduleBroadcastViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        navBar.delegate = self
        navBar.middleButton.title = "Date"
        navBar.leftButton.title = "back"
        self.setConstraints()
        self.setUpDatePicker()

        // Do any additional setup after loading the view.
    }
    
    fileprivate func setConstraints() {

        self.view.addSubview(navBar)
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.leading.trailing.equalToSuperview()
        }

    }
    
    func setUpDatePicker(){
        
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.layer.cornerRadius = 5.0
        datePicker.layer.shadowOpacity = 0.5
        
        datePicker.addTarget(self, action: #selector(self.didChangeDate), for: .valueChanged)
        
    }
    
    func didChangeDate(sender: UIDatePicker) {
        
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "MM/dd/yyyy hh:mm"
        
        // get the date string applied date format
        let mySelectedDate = myDateFormatter.string(from: sender.date)
        print(mySelectedDate)
    }


}

extension DatePickerViewController: NavBarViewDelegate {
    func rightBarButtonTapped(_ sender: AnyObject) {}
    
    func middleBarButtonTapped(_ Sender: AnyObject) {
        
    }
    
    func leftBarButtonTapped(_ sender: AnyObject) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd hh:mm"
        dateFormatter.locale = Locale(identifier: "en_US")
        presentingVC?.timeLabel.text = dateFormatter.string(from: datePicker.date)
        _ = navigationController?.popToViewController(self.presentingVC!, animated: true)
       
    }
}
