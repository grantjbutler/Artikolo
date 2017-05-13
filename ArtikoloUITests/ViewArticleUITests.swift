//
//  ViewArticleUITests.swift
//  Artikolo
//
//  Created by Grant Butler on 5/13/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import XCTest

class ViewArticleUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchArguments = ["-ResetDatabase", "-AddArticle={\"url\":\"https://zeldathon.net/\"}"]
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.tables.staticTexts["https://zeldathon.net/"].tap()
        
        XCTAssertEqual(app.webViews.count, 1)

        // This assertion is currently not possible. There appears to not be a way to get the URL for a web view using these testing APIs. This should be re-evaluated in the future when new versions of iOS come out to see if this assertion can be re-enabled.
        // XCTAssertEqual(app.webViews.element(boundBy: 0).value as! String?, "https://zeldathon.net/")
        
    }
    
}
