//
//  ContentAPI.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 27/03/18.
//  Copyright © 2018 Tim Gorer. All rights reserved.
//

import RealmSwift

struct Content : Decodable {
    var chapters : Array<Chapter>
    var version : Int
    
    enum CodingKeys : String, CodingKey {
        case version
        case chapters = "content"
    }
}

extension Content : Resource {
    
    static var path : String { return "content" }
    static var httpMethod : HTTPMethod { return .get }
    static var body : Data? { return nil }
}

class Chapter : Object, Decodable {
    @objc dynamic var id : String = ""
    @objc dynamic var title : String = ""
    
    var sections : List<Section> = List<Section>()
    
    private enum CodingKeys : String, CodingKey {
        case id, title, sections
    }
    
    override static func primaryKey() -> String? { return "id" }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.init()
        
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        
        let sectionsArray = try container.decode(Array<Section>.self, forKey: .sections)
        
        sections = List<Section>()
        sections.append(objectsIn: sectionsArray)
    }
}

class Section : Object, Decodable {
    
    @objc dynamic var id : String = ""
    @objc dynamic var chapterId : String = ""
    @objc dynamic var order : String = ""
    @objc dynamic var slug : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var caption : String = ""
    @objc dynamic var body : String = ""
    
    @objc dynamic var image : String = ""
    
    var imageURL : URL? { return URL(string: image) }
    
    var parts : List<Part> = List<Part>()
    
    private enum CodingKeys : String, CodingKey {
        case id, title, caption, body, chapterId, order, slug, image
        case parts = "contents"
    }
    
    override static func primaryKey() -> String? { return "id" }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.init()
        
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        caption = try container.decode(String.self, forKey: .caption)
        body = try container.decode(String.self, forKey: .body)
        image = try container.decode(String.self, forKey: .image)
        
        let partsArray = try container.decode(Array<Part>.self, forKey: .parts)
        
        parts = List<Part>()
        parts.append(objectsIn: partsArray)
    }
}

extension List : Decodable {
    public convenience init(from decoder: Decoder) throws {
        self.init()
    }
}

enum PartType : String {
    case text, image, video, code
}

class Part : Object, Decodable {
    
    @objc dynamic var id : String = ""
    @objc dynamic var sectionId : String = ""
    @objc dynamic var order : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var subhead : String = ""
    @objc dynamic var body : String = ""
    
    @objc dynamic var image : String = ""
    
    @objc dynamic var bookmarkId : String = ""
    
    var imageURL : URL? { return URL(string: image) }
    
    @objc dynamic var imageHeight : String = ""
    @objc dynamic var imageWidth : String = ""
    
    override static func primaryKey() -> String? { return "id" }
}

class ContentAPI {
    
    static var shared : ContentAPI = ContentAPI()
    
    lazy var bookmarks : Array<Bookmark> = []
    
    static let baseURL = URL(string: "http://localhost:3000")!
}
