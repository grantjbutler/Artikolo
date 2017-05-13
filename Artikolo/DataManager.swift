//
//  DataManager.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import Foundation
import RxSwift

protocol DataManagerBackend {
    
    var articles: Observable<[Article]> { get }
    
    func save(article: Article)
    func reset() throws
    
}

class DataManager {
    
    let backend: DataManagerBackend
    
    var articles: Observable<[Article]> {
        return backend.articles
    }
    
    init(backend: DataManagerBackend) {
        self.backend = backend
    }
    
    func save(article: Article) {
        backend.save(article: article)
    }
    
    func reset() throws {
        try backend.reset()
    }
    
}
