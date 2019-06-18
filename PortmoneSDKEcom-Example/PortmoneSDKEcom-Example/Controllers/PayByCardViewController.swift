//
//  PayByCardViewController.swift
//  PortmoneSDKEcom-Example
//
//  Created on 3/18/19.
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

final class PayByCardViewController: BaseViewController {

    private let cardMask = "kCardMask"
    private let cardToken = "kCardToken"
    
    @IBOutlet private weak var paymentScrollView: UIScrollView!
    
    @IBOutlet private weak var contractNumber: UITextField!
    @IBOutlet private weak var attribute1: UITextField!
    @IBOutlet private weak var attribute2: UITextField!
    @IBOutlet private weak var attribute3: UITextField!
    @IBOutlet private weak var attribute4: UITextField!
    @IBOutlet private weak var billNumber: UITextField!
    @IBOutlet private weak var billCurrency: UITextField!
    @IBOutlet private weak var billAmount: UITextField!
    @IBOutlet private weak var payeeId: UITextField!
    @IBOutlet private weak var language: UITextField!
    @IBOutlet private weak var preauthFlag: UISwitch!
    @IBOutlet private weak var payButton: UIButton!
    
    private var presenter: PaymentPresenter?

    override var scrollView: UIScrollView? {
        return paymentScrollView
    }
    
    override var child: BaseViewController? {
        return self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billAmount.keyboardType = .numberPad
        payeeId.keyboardType = .numberPad
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        payButton.layer.borderColor = payButton.tintColor.cgColor
        payButton.layer.borderWidth = 1.0
    }
    
    @IBAction private func payButtonClicked(_ sender: UIButton) {
        //9562 3D
        //3048 Payeed
        var billNumb = ""
        if billNumber.text?.isEmpty ?? true {
            billNumb = "SD\(Int(Date().timeIntervalSince1970))"
        } else {
            billNumb = billNumber.text ?? ""
        }
        
        let initParams = PaymentParams(description: contractNumber.text ?? "",
                                       attribute1: attribute1.text ?? "",
                                       attribute2: attribute2.text ?? "",
                                       attribute3: attribute3.text ?? "",
                                       attribute4: attribute4.text ?? "",
                                       billNumber: billNumb,
                                       preauthFlag: preauthFlag.isOn,
                                       billCurrency: PaymentParams.Currency(rawValue: billCurrency.text ?? "") ?? .uah,
                                       billAmount: Double(billAmount.text ?? "") ?? 0,
                                       payeeId: payeeId.text ?? "")
        presenter = PaymentPresenter(delegate: self,
                                     styleSource: style,
                                     language: PaymentPresenter.Language(rawValue: language.text ?? "") ?? .ukrainian)
        presenter?.presentPaymentByCard(on: self, params: initParams)
    }
}

// self <-- PaymentPresenter
extension PayByCardViewController: PaymentPresenterDelegate {
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
                self.presentAlert(title: "Payment Success",
                                  message: "Card mask: \n\(mask), \nToken: \n\(token)")
            }
        }
    }
}
