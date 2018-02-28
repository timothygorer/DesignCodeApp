//
//  BenefitsViewController.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 28/02/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

class BenefitsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        adjustHeight()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        super.viewWillTransition(to: size, with: coordinator)

        self.collectionView?.reloadData()

        adjustHeight()
    }

    func adjustHeight() {

        let now = DispatchTime.now()
        let deadline : DispatchTime = now + .milliseconds(100)
        DispatchQueue.main.asyncAfter(deadline: deadline) { [weak self] in

            guard self != nil else { return }

            self!.collectionViewHeight.constant = self!.collectionView.contentSize.height
        }
    }
}

extension BenefitsViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return benefits.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Benefit", for: indexPath) as! BenefitCollectionViewCell

        let benefit = benefits[indexPath.row]
        cell.subheadLabel.text = benefit["subhead"]?.uppercased()
        cell.titleLabel.text = benefit["title"]
        cell.bodyLabel.text = benefit["body"]
        cell.imageView.image = UIImage(named: "Benefit-" + benefit["image"]!)

        return cell
    }
}

extension BenefitsViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let benefit = benefits[indexPath.row]
        var width : CGFloat = 0.0

        switch collectionView.frame.width {
        case 640...959:
            width = collectionView.frame.width / 2
        case 960...3000:
            width = collectionView.frame.width / 3
        default:
            width = collectionView.frame.width
        }

        // Simulating dynamic labels

        let titleLabel = UILabel()
        titleLabel.frame.size = CGSize(width: width - 120, height: CGFloat.greatestFiniteMagnitude)
        titleLabel.text = benefit["title"]
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        titleLabel.sizeToFit()

        let textLabel = UILabel()
        textLabel.frame.size = CGSize(width: width - 120, height: CGFloat.greatestFiniteMagnitude)
        textLabel.text = benefit["body"]
        textLabel.numberOfLines = 5
        textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        textLabel.minimumScaleFactor = 0.5
        textLabel.sizeToFit()

        let height = titleLabel.frame.height + textLabel.frame.height + 90

        return CGSize(width: width, height: height)
    }
}
