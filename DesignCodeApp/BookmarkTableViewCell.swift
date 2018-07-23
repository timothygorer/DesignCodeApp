//
//  BookmarkTableViewCell.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 19/12/17.
//  Copyright © 2017 Tim Gorer. All rights reserved.
//

import UIKit

class BookmarkTableViewCell : UITableViewCell {
    
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var chapterNumberLabel: UILabel!
    @IBOutlet weak var chapterTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    @IBOutlet var regularConstraints: [NSLayoutConstraint]!
    @IBOutlet var accessibilityConstraints: [NSLayoutConstraint]!

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {

            if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
                NSLayoutConstraint.deactivate(regularConstraints)
                NSLayoutConstraint.activate(accessibilityConstraints)
            } else {
                NSLayoutConstraint.activate(regularConstraints)
                NSLayoutConstraint.deactivate(accessibilityConstraints)
            }
        }
    }
    
    func configure(for part : Part, with section : Section) {
        if part.title == "" {
            titleLabel.text = part.subhead
        } else {
            titleLabel.text = part.title
        }
        
        chapterTitleLabel.text = section.title.uppercased()
        bodyLabel.attributedText = part.body.wrappedIntoStyle.htmlToAttributedString
        chapterNumberLabel.text = section.chapterId
        badgeImageView.image = UIImage(named: "Bookmarks/" + "text")
        
    }
}
