//
//  TicTakUITests.swift
//  TicTakUITests
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import XCTest

class TicTacUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStartGame() {
        
        let startButton = app.buttons["Start new game"]
        startButton.tap()

        let collectionViewsQuery = XCUIApplication().collectionViews
        XCTAssertEqual(collectionViewsQuery.cells.count, 9, "Count of collection's elemets wrong")
        
    }
}
