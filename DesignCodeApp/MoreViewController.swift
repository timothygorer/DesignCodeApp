//
//  MoreViewController.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 14/01/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit
import MKRingProgressView

extension MKRingProgressView {

    func animateTo(_ number : Int) {

        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        self.progress = Double(number)/100
        CATransaction.commit()
    }
}

extension UILabel {

    func animateTo(_ number: Int) {

        guard number > 0 else { return }

        let now = DispatchTime.now()

        for index in 0...number {

            let milliseconds = 10 * index
            let deadline : DispatchTime = now + .milliseconds(milliseconds)

            DispatchQueue.main.asyncAfter(deadline: deadline) {

                self.text = "\(index)%"
            }
        }
    }
}

class MoreViewController: UIViewController {

    @IBOutlet weak var progress1View: MKRingProgressView!
    @IBOutlet weak var progress2View: MKRingProgressView!
    @IBOutlet weak var progress3View: MKRingProgressView!

    @IBOutlet weak var progress1Label: UILabel!
    @IBOutlet weak var progress2Label: UILabel!
    @IBOutlet weak var progress3Label: UILabel!

    @IBOutlet weak var dialogView: UIView!
    @IBOutlet var panToClose : InteractionPanToClose!

    weak var previousViewController : UIViewController?

    @IBAction func tappedOutsideDialog (_ sender : UITapGestureRecognizer) {

        UIView.animate(withDuration: 0.5, animations: {

            self.panToClose.rotateDialogOut()

        }) { (finished) in

            self.tabBarController?.selectedViewController = self.previousViewController
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let progress = [72,56,22]

        progress1Label.animateTo(progress[0])
        progress2Label.animateTo(progress[1])
        progress3Label.animateTo(progress[2])

        progress1View.animateTo(progress[0])
        progress2View.animateTo(progress[1])
        progress3View.animateTo(progress[2])
    }

    @IBAction func safariButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "More to Web", sender: "https://designcode.io")
    }
    @IBAction func communityButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "More to Web", sender: "https://spectrum.chat/design-code")
    }
    @IBAction func twitterHandleTapped(_ sender: Any) {
        performSegue(withIdentifier: "More to Web", sender: "https://twitter.com/mengto")
    }
    @IBAction func emailButtonTapped(_ sender: Any) {
        let email = "meng@designcode.io"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let identifier = segue.identifier, identifier == "More to Web" {
            let toNav = segue.destination as! UINavigationController
            let toVC = toNav.viewControllers.first as! WebViewController
            toVC.urlString = sender as! String
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
