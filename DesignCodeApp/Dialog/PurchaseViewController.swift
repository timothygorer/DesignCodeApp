//
//  PurchaseViewController.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 25/01/18.
//  Copyright © 2018 Tim Gorer. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController {

    @IBOutlet var panToClose: InteractionPanToClose!

    override func viewDidLoad() {
        super.viewDidLoad()

        panToClose.setGestureRecognizer()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        panToClose.animateDialogAppear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
