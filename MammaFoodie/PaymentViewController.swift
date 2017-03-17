//
//  PaymentViewController.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 3/16/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import Stripe

class PaymentViewController: UIViewController {
    
    var paymentContext: STPPaymentContext!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension PaymentViewController : STPPaymentContextDelegate{
    
    //This method is called, as you might expect, when the payment context's contents change, e.g. when the user selects a new payment method or enters shipping info. This is a good place to update your UI:
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
//        self.activityIndicator.animating = paymentContext.loading
//        self.paymentButton.enabled = paymentContext.selectedPaymentMethod != nil
//        self.paymentLabel.text = paymentContext.selectedPaymentMethod?.label
//        self.paymentIcon.image = paymentContext.selectedPaymentMethod?.image
    }
    
    //This method is called when the user has successfully selected a payment method and completed their purchase. You should pass the contents of the paymentResult object to your backend, which should then finish charging your user using the create charge API. When this API request is finished, call the provided completion block with nil as its only argument if the call succeeded, or, if an error occurred, with that error as the argument instead.
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didCreatePaymentResult paymentResult: STPPaymentResult,
                        completion: @escaping STPErrorBlock) {
        
//        myAPIClient.createCharge(paymentResult.source.stripeID, completion: { (error: Error?) in
//            if let error = error {
//                completion(error)
//            } else {
//                completion(nil)
//            }
//        })
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didFinishWith status: STPPaymentStatus,
                        error: Error?) {
        
//        switch status {
//        case .error:
//            self.showError(error)
//        case .success:
//            self.showReceipt()
//        case .userCancellation:
//            return // Do nothing
//        }
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didFailToLoadWithError error: Error) {
     //   self.navigationController?.popViewController(animated: true)
        // Show the error to your user, etc.
    }
    
    
    
    
}
