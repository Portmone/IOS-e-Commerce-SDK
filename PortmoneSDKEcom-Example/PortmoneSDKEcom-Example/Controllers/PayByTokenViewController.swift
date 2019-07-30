//
//  PayByTokenViewController.swift
//  PortmoneSDKEcom-Example
//
//  Copyright © 2019 Portmone. All rights reserved.
//

import Foundation
import PortmoneSDKEcom

final class PayByTokenViewController: BaseViewController {
    
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
    @IBOutlet private weak var biometricFlag: UISwitch!
    @IBOutlet private weak var cardMaskLabel: UILabel!
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
        
        cardMaskLabel.text = UserDefaults.standard.string(forKey: cardMask) ?? "Card mask: "
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
        
        let paymentParams = PaymentParams(description: contractNumber.text ?? "",
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
                                     language: PaymentPresenter.Language(rawValue: language.text ?? "") ?? .ukrainian,
                                     biometricAuth: biometricFlag.isOn)
        let mask = UserDefaults.standard.string(forKey: cardMask)
        let token = UserDefaults.standard.string(forKey: cardToken)
        let tokenParams = TokenPaymentParams(cardNumberMasked: mask ?? "",
                                             tokenData: token ?? "")
        presenter?.presentPaymentByToken(on: self,
                                         payParams: paymentParams,
                                         tokenParams: tokenParams)
    }
}

// self <-- PaymentPresenter
extension PayByTokenViewController: PaymentPresenterDelegate {
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
}
