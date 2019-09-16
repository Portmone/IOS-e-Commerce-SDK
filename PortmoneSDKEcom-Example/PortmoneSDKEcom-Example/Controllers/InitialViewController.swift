//
//  InitialViewController.swift
//  PortmoneSDKEcom-Example
//
//  Created by Oleg Pankiv on 4/24/19.
//  Copyright © 2019 Devlight. All rights reserved.
//

import UIKit

final class InitialViewController: UIViewController, AlertPresentable {
    
    @IBOutlet private weak var payByTokenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func payByTokenButtonClicked(_ sender: UIButton) {
        let mask = UserDefaults.standard.string(forKey: Constants.cardMask)
        let token = UserDefaults.standard.string(forKey: Constants.cardToken)
        
        if mask != nil && token != nil {
            let segueIdentifier = sender == payByTokenButton ? "token" : "transferByToken"
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        } else {
            presentAlert(title: "Error", message: "There is no card saved.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction private func removeSavedCardButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: Constants.cardMask)
        UserDefaults.standard.removeObject(forKey: Constants.cardToken)
        
        presentAlert(title: "Success", message: "Card removed.")
    }
}
