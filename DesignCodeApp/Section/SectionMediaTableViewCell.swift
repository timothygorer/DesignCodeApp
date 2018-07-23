//
//  SectionMediaTableViewCell.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 12/04/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

extension CGSize {
    var ratio : CGFloat { return width/height }
}

class SectionMediaTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    @IBOutlet weak var bodyLabel : UITextView!
    @IBOutlet weak var bookmarkButton : UIButton!

    @IBOutlet weak var mediaImageView : UIImageView!

    func configure(with part : Part) {

        titleLabel.text = part.title
        bodyLabel.attributedText = part.body.wrappedIntoStyle.htmlToAttributedString

        guard let url = part.imageURL else { return }

        mediaImageView.setImage(from: url, with: nil) {

            (image, error, cache, url) in

            guard let image = image else { return }

            self.layoutCell(for: image)
        }
    }

    func layoutCell(for image : UIImage) {

        if let previousConstraint = mediaImageView.constraints.filter({ (constraint) -> Bool in
            return constraint.identifier == "Ratio constraint"
        }).first {
            mediaImageView.removeConstraint(previousConstraint)
        }

        let ratio = image.size.ratio

        let constraint = NSLayoutConstraint(item: mediaImageView, attribute: .width, relatedBy: .equal, toItem: mediaImageView, attribute: .height, multiplier: ratio, constant: 0.0)
        constraint.identifier = "Ratio constraint"

        mediaImageView.addConstraint(constraint)
    }

    @IBAction func bookmarkTapped(_ sender: UIButton) {}
}
