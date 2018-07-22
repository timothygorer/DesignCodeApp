//
//  String+HTMLDecoding.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 12/04/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

private let characterEntities : Dictionary<String, Character> = [
    "&quot;"    : "\"",
    "&amp;"     : "&",
    "&apos;"    : "'",
    "&lt;"      : "<",
    "&gt;"      : ">",
    "&nbsp;"    : "\u{00a0}",
    "&diams;"   : "♦",
    "&rsquo;"   : "\u{2019}"
]

extension String {
    
    var htmlToAttributedString : NSAttributedString? {
        
        guard let data = data(using: .utf8) else { return nil }
        
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        } catch {
            print("Unable to convert HTML String to Attributed String:", error)
            return  nil
        }
    }
    
    var wrappedIntoStyle : String {
        
        let bounds : CGRect = UIScreen.main.bounds
        
        let font = "-apple-system"
        let fontSize = 19
        let lineHeight = 25
        let imageWidth = bounds.width - 40
        let margin = 20
        
        let codeStyle = """
        code {
        background: transparent;
        color: \( #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).hex );
        font-size: 19px;
        font-weight: 600;
        line-height: 140%;
        }
        code.language-coffeescript .token.comment { color: \( #colorLiteral(red: 0.4156862745, green: 0.4588235294, blue: 0.462745098, alpha: 1).hex ) }
        code.language-coffeescript .token.string { color: \( #colorLiteral(red: 0.5411764706, green: 0.862745098, blue: 0.3921568627, alpha: 1).hex ) }
        code.language-coffeescript .token.number, code.language-coffeescript .token.operator { color: \( #colorLiteral(red: 0.6470588235, green: 0.5019607843, blue: 0.9725490196, alpha: 1).hex ) }
        code.language-coffeescript .token.keyword, code.language-coffeescript .token.class-name, code.language-coffeescript .token.function { color: \( #colorLiteral(red: 0.5333333333, green: 0.8666666667, blue: 1, alpha: 1).hex ) }
        code.language-swift .token.comment { color: \( #colorLiteral(red: 0.2549019608, green: 0.7137254902, blue: 0.2705882353, alpha: 1).hex ) }
        code.language-swift .token.string { color: \( #colorLiteral(red: 0.9333333333, green: 0.262745098, blue: 0.2470588235, alpha: 1).hex ) }
        code.language-swift .token.keyword { color: \( #colorLiteral(red: 0.7882352941, green: 0.2705882353, blue: 0.6549019608, alpha: 1).hex ) }
        code.language-swift .token.number, code.language-swift .token.function, code.language-swift .token.builtin, code.language-swift .token.class-name { color: \( #colorLiteral(red: 0.3607843137, green: 0.1490196078, blue: 0.6, alpha: 1).hex ) }
        """
        
        let htmlString = """
        <style>
        p, li {
        color: \( #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).hex );
        font-family:\"\(font)\";
        font-size:\(fontSize)px;
        line-height:\(lineHeight)px
        }
        p {
        margin: \(margin)px 0;
        }
        img {
        max-width: \(imageWidth)px;
        }
        #p {
        font-weight: bold;
        font-size: 24px;
        line-height: 130%;
        margin: 50px 20px;
        }
        ul li, ol li {
        margin: 20px 0;
        font-weight: bold;
        }
        \(codeStyle)
        </style>
        \(self)
        """
        
        return htmlString
    }
}
