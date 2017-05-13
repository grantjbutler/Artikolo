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
    
}

extension Article: Equatable {
    
    public static func ==(lhs: Article, rhs: Article) -> Bool {
        return lhs.url == rhs.url
    }
    
}
