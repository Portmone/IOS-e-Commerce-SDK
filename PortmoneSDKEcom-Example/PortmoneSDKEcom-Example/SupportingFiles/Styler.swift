//
//  Styler.swift
//  PortmoneSDKEcom-Example
//
//  Created by Oleg Pankiv on 4/15/19.
//  Copyright © 2019 Devlight. All rights reserved.
//

import UIKit

final class Styler {
    // Navigation title
    let cTitleFont = UIFont.robotoMedium(with: 16)
    let cTitleColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    // HeaderView title
    let cHeadersFont = UIFont.robotoMedium(with: 14)
    let cHeadersColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let cHeadersBackgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
    
    // Custom Textfields
    let cPlaceholdersFont = UIFont.robotoRegular(with: 17)
    let cPlaceholdersColor = #colorLiteral(red: 0.5529411765, green: 0.5529411765, blue: 0.5529411765, alpha: 1)
    let cTextsFont = UIFont.robotoRegular(with: 18)
    let cTextsColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let cErrorsFont = UIFont.robotoRegular(with: 12)
    let cErrorsColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    
    // All view background color and navigation bar
    let cBackgroundColor = UIColor.white
    
    // Result screen label
    let cResultMessageFont = UIFont.robotoRegular(with: 18)
    let cResultMessageColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    // Save card info label on button
    let cInfoTextsFont = UIFont.robotoRegular(with: 14)
    let cInfoTextsColor = #colorLiteral(red: 0.5529411765, green: 0.5529411765, blue: 0.5529411765, alpha: 1)

    // FooterView
    let cButtonTitleFont = UIFont.robotoMedium(with: 18)
    let cButtonTitleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let cButtonColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let cBiometricButtonColor = #colorLiteral(red: 0.5529411765, green: 0.5529411765, blue: 0.5529411765, alpha: 1)
}
