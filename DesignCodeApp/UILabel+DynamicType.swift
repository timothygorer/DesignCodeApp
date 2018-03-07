//
//  UILabel+DynamicType.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 06/03/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)

fileprivate enum TextStyles : String {

    case body, callout, caption1, caption2, footnote, headline, subheadline, title1, title2, title3, largeTitle

    var textStyle : UIFontTextStyle {
        switch self {
        case .body: return .body
        case .callout: return .callout
        case .caption1: return .caption1
        case .caption2: return .caption2
        case .footnote: return .footnote
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .title1: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .largeTitle: return .largeTitle
        }
    }
}

@available(iOS 11.0, *)
extension UILabel {

    @IBInspectable var scaledFont : String {
        set (value) {
            guard let style = TextStyles(rawValue: value)?.textStyle else { return }

            let scaledFont = UIFontMetrics(forTextStyle: style).scaledFont(for: font)

            font = scaledFont

            adjustsFontForContentSizeCategory = true
        }
        get { return "" }
    }
}
