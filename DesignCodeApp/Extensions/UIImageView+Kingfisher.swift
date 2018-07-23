//
//  UIImageView+Kingfisher.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 13/04/18.
//  Copyright © 2018 Tim Gorer. All rights reserved.
//

import Kingfisher

extension UIImageView {
    
    func setImage(from url : URL) { setImage(from: url, with: nil) }
    
    @discardableResult
    func setImage(from url: URL, with placeholder: UIImage? = nil, completion: CompletionHandler? = nil) -> RetrieveImageTask? {
        
        ImageCache.default.retrieveImage(forKey: url.absoluteString, options: [], completionHandler: {
            image, _ in
            self.image = image
        })
        
        return kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.2))],
            progressBlock: nil,
            completionHandler: completion)
    }
}
