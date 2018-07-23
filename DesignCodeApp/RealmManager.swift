//
//  RealmManager.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 7/21/18.
//  Copyright © 2018 Tim Gorer. All rights reserved.
//

import RealmSwift

class RealmManager {
    
    static var realm = try! Realm()
    
    static var bookmarks : Results<Bookmark> { return realm.objects(Bookmark.self) }

    static var sections : Results<Section> { return realm.objects(Section.self) }
    
    class func chapter(withId chapterId : String) -> Chapter? {
        
        return realm
            .objects(Chapter.self)
            .filter("id = %@", chapterId)
            .first
    }

    class func remove(_ object : Bookmark) {
        
        try! realm.write { realm.delete(object) }
    }
    
    class func add(_ object : Bookmark) {
        
        try! realm.write { realm.add(object) }
    }
    
    class func section(for part : Part) -> Section? {
        return realm
            .objects(Section.self)
            .filter("id = %@", part.sectionId)
            .first
    }
    
    class func part(for bookmark : Bookmark) -> Part? {
        return realm
            .objects(Part.self)
            .filter("bookmarkId = %@", bookmark.id)
            .first
    }
    
    class func bookmark(for part : Part) -> Bookmark? {
        return realm
            .objects(Bookmark.self)
            .filter("id = %@", part.bookmarkId)
            .first
    }
    
    class func updateContent () {
        
        Bookmarks.all.dataTask { (data) in
            let decoder = JSONDecoder()
            do {
                let bookmarks = try decoder.decode(Array<Bookmark>.self, from: data)
                try realm.write {
                    realm.add(bookmarks, update : true)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
        Content.load { (response : Response<Content>) in
            
            try! realm.write { realm.add(response.data.chapters, update: true) }
        }
    }
}
