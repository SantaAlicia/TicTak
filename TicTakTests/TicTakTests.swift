//
//  TicTakTests.swift
//  TicTakTests
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import XCTest
@testable import TicTak

class TicTakTests: XCTestCase {
    let size: Int = 9

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()

    }
    func testGameInitialization() {
        let game = Game()
        
        for i in 0..<size {
            let cell = game.playingField.arr[i]
            XCTAssertEqual(cell.isEmpty, true, "Game init wrong")
        }
    }


    func testGameStarted() {
        let game = Game()
        game.changeItem(atIndex: 4, newValue: CrossCell())
        game.preparationForNewGame()
        
        for i in 0..<size {
            let cell = game.playingField.arr[i]
            XCTAssertEqual(cell.isEmpty, true, "ChangeStarted works wrong")
        }
    }
    
    func testChangeItems() {
        let game = Game()
        game.changeItem(atIndex: 4, newValue: CrossCell())
        
        for i in 0..<size {
            let cell = game.playingField.arr[i]
            if i == 4 {
                XCTAssertEqual(cell.type, CellType.cross, "ChangeItems works wrong")}
        }
    }
}
