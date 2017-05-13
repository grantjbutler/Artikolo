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
    
    var urls: Observable<[URL]> { get }
    
    func save(url: URL)
    func reset() throws
    
}

class DataManager {
    
    let backend: DataManagerBackend
    
    var urls: Observable<[URL]> {
        return backend.urls
    }
    
    init(backend: DataManagerBackend) {
        self.backend = backend
    }
    
    func save(url: URL) {
        backend.save(url: url)
    }
    
    func reset() throws {
        try backend.reset()
    }
    
}
