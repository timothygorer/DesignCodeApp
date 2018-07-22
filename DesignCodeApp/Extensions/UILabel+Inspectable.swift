//
//  UILabel+Designable.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 25/01/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

extension UILabel {
    
    @IBInspectable var shadowOffsetY: CGFloat {
        set { layer.shadowOffset.height = newValue }
        get { return layer.shadowOffset.height }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set { layer.shadowRadius = newValue }
        get { return layer.shadowRadius }
    }
    
    @IBInspectable var shadowOpacity: CGFloat {
        set { layer.shadowOpacity = Float(newValue) }
        get { return CGFloat(layer.shadowOpacity) }
    }
}
