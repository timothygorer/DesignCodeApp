//
//  ViewController.swift
//  DesignCodeApp
//
//  Created by Meng To on 11/14/17.
//  Copyright © 2017 Meng To. All rights reserved.
//

import UIKit
import AVKit
import RealmSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deviceImageView: UIImageView!
    @IBOutlet weak var playVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var heroView: UIView!
    @IBOutlet weak var bookView: UIView!
    var isStatusBarHidden = false

    let presentSectionViewController = PresentSectionViewController()
    
    var sections : Results<Section> { return RealmManager.sections }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        let urlString = "https://player.vimeo.com/external/235468301.hd.mp4?s=e852004d6a46ce569fcf6ef02a7d291ea581358e&profile_id=175"
        let url = URL(string: urlString)
        let player = AVPlayer(url: url!)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }

    @IBAction func navigationBarBuyButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "Home to Purchase", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        scrollView.delegate = self
        
        titleLabel.alpha = 0
        deviceImageView.alpha = 0
        playVisualEffectView.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.titleLabel.alpha = 1
            self.deviceImageView.alpha = 1
            self.playVisualEffectView.alpha = 1
        }
        
        // setStatusBarBackgroundColor(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "Embed Chapter":
            let destination = segue.destination as! ChapterViewController
            destination.chapter = RealmManager.chapter(withId: "1")
            destination.view.translatesAutoresizingMaskIntoConstraints = false
            destination.delegate = self
            
        case "HomeToSection":
            let destination = segue.destination as! SectionViewController
            let indexPath = sender as! IndexPath
            let section = sections[indexPath.row]
            destination.section = section
            destination.sections = sections
            destination.indexPath = indexPath
            destination.transitioningDelegate = self

            isStatusBarHidden = true
            UIView.animate(withDuration: 0.5, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            })
        case "Benefits":
            segue.destination.view.translatesAutoresizingMaskIntoConstraints = false
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        isStatusBarHidden = false
        UIView.animate(withDuration: 0.5) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

extension HomeViewController : UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return presentSectionViewController
    }
}

extension HomeViewController : ChapterCollectionDelegate {
    
    func didTap(cell: SectionCollectionViewCell, on collectionView: UICollectionView, for section: Section, with transform: CATransform3D) {
        print("called didTap")
        let indexPath = collectionView.indexPath(for: cell)!
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)!
        let frame = collectionView.convert(attributes.frame, to: view)
        presentSectionViewController.cellFrame = frame
        presentSectionViewController.cellTransform = transform
        
        performSegue(withIdentifier: "HomeToSection", sender: indexPath)
    }
}

extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            heroView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            playVisualEffectView.transform = CGAffineTransform(translationX: 0, y: -offsetY/3)
            titleLabel.transform = CGAffineTransform(translationX: 0, y: -offsetY/3)
            deviceImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/4)
            backgroundImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/5)
        }
        
        let navigationIsHidden = offsetY <= 0
        navigationController?.setNavigationBarHidden(navigationIsHidden, animated: true)
    }
}
