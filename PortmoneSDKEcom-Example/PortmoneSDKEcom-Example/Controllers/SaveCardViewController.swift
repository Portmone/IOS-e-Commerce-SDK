//
//  SaveCardViewController.swift
//  PortmoneSDKEcom-Example
//
//  Created on 4/15/19.
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

import Foundation
import PortmoneSDKEcom

final class SaveCardViewController: BaseViewController {
    
    private let cardMask = "kCardMask"
    private let cardToken = "kCardToken"

    @IBOutlet private weak var saveScrollView: UIScrollView!
    
    @IBOutlet private weak var contractNumber: UITextField!
    @IBOutlet private weak var accountId: UITextField!
    @IBOutlet private weak var billNumber: UITextField!
    @IBOutlet private weak var payeeId: UITextField!
    @IBOutlet private weak var language: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    
    private var presenter: PaymentPresenter?
    
    override var scrollView: UIScrollView? {
        return saveScrollView
    }
    
    override var child: BaseViewController? {
        return self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        payeeId.keyboardType = .numberPad
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        saveButton.layer.borderColor = saveButton.tintColor.cgColor
        saveButton.layer.borderWidth = 1.0
    }
    
    @IBAction private func saveButtonClicked(_ sender: UIButton) {
        //9562 3D
        //3048 Payeed
        var billNumb = ""
        if billNumber.text?.isEmpty ?? true {
            billNumb = "SD\(Int(Date().timeIntervalSince1970))"
        } else {
            billNumb = billNumber.text ?? ""
        }
        
        let initParams = PreauthParams(payeeId: payeeId.text ?? "",
                                       accountId: accountId.text ?? "",
                                       description: contractNumber.text ?? "",
                                       billNumber: billNumb)
        presenter = PaymentPresenter(delegate: self,
                                     styleSource: style,
                                     language: PaymentPresenter.Language(rawValue: language.text ?? "") ?? .ukrainian)
        presenter?.presentPreauthCard(on: self, params: initParams)
    }
}

// self <-- PaymentPresenter
extension SaveCardViewController: PaymentPresenterDelegate {
    func didFinishPayment(bill: Bill?, error: Error?) {
        // Save preauth card
        UserDefaults.standard.set(bill?.cardMask, forKey: cardMask)
        UserDefaults.standard.set(bill?.token, forKey: cardToken)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if error != nil {
                self.presentAlert(title: "Error", message: error?.localizedDescription)
            }
            
            if bill != nil {
                let mask = bill?.cardMask ?? ""
                let token = bill?.token ?? ""
                self.presentAlert(title: "Save Success",
                                  message: "Card mask: \n\(mask), \nToken: \n\(token)")
            }
        }
    }
}
