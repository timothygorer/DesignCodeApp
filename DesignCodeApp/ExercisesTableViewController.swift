//
//  ExercisesTableViewController.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 30/01/18.
//  Copyright © 2018 Tim Gorer. All rights reserved.
//

import UIKit

class ExercisesTableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Exercise Cell", for: indexPath) as! ExerciseTableViewCell

        cell.questions = Array(exercises.values)[indexPath.row]
        cell.delegate = self

        return cell
    }
}

extension ExercisesTableViewController : ExerciseTableViewCellDelegate {
    func exerciseCell(_ cell: ExerciseTableViewCell, receivedAnswer correct: Bool, forQuestion question: Dictionary<String, Any>) {

        performSegue(withIdentifier: "Present Exercise Dialog", sender: nil)
    }

    func exerciseCell(_ cell: ExerciseTableViewCell, didReceiveShareFor exercise: Array<Dictionary<String, Any>>, onScoreCell scoreCell: ScoreCollectionViewCell) {

        let message = "🙌 72% in the iOS Design challenge from the Design+Code app by @TimGorer"
        let link = URL(string: "https://designcode.io/")!
        guard let image = UIImage(view: scoreCell) else { return }

        let objectsToShare = [message, link, image] as Array<Any>

        let activity = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activity.excludedActivityTypes = [.airDrop, .addToReadingList, .saveToCameraRoll]
        activity.popoverPresentationController?.sourceView = scoreCell

        present(activity, animated: true)
    }
}

extension UIImage {

    convenience init?(view: UIView) {

        UIGraphicsBeginImageContext(view.frame.size)

        guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: currentContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        if let graphicImage = image?.cgImage {
            self.init(cgImage: graphicImage)
        } else {
            return nil
        }
    }
}
