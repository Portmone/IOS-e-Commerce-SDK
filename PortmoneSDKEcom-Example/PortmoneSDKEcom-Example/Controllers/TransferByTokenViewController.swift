//
//  TransferByTokenViewController.swift
//  PortmoneSDKEcom-Example
//
//  Created by serhiy tanchenetc on 8/22/19.
//  Copyright © 2019 Devlight. All rights reserved.
//

import UIKit
import PortmoneSDKEcom

final class TransferByTokenViewController: BaseViewController {
    
    private var presenter: PaymentPresenter?
    
    @IBOutlet private weak var transferScrollView: UIScrollView!
    @IBOutlet private weak var attribute2: UITextField!
    @IBOutlet private weak var attribute3: UITextField!
    @IBOutlet private weak var attribute4: UITextField!
    @IBOutlet private weak var billNumber: UITextField!
    @IBOutlet private weak var billAmount: UITextField!
    @IBOutlet private weak var payeeId: UITextField!
    @IBOutlet private weak var language: UITextField!
    @IBOutlet private weak var cardMaskLabel: UILabel!
    @IBOutlet private weak var transferButton: UIButton!
    
    override var scrollView: UIScrollView? {
        return transferScrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billAmount.keyboardType = .decimalPad
        payeeId.keyboardType = .numberPad
        
        cardMaskLabel.text = UserDefaults.standard.string(forKey: Constants.cardMask) ?? "Card mask: "
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        transferButton.layer.borderColor = transferButton.tintColor.cgColor
        transferButton.layer.borderWidth = 1.0
    }
    
    @IBAction func transferButtonClicked(_ sender: Any) {
        
        var billNumb = ""
        if billNumber.text?.isEmpty ?? true {
            billNumb = "SD\(Int(Date().timeIntervalSince1970))"
        } else {
            billNumb = billNumber.text ?? ""
        }
        
        let transferParams = TransferParams(attribute2: attribute2.text ?? "",
                                            attribute3: attribute3.text ?? "",
                                            attribute4: attribute4.text ?? "",
                                            billNumber: billNumb,
                                            billAmount: Double(billAmount.text ?? "") ?? 0,
                                            payeeId: payeeId.text ?? "")
        
        presenter = PaymentPresenter(delegate: self,
                                     styleSource: style,
                                     language: Language(rawValue: language.text ?? "") ?? .ukrainian)
        
        let mask = UserDefaults.standard.string(forKey: Constants.cardMask)
        let token = UserDefaults.standard.string(forKey: Constants.cardToken)
        
        let tokenParams = TokenPaymentParams(cardNumberMasked: mask ?? "",
                                             tokenData: token ?? "")
        
        presenter?.presentTransferByToken(on: self,
                                          transferParams: transferParams,
                                          tokenParams: tokenParams)
    }
}

// self <-- PaymentPresenter
extension TransferByTokenViewController: PaymentPresenterDelegate {
    func didFinishPayment(bill: Bill?, error: Error?) {
        if error != nil {
            presentAlert(title: "Error", message: error?.localizedDescription)
        }
        
        if bill != nil {
            let mask = bill?.cardMask ?? ""
            let token = bill?.token ?? ""
            self.presentAlert(title: "Payment Success",
                              message: "Card mask: \n\(mask), \nToken: \n\(token)")
            // Save bill token and card mask for token payment
        }
    }
    
    func didCancelPayment() {
        
    }
}
