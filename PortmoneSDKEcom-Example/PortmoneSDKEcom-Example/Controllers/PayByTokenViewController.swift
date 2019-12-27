//
//  PayByTokenViewController.swift
//  PortmoneSDKEcom-Example
//
//  Created by Oleg Pankiv on 4/17/19.
//  Copyright © 2019 Devlight. All rights reserved.
//

import Foundation
import PortmoneSDKEcom

final class PayByTokenViewController: BaseViewController {
    
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
    @IBOutlet private weak var paymentType: UITextField!
    @IBOutlet private weak var merchantIdentifier: UITextField!
    @IBOutlet private weak var applePayOnlySwitch: UISwitch!
    @IBOutlet private weak var uidTextField: UITextField!
    
    private var presenter: PaymentPresenter?
    private let pickerView = UIPickerView()
    private let pickerSource = ["Default", "Mobile"]
    
    override var scrollView: UIScrollView? {
        return paymentScrollView
    }
    
    override var child: BaseViewController? {
        return self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billAmount.keyboardType = .decimalPad
        payeeId.keyboardType = .numberPad
        
        cardMaskLabel.text = UserDefaults.standard.string(forKey: Constants.cardMask) ?? "Card mask: "
        
        pickerView.delegate = self
        pickerView.dataSource = self
        paymentType.inputView = pickerView
        paymentScrollView.keyboardDismissMode = .interactive
        
        biometricFlag.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        applePayOnlySwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
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
        
        /// Only for testing purposes
        let type: PaymentType = paymentType.text == pickerSource.first ? .payment : .mobilePayment
        
        let paymentParams = PaymentParams(description: contractNumber.text ?? "",
                                          attribute1: attribute1.text ?? "",
                                          attribute2: attribute2.text ?? "",
                                          attribute3: attribute3.text ?? "",
                                          attribute4: attribute4.text ?? "",
                                          billNumber: billNumb,
                                          preauthFlag: preauthFlag.isOn,
                                          billCurrency: Currency(rawValue: billCurrency.text ?? "") ?? .uah,
                                          billAmount: Double(billAmount.text ?? "") ?? 0,
                                          payeeId: payeeId.text ?? "",
                                          type: type,
                                          merchantIdentifier: merchantIdentifier.text ?? "",
                                          paymentFlowType: applePayOnlySwitch.isOn ? .byApplePay : .byCard)
        
        presenter = PaymentPresenter(delegate: self,
                                     styleSource: style,
                                     language: Language(rawValue: language.text ?? "") ?? .ukrainian,
                                     biometricAuth: biometricFlag.isOn,
                                     customUid: uidTextField.text)
        
        let mask = UserDefaults.standard.string(forKey: Constants.cardMask)
        let token = UserDefaults.standard.string(forKey: Constants.cardToken)
        
        let tokenParams = TokenPaymentParams(cardNumberMasked: mask ?? "",
                                             tokenData: token ?? "")
        presenter?.presentPaymentByToken(on: self,
                                         payParams: paymentParams,
                                         tokenParams: tokenParams)
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        guard sender.isOn else { return }
        let anotherSwitch = (sender === applePayOnlySwitch) ? biometricFlag : applePayOnlySwitch
        anotherSwitch?.setOn(false, animated: true)
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

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension PayByTokenViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedType = pickerSource[row]
        paymentType.text = selectedType
    }
}
