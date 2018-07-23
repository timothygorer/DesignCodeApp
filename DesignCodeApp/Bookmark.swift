//
//  Bookmark.swift
//  Ambience
//
//  Created by Tim Gorer on 7/22/18.
//

import RealmSwift

class Bookmark : Object, Codable {
    
    @objc dynamic var id : String = ""
    
    override static func primaryKey() -> String? { return "id" }
}

enum Bookmarks {
    
    case all
    case create(Bookmark)
    case remove(Bookmark)
}

extension Bookmarks : Endpoint {
    
    var path : String {
        switch self {
        case .all, .create: return "bookmarks"
        case .remove(let bookmark): return "bookmarks/\(bookmark.id)"
        }
    }
    
    var httpMethod : HTTPMethod {
        switch self {
        case .all: return .get
        case .create: return .post
        case .remove: return .delete
        }
    }
    
    var body : Data? {
        switch self {
        case .all, .remove: return nil
        case .create(let bookmark):
            let encoder = JSONEncoder()
            return try? encoder.encode(bookmark)
        }
    }
}
