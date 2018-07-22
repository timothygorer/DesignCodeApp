//
//  BookmarksTableViewController.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 14/01/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit
import RealmSwift

class BookmarksTableViewController : UITableViewController {

    var bookmarks : Results<Bookmark> { return RealmManager.bookmarks }

    var sections : Results<Section> { return RealmManager.sections }

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
        
        let section = bookmark.section!
        let part = bookmark.part!

        cell.chapterTitleLabel.text = section.title.uppercased()
        cell.titleLabel.text = part.title
        cell.bodyLabel.text = part.body
        cell.chapterNumberLabel.text = section.chapterId
        cell.badgeImageView.image = UIImage(named: "Bookmarks/" + "text")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let bookmark = bookmarks[indexPath.row]
            RealmManager.remove(bookmark)
            tableView.deleteRows(at: [indexPath], with: .top)
            tableView.endUpdates()
        }
    }
}

public extension UIViewController {
    @IBAction public func unwindToViewController (_ segue : UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}
