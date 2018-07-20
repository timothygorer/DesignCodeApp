//
//  ContentAPI.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 7/20/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import Foundation

struct Section : Codable {
    var title : String
    var caption : String
    var body : String
    var imageName : String
    var publishDate : Date
    
    enum CodingKeys : String, CodingKey {
        case title, caption, body
        case imageName = "image"
        case publishDate = "publish_date"
    }
}

struct Bookmark : Codable {
    var typeName : String
    var chapterNumber : String
    var sectionTitle : String
    var partHeading : String
    var content : String
    
    enum BookmarkType : String {
        case text, image, video, code
    }
    
    var type : BookmarkType?
    
    enum CodingKeys : String, CodingKey {
        case typeName = "type"
        case chapterNumber = "chapter"
        case sectionTitle = "section"
        case partHeading = "part"
        case content
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        typeName = try values.decode(String.self, forKey: .typeName)
        chapterNumber = try values.decode(String.self, forKey: .chapterNumber)
        sectionTitle = try values.decode(String.self, forKey: .sectionTitle)
        partHeading = try values.decode(String.self, forKey: .partHeading)
        content = try values.decode(String.self, forKey: .content)
        
        type = BookmarkType(rawValue: typeName)
    }
}

class ContentAPI {
    static var shared : ContentAPI = ContentAPI()
    
    // lazy: until you call it, it has no value.
    lazy var sections : Array<Section> = {
        guard let path = Bundle.main.path(forResource: "Sections", ofType: "json") else { return [] }
        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url) else { return [] }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let sections = try decoder.decode(Array<Section>.self, from: data) // decode the json
            return sections
        } catch {
            print(error)
        }
        
        return []
    }()
    
    lazy var bookmarks : Array<Bookmark> = {
        guard let path = Bundle.main.path(forResource: "Bookmarks", ofType: "json") else { return [] }
        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url) else { return [] }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let bookmarks = try decoder.decode(Array<Bookmark>.self, from: data) // decode the json
            return bookmarks
        } catch {
            print(error)
        }
        
        return []
    }()
}
