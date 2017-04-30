//
//  DataManagerTests.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import XCTest
@testable import Artikolo

class DataManagerTests: XCTestCase {
    
    let dataManager = DataManager(backend: ArrayBackend())
    
    override func setUp() {
        super.setUp()
        
        try! dataManager.reset()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testURLCanBeSaved() {
        let url = URL(string: "http://zeldathon.net/")!
        dataManager.save(url: url)
        
        XCTAssertEqual(dataManager.urls, [url])
    }
    
}

class ArrayBackend: DataManagerBackend {
    
    var urls: [URL] = []
    
    func save(url: URL) {
        urls += [url]
    }
    
    func reset() {
        urls = []
    }
    
}
