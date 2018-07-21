//
//  ContentAPI.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 7/20/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import RealmSwift

class Bookmark : Object, Decodable {
    @objc dynamic var section : Section?
    @objc dynamic var sectionId : String = ""
    
    @objc dynamic var part : Part?
    @objc dynamic var partId : String = ""
}

class Part : Object, Decodable {
    enum PartType : String {
        case text, image, video, code
    }
    
    var type : PartType?
    
    @objc dynamic var id : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var content : String = ""
    @objc dynamic var typeName : String = ""
    
    @objc dynamic var section : Section?
    
    override static func primaryKey() -> String? { return "id" } // by getting the primary key, realm is able to reference the "id" variable using objective c key-value coding.

    enum CodingKeys : String, CodingKey {
        case content, id, title
        case typeName = "type"
    }
}

class Section : Object, Decodable {
    @objc dynamic var id : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var caption : String = ""
    @objc dynamic var body : String = ""
    @objc dynamic var imageName : String = ""
    @objc dynamic var chapterNumber : String = ""
    
    @objc dynamic var publishDate : Date?
    
    var parts : List<Part>? = List<Part>()
    
    enum CodingKeys : String, CodingKey {
        case id, title, caption, body, imageName, chapterNumber, publishDate, parts
    }
    
    override static func primaryKey() -> String? { return "id" } // by getting the primary key, realm is able to reference the "id" variable using objective c key-value coding.
    
    // because we are using a type not defined in Codable and won't be coded from JSON file, let's set an init from decoder:
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        caption = try container.decode(String.self, forKey: .caption)
        body = try container.decode(String.self, forKey: .body)
        imageName = try container.decode(String.self, forKey: .imageName)
        chapterNumber = try container.decode(String.self, forKey: .chapterNumber)
        
        publishDate = try container.decode(Date.self, forKey: .publishDate)
        
        parts = List<Part>()
    }
}

class ContentAPI {
    static var shared : ContentAPI = ContentAPI()
    
    lazy var bookmarks : Array<Bookmark> = {
        return load(into: Array<Bookmark>.self, resource: "Bookmarks") ?? []
    }()
    
    lazy var parts : Array<Part> = {
        return load(into: Array<Part>.self, resource: "Parts") ?? []
    }()
    
    lazy var sections : Array<Section> = {
        return load(into: Array<Section>.self, resource: "Sections") ?? []
    }()
    
    // transforms a resource of a given type into that T type
    func load<T : Decodable>(into swiftType: T.Type, resource : String, ofType type : String = "json") -> T? {
        let path = Bundle.main.path(forResource: resource, ofType: type)
        let url = URL(fileURLWithPath: path!)
        
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        
        return try! decoder.decode(swiftType.self, from : data)
    }
}
