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
    
    var bookmark : Bookmark?
    var part : Part!

    func configure(with part : Part) {

        titleLabel.text = part.title
        subtitleLabel.text = part.subhead
        
        titleLabel.isHidden = part.title == ""
        subtitleLabel.isHidden = part.subhead == ""
        
        bodyLabel.attributedText = part.body.wrappedIntoStyle.htmlToAttributedString
        
        bookmark = RealmManager.bookmark(for: part)
        
        styleBookmarkButton(for: bookmark)
        
        self.part = part
        
        self.layoutCell(for: nil)

        guard let url = part.imageURL else { return }

        mediaImageView.setImage(from: url, with: nil) {

            (image, error, cache, url) in

            guard let image = image else { return }

            self.layoutCell(for: image)
        }
    }

    func layoutCell(for image : UIImage?) {

        if let previousConstraint = mediaImageView.constraints.filter({ (constraint) -> Bool in
            return constraint.identifier == "Ratio constraint"
        }).first {
            mediaImageView.removeConstraint(previousConstraint)
        }
        
        guard let image = image else {
            let constraint = NSLayoutConstraint(item: mediaImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 0.0) // tells media image view its height should be 0
            constraint.identifier = "Ratio constraint"
            
            mediaImageView.addConstraint(constraint)
            
            return
        }

        let ratio = image.size.ratio

        let constraint = NSLayoutConstraint(item: mediaImageView, attribute: .width, relatedBy: .equal, toItem: mediaImageView, attribute: .height, multiplier: ratio, constant: 0.0)
        constraint.identifier = "Ratio constraint"

        mediaImageView.addConstraint(constraint)
    }
    
    func styleBookmarkButton(for bookmark : Bookmark?) {
        if bookmark == nil {
            bookmarkButton.tintColor = UIColor(named: "gray")
        } else {
            bookmarkButton.tintColor = UIColor(named: "blue")
        }
    
    }

    @IBAction func bookmarkTapped(_ sender: UIButton) {
        if let bookmark = bookmark {
            // remove from server
            Bookmarks.remove(bookmark).dataTask(completion: nil).resume()
            
            // remove from Realm
            RealmManager.remove(bookmark)
            
            self.bookmark = nil
        } else {
            // create a new bookmark
            let bookmark = Bookmark()
            bookmark.id = part.bookmarkId
            
            // add to Realm
            RealmManager.add(bookmark)
            
            // add to server
            Bookmarks.create(bookmark).dataTask(completion: nil).resume()
            
            self.bookmark = bookmark
        }
        
        styleBookmarkButton(for: bookmark)
    }
}
