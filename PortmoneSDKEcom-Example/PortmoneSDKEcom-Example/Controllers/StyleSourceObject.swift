//
//  StyleSourceObject.swift
//  PortmoneSDKEcom-Example
//
//  Created by Oleg Pankiv on 5/2/19.
//  Copyright © 2019 Devlight. All rights reserved.
//

import UIKit
import PortmoneSDKEcom

class StyleSourceObject: StyleSource {
    
    var model = StyleModel()
    var style = Styler()
    
    func titleFont() -> UIFont {
        return model.titleFontName?.font() ?? style.cTitleFont
    }
    
    func titleColor() -> UIColor {
        return model.titleColor?.hexColorValue ?? style.cTitleColor
    }
    
    func titleBackgroundColor() -> UIColor {
        return model.titleBackgroundColor?.hexColorValue ?? style.cTitleBackgroundColor
    }
    
    func headersFont() -> UIFont {
        return model.headersFontName?.font() ?? style.cHeadersFont
    }
    
    func headersColor() -> UIColor {
        return model.headersColor?.hexColorValue ?? style.cHeadersColor
    }
    
    func headersBackgroundColor() -> UIColor {
        return model.headersBackgroundColor?.hexColorValue ?? style.cHeadersBackgroundColor
    }
    
    func placeholdersFont() -> UIFont {
        return model.placeholdersFontName?.font() ?? style.cPlaceholdersFont
    }
    
    func placeholdersColor() -> UIColor {
        return model.placeholdersColor?.hexColorValue ?? style.cPlaceholdersColor
    }
    
    func textsFont() -> UIFont {
        return model.textsFontName?.font() ?? style.cTextsFont
    }
    
    func textsColor() -> UIColor {
        return model.textsColor?.hexColorValue ?? style.cTextsColor
    }
    
    func errorsFont() -> UIFont {
        return model.errorsFontName?.font() ?? style.cErrorsFont
    }
    
    func errorsColor() -> UIColor {
        return model.errorsColor?.hexColorValue ?? style.cErrorsColor
    }
    
    func backgroundColor() -> UIColor {
        return model.backgroundColor?.hexColorValue ?? style.cBackgroundColor
    }
    
    func resultMessageFont() -> UIFont {
        return model.resultMessageFontName?.font() ?? style.cResultMessageFont
    }
    
    func resultMessageColor() -> UIColor {
        return model.resultMessageColor?.hexColorValue ?? style.cResultMessageColor
    }
    
    func resultSaveReceiptColor() -> UIColor {
        return model.resultSaveReceiptColor?.hexColorValue ?? style.cResultSaveReceiptColor
    }
    
    func infoTextsFont() -> UIFont {
        return model.infoTextsFont?.font() ?? style.cInfoTextsFont
    }
    
    func infoTextsColor() -> UIColor {
        return model.infoTextsColor?.hexColorValue ?? style.cInfoTextsColor
    }
    
    func buttonTitleFont() -> UIFont {
        return model.buttonTitleFontName?.font() ?? style.cButtonTitleFont
    }
    
    func buttonTitleColor() -> UIColor {
        return model.buttonTitleColor?.hexColorValue ?? style.cButtonTitleColor
    }
    
    func buttonColor() -> UIColor {
        return model.buttonColor?.hexColorValue ?? style.cButtonColor
    }
    
    func buttonCornerRadius() -> CGFloat {
        return model.buttonCornerRadius ?? style.cButtonCornerRadius
    }
    
    func biometricButtonColor() -> UIColor {
        return model.biometricButtonColor?.hexColorValue ?? style.cBiometricButtonColor
    }
    
    func successImage() -> UIImage? {
        return model.successResultImage
    }
    
    func failureImage() -> UIImage? {
        return model.failureResultImage
    }
}
