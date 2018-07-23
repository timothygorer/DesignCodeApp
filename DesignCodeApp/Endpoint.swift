//
//  Endpoint.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 7/22/18.
//  Copyright © 2018 Tim Gorer. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    var path : String { get }
    var httpMethod : HTTPMethod { get }
    var body : Data? { get }
}

fileprivate let baseURL : URL = URL(string: "http://localhost:3000")!

extension Endpoint {
    
    func dataTask(completion : ((Data) -> Void)?) -> URLSessionDataTask {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        let session = URLSession.shared
        
        return session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print(response ?? "Invalid response")
                return
            }
            
            completion?(data)
            DispatchQueue.main.sync { completion?(data) }
        })
    }
}
