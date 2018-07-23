//
//  SectionViewController.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 12/11/17.
//  Copyright © 2017 Tim Gorer. All rights reserved.
//

import UIKit
import RealmSwift

class SectionViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    
    var section : Section!
    var sections : Results<Section>!
    var indexPath: IndexPath!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var subheadVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var closeVisualEffectView: UIVisualEffectView!
    
    var parts : List<Part> { return section.parts }
    
    @IBOutlet weak var coverViewTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = .zero
        
        tableView.estimatedRowHeight = 200
        
        titleLabel.text = section.title
        captionLabel.text = section.caption
        
        if let url = section.imageURL {
            coverImageView.setImage(from: url)
        }
        
        // progressLabel.text = "\(indexPath.row+1) / \(sections.count)"
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBOutlet weak var tableView: UITableView!
    
}

extension SectionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return parts.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let part = parts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Media") as! SectionMediaTableViewCell
        
        cell.configure(with: part)
        
        return cell
    }
}

extension SectionViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        coverViewTop.constant = offsetY < 0 ? 0 : max(-offsetY, -420.0)
    }
}
