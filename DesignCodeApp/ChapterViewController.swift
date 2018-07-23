//
//  ChapterViewController.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 7/22/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit
import RealmSwift

class ChapterViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate : ChapterCollectionDelegate?
    
    var chapter : Chapter?
    
    var searchText : String = "" {
        didSet { collectionView.reloadData() }
    }
    
    var sections : Results<Section>!
}

extension ChapterViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard chapter != nil else { return 0 }
        
        if searchText.count == 0 {
            sections = RealmManager
                .realm
                .objects(Section.self)
                .sorted(byKeyPath: "order")
            
            titleLabel.text = "CHAPTER \(chapter!.id): \(sections.count) SECTIONS"
        } else {
            sections = RealmManager
                .realm
                .objects(Section.self)
                .sorted(byKeyPath: "order")
                .filter("title CONTAINS[c] %@ OR caption CONTAINS[c] %@ OR body CONTAINS %@", searchText, searchText, searchText)
        }
        
        return sections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell", for: indexPath) as! SectionCollectionViewCell
        let section = sections[indexPath.row]
        cell.titleLabel.text = section.title
        cell.captionLabel.text = section.caption
        cell.coverImageView.setImage(from: section.imageURL!)
        
        cell.layer.transform = animateCell(cellFrame: cell.frame)
        
        return cell
    }
}

extension ChapterViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SectionCollectionViewCell
        let transform = animateCell(cellFrame: cell.frame)
        let section = chapter!.sections[indexPath.row]
        
        // tell a delegate to do a segue (in this case, its parent view controller). In other words, need a way for ChapterVC to tell HomeVC to do a transition
        delegate?.didTap(cell: cell, on: collectionView, for: section, with: transform)
    }
}

protocol ChapterCollectionDelegate : class {
    
    func didTap(cell : SectionCollectionViewCell, on collectionView : UICollectionView, for section : Section, with transform : CATransform3D)
}

extension ChapterViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            for cell in collectionView.visibleCells as! [SectionCollectionViewCell] {
                let indexPath = collectionView.indexPath(for: cell)!
                let attributes = collectionView.layoutAttributesForItem(at: indexPath)!
                let cellFrame = collectionView.convert(attributes.frame, to: view)
                
                let translationX = cellFrame.origin.x / 5
                cell.coverImageView.transform = CGAffineTransform(translationX: translationX, y: 0)
                
                cell.layer.transform = animateCell(cellFrame: cellFrame)
            }
        }
    }
    
    func animateCell(cellFrame: CGRect) -> CATransform3D {
        let angleFromX = Double((-cellFrame.origin.x) / 10)
        let angle = CGFloat((angleFromX * Double.pi) / 180.0)
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/1000
        let rotation = CATransform3DRotate(transform, angle, 0, 1, 0)
        
        var scaleFromX = (1000 - (cellFrame.origin.x - 200)) / 1000
        let scaleMax: CGFloat = 1.0
        let scaleMin: CGFloat = 0.6
        if scaleFromX > scaleMax {
            scaleFromX = scaleMax
        }
        if scaleFromX < scaleMin {
            scaleFromX = scaleMin
        }
        let scale = CATransform3DScale(CATransform3DIdentity, scaleFromX, scaleFromX, 1)
        
        return CATransform3DConcat(rotation, scale)
    }
}
