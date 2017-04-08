//
//  DeliveryInfoView.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 3/16/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SnapKit

class DeliveryInfoView: UIView {
    
    enum DeliveryOption {
        case pickUp, uber, postmates
    }
    
    let viewHeight:CGFloat = 30
    
    lazy var deliveryLabel = UILabel(text: "Delivery Options")
    
    lazy var pickUpLabel = UILabel(text: "Pick Up")
    lazy var uberLabel = UILabel(text: "Uber")
    lazy var postmatesLabel = UILabel(text: "Postmates")
    var labelsStackView: UIStackView!
    
    lazy var pickUpButton: SegmentedControlButton = SegmentedControlButton()
    lazy var uberButton: SegmentedControlButton = SegmentedControlButton()
    lazy var postmatesButton: SegmentedControlButton = SegmentedControlButton()
    var lastTappedButton: SegmentedControlButton!
    var buttonsStackView: UIStackView!
    
    var selectedDeliveryOption: DeliveryOption = .pickUp
    
    weak var delegate: DeliveryViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.flatWhite
        setViewProprties()
        setViewConstraints()
    }
    
    func setViewProprties() {
        
        self.addTopBorderWithColor(color: .black, width: 2)
        self.addBottomBorderWithColor(color: .black, width: 2)
        
        pickUpLabel.font = UIFont.mammaFoodieFontBold(16)
        pickUpLabel.textAlignment = .center
        uberLabel.font = UIFont.mammaFoodieFontBold(16)
        uberLabel.textAlignment = .center
        postmatesLabel.font = UIFont.mammaFoodieFontBold(16)
        postmatesLabel.textAlignment = .center
        
        pickUpButton.isSelected = true
        pickUpButton.setTitle("✔️", for: .normal)
        lastTappedButton = pickUpButton
    }
    
    func setViewConstraints() {
        labelsStackView = UIStackView(arrangedSubviews: [pickUpLabel, uberLabel, postmatesLabel])
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .equalCentering
        labelsStackView.alignment = .center
        labelsStackView.layoutMargins = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        labelsStackView.isLayoutMarginsRelativeArrangement = true
        self.addSubview(labelsStackView)
        labelsStackView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview()
            make.top.left.equalToSuperview()
        }
        
        buttonsStackView = UIStackView(arrangedSubviews: [pickUpButton, uberButton, postmatesButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .equalCentering
        buttonsStackView.alignment = .center
        buttonsStackView.layoutMargins = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        buttonsStackView.isLayoutMarginsRelativeArrangement = true
        self.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview()
            make.top.right.equalToSuperview()
        }
        
        for view in buttonsStackView.arrangedSubviews {
            view.snp.makeConstraints({ (make) in
                make.height.width.equalTo(30)
            })
            if let button = view as? SegmentedControlButton {
                button.addTarget(self, action: #selector(segmentedControlButtonTapped(sender:)), for: .touchUpInside)
                button.layer.cornerRadius = viewHeight/2.0
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.black.cgColor
            }
        }
        
        for view in labelsStackView.arrangedSubviews {
            view.snp.makeConstraints({ (make) in
                make.height.equalTo(30)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension DeliveryInfoView {
    func segmentedControlButtonTapped(sender: SegmentedControlButton) {
        lastTappedButton.isSelected = false
        lastTappedButton.setTitle("", for: .normal)
        sender.isSelected = true
        lastTappedButton = sender
        
        sender.setTitle("✔️", for: .normal)
        switch sender {
        case pickUpButton:      selectedDeliveryOption = .pickUp
        case uberButton:        selectedDeliveryOption = .uber
        case postmatesButton:   selectedDeliveryOption = .postmates
        default: print("should never reach here - segmentedControlButtonTapped")
        }
        self.delegate?.showAlert(for: sender)
    }
    
    
}

protocol DeliveryViewDelegate: class {
    func showAlert(for button: UIButton)
}








