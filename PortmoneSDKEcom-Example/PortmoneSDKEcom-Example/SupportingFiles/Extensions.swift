//
//  Extensions.swift
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

import UIKit

extension String {
    
    var hexColorValue: UIColor? {
        let r, g, b, a: CGFloat
        
        if self.hasPrefix("#") {
            let start = self.index(self.startIndex, offsetBy: 1)
            let hexColor = String(self[start...])
            
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
    
    func font(_ size: CGFloat = 10.0) -> UIFont? {
        // Size not necessary because it will be changed after.
        return UIFont(name: self, size: size)
    }
}

extension UIFont {
    
    class func robotoRegular(with size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size) ?? italicSystemFont(ofSize: size)
    }
    
    class func robotoMedium(with size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: size) ?? italicSystemFont(ofSize: size)
    }
}
