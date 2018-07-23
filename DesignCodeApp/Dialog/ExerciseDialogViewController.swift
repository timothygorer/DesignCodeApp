//
//  ExerciseViewController.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 31/01/18.
//  Copyright © 2018 Tim Gorer. All rights reserved.
//

import UIKit
import MKRingProgressView

class ExerciseDialogViewController: UIViewController {

    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var progressView: MKRingProgressView!
    @IBOutlet weak var progressLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let angle : CGFloat = -100.0 * .pi / 180.0
        var rotationTransform = CATransform3DMakeRotation(angle, 0, 1, 0)
        rotationTransform.m34 = -1.0/1000

        var translationTransform = CATransform3DMakeTranslation(80, 200, 0)
        translationTransform.m34 = -1.0/2500

        let transform = CATransform3DConcat(rotationTransform, translationTransform)

        dialogView.layer.transform = transform
        dialogView.alpha = 0

        let animator = UIViewPropertyAnimator(duration: 0.8, dampingRatio: 0.7) {
            self.dialogView.transform = .identity
            self.dialogView.alpha = 1
        }
        animator.startAnimation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        progressLabel.animateTo(70)

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.progressView.animateTo(70)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.dismiss(animated: true)
        }
    }
}
