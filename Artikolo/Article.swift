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
    
    // sourcery: skipEquality
    let addedOn: Date
    
    // sourcery: skipEquality
    let createdOn: Date
    
}

extension Article: AutoEquatable {}

extension Article {
    
    static func parse(JSON: [String: Any]) throws -> Article {
        guard let urlString = JSON["url"] as? String else { throw JSONError.invalidValue(keypath: "url") }
        guard let url = URL(string: urlString) else { throw JSONError.incorrectType(keyPath: "url") }
        
        return Article(url: url, addedOn: Date(), createdOn: Date())
    }
    
}
