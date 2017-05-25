//
//  CommandRegistryTests.swift
//  Artikolo
//
//  Created by Grant Butler on 5/24/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import XCTest
@testable import Artikolo

class CommandRegistryTests: XCTestCase {
    
    func testCanRunBasicCommands() {
        let callbackExpectation = expectation(description: "Did Call Test Command Callback")
        
        let registry = CommandRegistry()
        registry.register("Test", .basic({
            callbackExpectation.fulfill()
        }))
        try! registry.handle(arguments: [
            "-Test"
        ])
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testCallbackIsNotCalledIfNotMatched() {
        let registry = CommandRegistry()
        registry.register("ShouldNotHappen", .basic({
            XCTFail("Callback called when it should not have been called.")
        }))
        try! registry.handle(arguments: [
            "-Test"
        ])
    }
    
    func testCanRunInputCommands() {
        let callbackExpectation = expectation(description: "Did Call Test Command Callback")
        
        let registry = CommandRegistry()
        registry.register("Test", .input({ name in
            callbackExpectation.fulfill()
            
            XCTAssertEqual(name, "Name")
        }))
        try! registry.handle(arguments: [
            "-Test=Name"
        ])
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testErrorsOnNoInputWhenExpectingInput() {
        let registry = CommandRegistry()
        registry.register("Test", .input({ _ in
            XCTFail("Callback called when it should not have been called.")
        }))
        
        do {
            try registry.handle(arguments: [
                "-Test"
            ])
            
            XCTFail("Error for missing input not thrown.")
        }
        catch let error as CommandRegistry.Error {
            XCTAssertEqual(error, CommandRegistry.Error.missingInput)
        }
        catch {
            XCTFail("Unknown error caught: \(error)")
        }
    }
    
}
