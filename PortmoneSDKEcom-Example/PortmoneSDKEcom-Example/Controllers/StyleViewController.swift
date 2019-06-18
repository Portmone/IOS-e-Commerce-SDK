//
//  StyleViewController.swift
//  PortmoneSDKEcom-Example
//
//  Created on 4/10/19.
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

protocol StyleViewControllerDelegate: class {
    
    func finishEdit(model: StyleModel)
}

final class StyleViewController: BaseViewController {

    @IBOutlet private weak var styleScrollView: UIScrollView!
    @IBOutlet private weak var titlesFontName: UITextField!
    @IBOutlet private weak var titlesColor: UITextField!
    @IBOutlet private weak var headersFontName: UITextField!
    @IBOutlet private weak var headersColor: UITextField!
    @IBOutlet private weak var headersBackgroundColor: UITextField!
    @IBOutlet private weak var placeholdersFontName: UITextField!
    @IBOutlet private weak var placeholdersColor: UITextField!
    @IBOutlet private weak var textsFontName: UITextField!
    @IBOutlet private weak var textsColor: UITextField!
    @IBOutlet private weak var errorsFontName: UITextField!
    @IBOutlet private weak var errorsColor: UITextField!
    @IBOutlet private weak var backgroundColor: UITextField!
    @IBOutlet private weak var resultMessageFontName: UITextField!
    @IBOutlet private weak var resultMessageColor: UITextField!
    @IBOutlet private weak var infoTextFontName: UITextField!
    @IBOutlet private weak var infoTextColor: UITextField!
    @IBOutlet private weak var buttonTitleFontName: UITextField!
    @IBOutlet private weak var buttonColor: UITextField!
    
    override var scrollView: UIScrollView? {
        return styleScrollView
    }
    
    weak var delegate: StyleViewControllerDelegate?
    
    var styleModel: StyleModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titlesFontName.text = styleModel?.titleFontName
        titlesColor.text = styleModel?.titleColor
        headersFontName.text = styleModel?.headersFontName
        headersColor.text = styleModel?.headersColor
        headersBackgroundColor.text = styleModel?.headersBackgroundColor
        placeholdersFontName.text = styleModel?.placeholdersFontName
        placeholdersColor.text = styleModel?.placeholdersColor
        textsFontName.text = styleModel?.textsFontName
        textsColor.text = styleModel?.textsColor
        errorsFontName.text = styleModel?.errorsFontName
        errorsColor.text = styleModel?.errorsColor
        backgroundColor.text = styleModel?.backgroundColor
        resultMessageFontName.text = styleModel?.resultMessageFontName
        resultMessageColor.text = styleModel?.resultMessageColor
        infoTextFontName.text = styleModel?.infoTextsFont
        infoTextColor.text = styleModel?.infoTextsColor
        buttonTitleFontName.text = styleModel?.buttonTitleFontName
        buttonColor.text = styleModel?.buttonColor
    }

    @IBAction private func textFieldChangeValue(_ sender: UITextField) {
        if sender == titlesFontName {
            styleModel.titleFontName = titlesFontName.text
        }
        if sender == titlesColor {
            styleModel.titleColor = titlesColor.text
        }
        if sender == headersFontName {
            styleModel.headersFontName = headersFontName.text
        }
        if sender == headersColor {
            styleModel.headersColor = headersColor.text
        }
        if sender == headersBackgroundColor {
            styleModel.headersBackgroundColor = headersBackgroundColor.text
        }
        if sender == placeholdersFontName {
            styleModel.placeholdersFontName = placeholdersFontName.text
        }
        if sender == placeholdersColor {
            styleModel.placeholdersColor = placeholdersColor.text
        }
        if sender == textsFontName {
            styleModel.textsFontName = textsFontName.text
        }
        if sender == textsColor {
            styleModel.textsColor = textsColor.text
        }
        if sender == errorsFontName {
            styleModel.errorsFontName = errorsFontName.text
        }
        if sender == errorsColor {
            styleModel.errorsColor = errorsColor.text
        }
        if sender == backgroundColor {
            styleModel.backgroundColor = backgroundColor.text
        }
        if sender == resultMessageFontName {
            styleModel.resultMessageFontName = resultMessageFontName.text
        }
        if sender == resultMessageColor {
            styleModel.resultMessageColor = resultMessageColor.text
        }
        if sender == infoTextFontName {
            styleModel.infoTextsFont = infoTextFontName.text
        }
        if sender == infoTextColor {
            styleModel.infoTextsColor = infoTextColor.text
        }
        if sender == buttonTitleFontName {
            styleModel.buttonTitleFontName = buttonTitleFontName.text
        }
        if sender == buttonColor {
            styleModel.buttonColor = buttonColor.text
        }
    }
    
    @IBAction private func dismissButtonClicked(_ sender: UIBarButtonItem) {
        delegate?.finishEdit(model: styleModel)
        view.endEditing(true)
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
