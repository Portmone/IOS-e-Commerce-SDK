//
//  StartViewController.swift
//  PortmoneSDKEcom-Example
//
//  Created by Oleg Pankiv on 3/18/19.
//  Copyright © 2019 Devlight. All rights reserved.
//

// swiftlint:disable identifier_name

import Foundation
import PortmoneSDKEcom

final class StartViewController: BaseViewController {

    let cHeadersFont = UIFont.systemFont(ofSize: 20)
    let cHeadersColor = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
    let cHeadersBackgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    
    let cPlaceholdersFont = UIFont.systemFont(ofSize: 18)
    let cPlaceholdersColor = #colorLiteral(red: 0.7097406983, green: 0.7098443508, blue: 0.7097179294, alpha: 1)
    
    let cTextsFont = UIFont.systemFont(ofSize: 20)
    let cTextsColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    let cErrorsFont = UIFont.systemFont(ofSize: 12)
    let cErrorsColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    
    let cBackgroundColor = #colorLiteral(red: 0.9607002139, green: 0.9608381391, blue: 0.9606701732, alpha: 1)
    
    let cResultHeadersFont = UIFont.boldSystemFont(ofSize: 21)
    let cResultHeadersColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    let cResultMessageFont = UIFont.systemFont(ofSize: 18)
    let cResultMessageColor = #colorLiteral(red: 0.3129236996, green: 0.3582820296, blue: 0.3703345954, alpha: 1)
    
    let cButtonTitleFont = UIFont.systemFont(ofSize: 18)
    let cButtonColor = #colorLiteral(red: 0.5019607843, green: 0.8509803922, blue: 0.7882352941, alpha: 1)
    
    @IBOutlet private weak var paymentScrollView: UIScrollView!
    
    @IBOutlet private weak var contractNumber: UITextField!
    @IBOutlet private weak var attribute1: UITextField!
    @IBOutlet private weak var attribute2: UITextField!
    @IBOutlet private weak var attribute3: UITextField!
    @IBOutlet private weak var attribute4: UITextField!
    @IBOutlet private weak var billNumber: UITextField!
    @IBOutlet private weak var billCurrency: UITextField!
    @IBOutlet private weak var billAmount: UITextField!
    @IBOutlet private weak var billDetails: UITextField!
    @IBOutlet private weak var payeeId: UITextField!
    @IBOutlet private weak var language: UITextField!
    @IBOutlet private weak var preauthFlag: UISwitch!
    @IBOutlet private weak var payButton: UIButton!
    
    private var presenter: PaymentPresenter?
    private var model = StyleModel()

    override var scrollView: UIScrollView? {
        return paymentScrollView
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
        let initParams = PaymentParams(contractNumber: contractNumber.text ?? "",
                                       attribute1: attribute1.text ?? "",
                                       attribute2: attribute2.text ?? "",
                                       attribute3: attribute3.text ?? "",
                                       attribute4: attribute4.text ?? "",
                                       billNumber: billNumber.text ?? "",
                                       preauthFlag: preauthFlag.isOn,
                                       billCurrency: PaymentParams.Currency(rawValue: billCurrency.text ?? "") ?? .uah,
                                       billAmount: Double(billAmount.text ?? "") ?? 0,
                                       details: billDetails.text ?? "",
                                       payeeId: payeeId.text ?? "")
        presenter = PaymentPresenter(paymentParams: initParams,
                                     delegate: self,
                                     styleSource: self,
                                     language: PaymentPresenter.Language(rawValue: language.text ?? "") ?? .ukrainian)
        presenter?.present(on: self)
    }
    
    @IBAction private func styleButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "style", sender: nil)
    }
    
    private func prepareFont(_ name: String?) -> UIFont? {
        return UIFont(name: name ?? "", size: 10)
    }
    
    private func prepareColor(_ hex: String?) -> UIColor? {
        guard let hex = hex else {
            return nil
        }
        
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    return UIColor(red: r, green: g, blue: b, alpha: a)
                }
            }
        }
        
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "style" {
            let navController = segue.destination as? UINavigationController
            let controller = navController?.viewControllers.first as? StyleViewController
            controller?.delegate = self
            controller?.styleModel = model
        }
    }
}

extension StartViewController: StyleSource {

    func headersFont() -> UIFont {
        return prepareFont(model.headersFontName) ?? cHeadersFont
    }
    
    func headersColor() -> UIColor {
        return prepareColor(model.headersColor) ?? cHeadersColor
    }
    
    func headersBackgroundColor() -> UIColor {
        return prepareColor(model.headersBackgroundColor) ?? cHeadersBackgroundColor
    }
    
    func placeholdersFont() -> UIFont {
        return prepareFont(model.placeholdersFontName) ?? cPlaceholdersFont
    }
    
    func placeholdersColor() -> UIColor {
        return prepareColor(model.placeholdersColor) ?? cPlaceholdersColor
    }
    
    func textsFont() -> UIFont {
        return prepareFont(model.textsFontName) ?? cTextsFont
    }
    
    func textsColor() -> UIColor {
        return prepareColor(model.textsColor) ?? cTextsColor
    }
    
    func errorsFont() -> UIFont {
        return prepareFont(model.errorsFontName) ?? cErrorsFont
    }
    
    func errorsColor() -> UIColor {
        return prepareColor(model.errorsColor) ?? cErrorsColor
    }
    
    func cellsBackgroundColor() -> UIColor {
        return prepareColor(model.cellsBackgroundColor) ?? .white
    }
    
    func tableBackgroundColor() -> UIColor {
        return prepareColor(model.tableBackgroundColor) ?? cBackgroundColor
    }
    
    func resultTitleFont() -> UIFont {
        return prepareFont(model.resultTitleFontName) ?? cResultHeadersFont
    }
    
    func resultTitleColor() -> UIColor {
        return prepareColor(model.resultTitleColor) ?? cResultHeadersColor
    }
    
    func resultMessageFont() -> UIFont {
        return prepareFont(model.resultMessageFontName) ?? cResultMessageFont
    }
    
    func resultMessageColor() -> UIColor {
        return prepareColor(model.resultMessageColor) ?? cResultMessageColor
    }
    
    func buttonTitleFont() -> UIFont {
        return prepareFont(model.buttonTitleFontName) ?? cButtonTitleFont
    }
    
    func buttonColor() -> UIColor {
        return prepareColor(model.buttonColor) ?? cButtonColor
    }
}

// self <-- PaymentPresenter
extension StartViewController: PaymentPresenterDelegate {
    func didFinishPayment(bill: Bill?, error: Error?) {        
        if bill == nil, error != nil {
            presentAlert(title: "Error", message: error?.localizedDescription)
        }
    }
}

// self <-- StyleViewController
extension StartViewController: StyleViewControllerDelegate {
    func finishEdit(model: StyleModel) {
        self.model = model
    }
}
