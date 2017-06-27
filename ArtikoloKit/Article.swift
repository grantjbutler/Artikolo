//
//  Article.swift
//  Artikolo
//
//  Created by Grant Butler on 5/13/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import Foundation

public struct Article {
    
    // sourcery: coreDataIdentifier
    public let url: URL
    
    // sourcery: skipEquality
    public let addedOn: Date
    
    // sourcery: skipEquality
    public let createdOn: Date
    
    // sourcery: skipEquality
    // sourcery: coreDataRelationship
    public let tags: [Tag]
    
    public init(url: URL, addedOn: Date, createdOn: Date, tags: [Tag]) {
        self.url = url
        self.addedOn = addedOn
        self.createdOn = createdOn
        self.tags = tags
    }
}

extension Article: AutoEquatable {}
extension Article: CoreDataBacked {}
