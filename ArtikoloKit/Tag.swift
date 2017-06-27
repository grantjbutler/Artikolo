//
//  Tag.swift
//  Artikolo
//
//  Created by Grant Butler on 6/26/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import Foundation
import UIKit

public struct Tag {
    
    // sourcery: coreDataIdentifier
    public let name: String
    
    public let color: UIColor
    
    // sourcery: skipEquality
    // sourcery: coreDataRelationship
    public let articles: [Article]
    
    public init(name: String, color: UIColor, articles: [Article]) {
        self.name = name
        self.color = color
        self.articles = articles
    }
    
}

extension Tag: AutoEquatable {}
extension Tag: CoreDataBacked {}
