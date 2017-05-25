//
//  DataManager.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import Foundation
import RxSwift

public protocol DataManagerBackend {
    
    var articles: Observable<[Article]> { get }
    
    func save(article: Article)
    func reset() throws
    
}

public class DataManager {
    
    public let backend: DataManagerBackend
    
    public var articles: Observable<[Article]> {
        return backend.articles
    }
    
    public init(backend: DataManagerBackend) {
        self.backend = backend
    }
    
    public func save(article: Article) {
        backend.save(article: article)
    }
    
    public func reset() throws {
        try backend.reset()
    }
    
}
