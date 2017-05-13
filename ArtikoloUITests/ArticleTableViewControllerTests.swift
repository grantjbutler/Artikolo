//
//  ArticleTableViewControllerTests.swift
//  Artikolo
//
//  Created by Grant Butler on 5/13/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import XCTest

class ArticleTableViewControllerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchArguments = ["-ResetDatabase"]
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCanAddAnArticle() {
        let app = XCUIApplication()
        app.navigationBars["NavigationBar"].buttons["AddArticleButton"].tap()
        
        let addUrlAlert = app.alerts["Add URL"]
        addUrlAlert.collectionViews.textFields["URLInputTextField"].typeText("https://zeldathon.net/")
        addUrlAlert.buttons["Add"].tap()
        
        XCTAssertEqual(app.tables.cells.count, 1)
        XCTAssertEqual(app.tables.cells.element(boundBy: 0).staticTexts.element(boundBy: 0).label, "https://zeldathon.net/")
    }
    
}
