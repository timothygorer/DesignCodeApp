//
//  Resource.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 15/04/18.
//  Copyright © 2018 Tim Gorer. All rights reserved.
//

import Foundation

struct Response<T : Decodable> : Decodable {
    
    var message : String
    var status : String
    var statusCode : String
    var data : T
}

enum HTTPMethod : String {
    
    case get    = "GET"
    case post   = "POST"
    case delete = "DELETE"
}

protocol Resource {
    
    static var path : String { get }
    static var httpMethod : HTTPMethod { get }
    static var body : Data? { get }
}

extension Resource {
    
    @discardableResult
    static func load<T : Resource & Decodable>(_ completion : @escaping (Response<T>) -> Void) -> URLSessionDataTask {
        
        let url = ContentAPI.baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            guard error == nil, let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .secondsSince1970
                
                let decoded = try decoder.decode(Response<T>.self, from: data)
                DispatchQueue.main.sync { completion(decoded) }
            } catch {
                print(error)
            }
        }
        
        DispatchQueue.global(qos: .background).async { task.resume() }
        
        return task
    }
}
