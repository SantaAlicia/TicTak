//
//  TicTcTestGame.swift
//  Tic-Tac-ToeTests
//
//  Created by SantaAlicia on 28/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import XCTest
@testable import TicTak

class TicTcTestGame: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGameBoardInitialization() {
        let gameBoard = GameBoard()
        for i in 0..<GameConstants.gameDimension {
            let cell = gameBoard.cellAtIndex(i)
            XCTAssertEqual(cell.isEmpty, true, "gameBoard init wrong")
        }
    }
    
    func testSetupInitialPosition() {
        let gameBoard = GameBoard()
        gameBoard.changeCellAtIndex(4, newValue: CrossCell())
        gameBoard.setupInitialPosition()
    
        for i in 0..<GameConstants.gameDimension {
            let cell = gameBoard.cellAtIndex(i)
            XCTAssertEqual(cell.isEmpty, true, "testSetupInitialPosition works wrong")
        }
    }
}
