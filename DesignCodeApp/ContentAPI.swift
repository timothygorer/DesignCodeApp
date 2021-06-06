//
//  ContentAPI.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 7/20/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import Foundation

struct BookmarkCodable : Codable {
    var sectionId: String
    var partId: String
}

struct SectionCodable : Codable {
    
    var id : String
    var chapterNumber : String
    
    var title : String
    var caption : String
    var body : String
    var imageName : String
    var publishDate : Date
}

struct PartCodable : Codable {
    
    enum PartType : String {
        case text, image, video, code
    }
    
    var type : PartType?
    
    var id : String
    
    var typeName : String
    var title : String
    var content : String
    
    enum CodingKeys : String, CodingKey {
        case content, id, title
        case typeName = "type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        typeName = try values.decode(String.self, forKey: .typeName)
        title = try values.decode(String.self, forKey: .title)
        content = try values.decode(String.self, forKey: .content)
        
        type = PartType(rawValue: typeName)
    }
}

class ContentAPI {
    static var shared : ContentAPI = ContentAPI()
    
    func load<T: Codable>(into swiftType : T.Type, resource : String, ofType type : String = "json") -> T? {
        
        let path = Bundle.main.path(forResource: resource, ofType: type)
        let url = URL(fileURLWithPath: path!)
        
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        
        return try! decoder.decode(swiftType.self, from: data)
    }
    
    lazy var bookmarks : Array<BookmarkCodable> = {
        return load(into: Array<BookmarkCodable>.self, resource: "Bookmarks") ?? []
    }()
    
    lazy var sections : Array<SectionCodable> = {
        return load(into: Array<SectionCodable>.self, resource: "Sections") ?? []
    }()
    
    lazy var parts : Array<PartCodable> = {
        return load(into: Array<PartCodable>.self, resource: "Parts") ?? []
    }()
}
