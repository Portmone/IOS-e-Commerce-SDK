//
//  StyleSourceObject.swift
//  PortmoneSDKEcom-Example
//
//  Created by Oleg Pankiv on 5/2/19.
//  Copyright © 2019 Devlight. All rights reserved.
//

import UIKit
import PortmoneSDKEcom

class StyleSourceObject: StyleSourceModel {
    
    var model: StyleModel {
        get {
            guard let data = UserDefaults.standard.value(forKey: "UDStyleModelKey") as? Data,
                let model = try? JSONDecoder().decode(StyleModel.self, from: data) else {
                    return StyleModel()
            }
            
            return model
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: "UDStyleModelKey")
        }
    }
    
    var style = Styler()
    
    override func titleFont() -> UIFont {
        return model.titleFontName?.font() ?? style.cTitleFont
    }
    
    override func titleColor() -> UIColor {
        return model.titleColor?.hexColorValue ?? style.cTitleColor
    }
    
    override func titleBackgroundColor() -> UIColor {
        return model.titleBackgroundColor?.hexColorValue ?? style.cTitleBackgroundColor
    }
    
    override func headersFont() -> UIFont {
        return model.headersFontName?.font() ?? style.cHeadersFont
    }
    
    override func headersColor() -> UIColor {
        return model.headersColor?.hexColorValue ?? style.cHeadersColor
    }
    
    override func headersBackgroundColor() -> UIColor {
        return model.headersBackgroundColor?.hexColorValue ?? style.cHeadersBackgroundColor
    }
    
    override func placeholdersFont() -> UIFont {
        return model.placeholdersFontName?.font() ?? style.cPlaceholdersFont
    }
    
    override func placeholdersColor() -> UIColor {
        return model.placeholdersColor?.hexColorValue ?? style.cPlaceholdersColor
    }
    
    override func textsFont() -> UIFont {
        return model.textsFontName?.font() ?? style.cTextsFont
    }
    
    override func textsColor() -> UIColor {
        return model.textsColor?.hexColorValue ?? style.cTextsColor
    }
    
    override func errorsFont() -> UIFont {
        return model.errorsFontName?.font() ?? style.cErrorsFont
    }
    
    override func errorsColor() -> UIColor {
        return model.errorsColor?.hexColorValue ?? style.cErrorsColor
    }
    
    override func backgroundColor() -> UIColor {
        return model.backgroundColor?.hexColorValue ?? style.cBackgroundColor
    }
    
    override func resultMessageFont() -> UIFont {
        return model.resultMessageFontName?.font() ?? style.cResultMessageFont
    }
    
    override func resultMessageColor() -> UIColor {
        return model.resultMessageColor?.hexColorValue ?? style.cResultMessageColor
    }
    
    override func resultSaveReceiptColor() -> UIColor {
        return model.resultSaveReceiptColor?.hexColorValue ?? style.cResultSaveReceiptColor
    }
    
    override func infoTextsFont() -> UIFont {
        return model.infoTextsFont?.font() ?? style.cInfoTextsFont
    }
    
    override func infoTextsColor() -> UIColor {
        return model.infoTextsColor?.hexColorValue ?? style.cInfoTextsColor
    }
    
    override func buttonTitleFont() -> UIFont {
        return model.buttonTitleFontName?.font() ?? style.cButtonTitleFont
    }
    
    override func buttonTitleColor() -> UIColor {
        return model.buttonTitleColor?.hexColorValue ?? style.cButtonTitleColor
    }
    
    override func buttonColor() -> UIColor {
        return model.buttonColor?.hexColorValue ?? style.cButtonColor
    }
    
    override func buttonCornerRadius() -> CGFloat {
        return model.buttonCornerRadius ?? style.cButtonCornerRadius
    }
    
    override func biometricButtonColor() -> UIColor {
        return model.biometricButtonColor?.hexColorValue ?? style.cBiometricButtonColor
    }
    
    override func successImage() -> UIImage? {
        return UIImage(data: model.successResultImage ?? Data())
    }
    
    override func failureImage() -> UIImage? {
        return UIImage(data: model.failureResultImage ?? Data())
    }
}
