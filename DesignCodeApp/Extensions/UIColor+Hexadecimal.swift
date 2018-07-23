//
//  UIColor+Hexadecimal.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 12/04/18.
//  Copyright © 2018 Tim Gorer. All rights reserved.
//

import UIKit

enum UIColorInputError : Error {
    case missingHashMarkAsPrefix, unableToScanHexValue, mismatchedHexStringLength, unableToOutputHexStringForWideDisplayColor
}

extension UIColor {
    
    func getHexString(_ alpha : Bool = false) throws -> String  {
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        guard r >= 0 && r <= 1 && g >= 0 && g <= 1 && b >= 0 && b <= 1 else {
            throw UIColorInputError.unableToOutputHexStringForWideDisplayColor
        }
        
        if alpha {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
    
    var hex : String  {
        return (try? getHexString()) ?? ""
    }
}
