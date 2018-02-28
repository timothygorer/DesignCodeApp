//
//  BookmarksTableViewController.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 14/01/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

class BookmarksTableViewController : UITableViewController {

    var bookmarks : Array<Dictionary<String,String>> = allBookmarks

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return bookmarks.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "Bookmarks to Section", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "Bookmarks to Section", let destination = segue.destination as? SectionViewController {
            destination.section = sections[0]
            destination.sections = sections
            destination.indexPath = sender as! IndexPath
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell") as! BookmarkTableViewCell

        let bookmark = bookmarks[indexPath.row]

        cell.chapterTitleLabel.text = bookmark["section"]!.uppercased()
        cell.titleLabel.text = bookmark["part"]
        cell.bodyLabel.text = bookmark["content"]
        cell.chapterNumberLabel.text = bookmark["chapter"]
        cell.badgeImageView.image = UIImage(named: "Bookmarks/" + bookmark["type"]!)

        return cell
    }

}

public extension UIViewController {
    @IBAction public func unwindToViewController (_ segue : UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}
