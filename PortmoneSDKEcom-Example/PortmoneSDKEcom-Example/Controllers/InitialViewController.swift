//
//  InitialViewController.swift
//  PortmoneSDKEcom-Example
//
//  Created on 4/24/19.
//  Copyright © 2019 Portmone. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.

//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.

import UIKit

final class InitialViewController: UIViewController, AlertPresentable {
    
    private let cardMask = "kCardMask"
    private let cardToken = "kCardToken"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func payByTokenButtonClicked(_ sender: UIButton) {
        let mask = UserDefaults.standard.string(forKey: cardMask)
        let token = UserDefaults.standard.string(forKey: cardToken)
        
        if mask != nil && token != nil {
            performSegue(withIdentifier: "token", sender: nil)
        } else {
            presentAlert(title: "Error", message: "There is no card saved.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction private func removeSavedCardButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: cardMask)
        UserDefaults.standard.removeObject(forKey: cardToken)
        
        presentAlert(title: "Success", message: "Card removed.")
    }
}
