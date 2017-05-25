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
        let article = Article(url: URL(string: "http://zeldathon.net/")!, addedOn: Date(), createdOn: Date())
        
        var articles: [Article] = []
        
        dataManager.articles.subscribe(onNext: {
            articles = $0
        })
        .addDisposableTo(disposeBag)
        
        dataManager.save(article: article)
        
        XCTAssertEqual(articles, [article])
    }
    
    func testDataManagerIsReset() {
        let article = Article(url: URL(string: "http://zeldathon.net/")!, addedOn: Date(), createdOn: Date())
        
        var articles: [Article] = []
        
        dataManager.articles.subscribe(onNext: {
            articles = $0
        })
        .addDisposableTo(disposeBag)
        
        dataManager.save(article: article)
        try! dataManager.reset()
        
        XCTAssertEqual(articles, [])
    }
    
}

class ArrayBackend: DataManagerBackend {
    
    private let articlesVariable = Variable<[Article]>([])
    let articles: Observable<[Article]>
    
    init() {
        articles = articlesVariable.asObservable()
    }
    
    func save(article: Article) {
        var mutableArticles = articlesVariable.value
        mutableArticles.append(article)
        articlesVariable.value = mutableArticles
    }
    
    func reset() {
        articlesVariable.value = []
    }
    
}
