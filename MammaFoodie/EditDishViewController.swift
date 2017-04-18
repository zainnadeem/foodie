//
//  EditDishViewController.swift
//  MammaFoodie
//
//  Created by Haaris Muneer on 4/18/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import SDWebImage

class EditDishViewController: AddDishViewController {

    var dish: Dish!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.middleButton.title = "Edit '\(dish.name)\'"
        addButton.setTitle("Save", for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: addImageTableViewCelIdentifier, for: indexPath) as! AddImageTableViewCell
            let imageViewTapped = UITapGestureRecognizer(target: self, action: #selector(displayImagePicker))
            cell.dishImageView.addGestureRecognizer(imageViewTapped)
            cell.dishImageView.isUserInteractionEnabled = true
            cell.dishImageView.sd_setImage(with: URL(string: dish.mainImageURL))
            return cell
        }
            
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: moneyTextFieldTableViewCellIdentifier, for: indexPath) as! MoneyTextFieldTableViewCell
            let priceString = String(dish.price).convertPriceInCentsToDollars()
            cell.textField.text = priceString.substring(from: priceString.index(priceString.startIndex, offsetBy: 1))
            return cell
        }
            
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = dish.description
            return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = dish.name
            return cell
        }
        
    }
    
    override func addButtonTapped() {
        //remove old dish before adding this "new" edited one
    }

}
