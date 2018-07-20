//
//  BookmarksTableViewController.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 14/01/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

class BookmarksTableViewController : UITableViewController {

    var bookmarks : Array<Bookmark> = ContentAPI.shared.bookmarks
    
    var sections : Array<Section> = ContentAPI.shared.sections

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

        cell.chapterTitleLabel.text = bookmark.sectionTitle.uppercased()
        cell.titleLabel.text = bookmark.partHeading
        cell.bodyLabel.text = bookmark.content
        cell.chapterNumberLabel.text = bookmark.chapterNumber
        cell.badgeImageView.image = UIImage(named: "Bookmarks/" + (bookmark.type?.rawValue ?? "text"))

        return cell
    }

}

public extension UIViewController {
    @IBAction public func unwindToViewController (_ segue : UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}
