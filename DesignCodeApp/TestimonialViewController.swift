//
//  TestimonialViewController.swift
//  DesignCodeApp
//
//  Created by Meng To on 12/23/17.
//  Copyright © 2017 Meng To. All rights reserved.
//

import UIKit

class TestimonialViewController: UIViewController {
    @IBOutlet weak var testimonialCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testimonialCollectionView.delegate = self
        testimonialCollectionView.dataSource = self
    }
}

extension TestimonialViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testimonials.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testimonialCell", for: indexPath) as! TestimonialCollectionViewCell
        let testimonial = testimonials[indexPath.row]
        cell.textLabel.text = testimonial["text"]
        cell.nameLabel.text = testimonial["name"]
        cell.jobLabel.text = testimonial["job"]
        cell.avatarImageView.image = UIImage(named: testimonial["avatar"]!)
        
        return cell
    }
}
