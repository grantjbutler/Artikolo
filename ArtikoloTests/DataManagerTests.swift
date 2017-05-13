//
//  DataManagerTests.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import XCTest
@testable import Artikolo
import RxSwift

class DataManagerTests: XCTestCase {
    
    let dataManager = DataManager(backend: ArrayBackend())
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        
        try! dataManager.reset()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testURLCanBeSaved() {
        let url = URL(string: "http://zeldathon.net/")!
        var urls: [URL] = []
        
        dataManager.urls.subscribe(onNext: {
            urls = $0
        })
        .addDisposableTo(disposeBag)
        
        dataManager.save(url: url)
        
        XCTAssertEqual(urls, [url])
    }
    
}

class ArrayBackend: DataManagerBackend {
    
    private let urlsVariable = Variable<[URL]>([])
    let urls: Observable<[URL]>
    
    init() {
        urls = urlsVariable.asObservable()
    }
    
    func save(url: URL) {
        var mutableUrls = urlsVariable.value
        mutableUrls.append(url)
        urlsVariable.value = mutableUrls
    }
    
    func reset() {
        urlsVariable.value = []
    }
    
}
