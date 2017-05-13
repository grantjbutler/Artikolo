//
//  Article.swift
//  Artikolo
//
//  Created by Grant Butler on 5/13/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import Foundation

struct Article {
    
    let url: URL
    let addedOn: Date
    let createdOn: Date
    
}

extension Article: Equatable {
    
    public static func ==(lhs: Article, rhs: Article) -> Bool {
        return lhs.url == rhs.url
    }
    
}

enum JSONError: Error {
    
    case invalidValue(keypath: String)
    case incorrectType(keyPath: String)
    
}

extension Article {
    
    static func parse(JSON: [String: Any]) throws -> Article {
        guard let urlString = JSON["url"] as? String else { throw JSONError.invalidValue(keypath: "url") }
        guard let url = URL(string: urlString) else { throw JSONError.incorrectType(keyPath: "url") }
        
        return Article(url: url, addedOn: Date(), createdOn: Date())
    }
    
}
