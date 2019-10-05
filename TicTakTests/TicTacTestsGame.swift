//
//  TicTacTests.swift
//  TicTakTests
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import XCTest
@testable import TicTak

class TicTacTestsGame: XCTestCase {
    
    let game = Game.shared
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsGameStarted() {
        game.startNewGame()
        var result = true
        for i in 0..<GameConstants.gameDimension  {
            let cell : Cell = game.gameBoard.cellAtIndex(i)
            result = cell.isEmpty && result
        }
        XCTAssertEqual(result, true, "testIsGameStarted is Failed")
    }
    
    func testCrossHasFirsTurm() {
        game.startNewGame()
        let res = game.playerMakesMoveAtIndex(3)
        XCTAssertTrue(res)
        let cell = game.gameBoard.cellAtIndex(3)
         XCTAssertEqual(cell.type, CellType.cross, "testCrossHasFirsTurm is Failed")
    }
    
     func testPlayerChangeCellAtIndex() {
        game.startNewGame()
        game.gameBoard.changeCellAtIndex(4, newValue: CrossCell())
        game.currentPlayer = Player.zero
        let res = game.playerMakesMoveAtIndex(4)
        XCTAssertFalse(res)
        
        let cell = game.gameBoard.cellAtIndex(4)
        //cell does not have to be changed
        XCTAssertEqual(cell.type, CellType.cross, "testPlayerChangeCellBy is Failed")
    }
    
    func testZeroPlayerplayerMakesMoveAtIndex() {
        game.startNewGame()
        game.currentPlayer = Player.zero
        let res = game.playerMakesMoveAtIndex(5)
        
        XCTAssertTrue(res)
        let cell = game.gameBoard.cellAtIndex(5)
        XCTAssertEqual(cell.type, CellType.zero, "testCrossPlayerplayerMakesMoveAtIndex is Failed")
    }
    
    func testCrossPlayerplayerMakesMoveAtIndex() {
        game.startNewGame()
        game.currentPlayer = Player.cross
        let res = game.playerMakesMoveAtIndex(4)
    
        XCTAssertTrue(res)
        let cell : Cell = game.gameBoard.cellAtIndex(4)
        XCTAssertEqual(cell.type, CellType.cross, "testCrossPlayerplayerMakesMoveAtIndex is Failed")
    }
    
    func testIsGameOver() {
        game.startNewGame()
        for i in 0..<GameConstants.gameDimension {
            game.gameBoard.changeCellAtIndex(i, newValue: CrossCell())
        }
        let res = game.isGameOver()
        XCTAssertEqual(res, true, "testIsGameOver is Failed")
    }
    
    func testPlayerMakesMoveAtIndex() {
        game.startNewGame()
        for i in 0..<GameConstants.gameDimension {
            game.gameBoard.changeCellAtIndex(i, newValue: CrossCell())
        }
        let res = game.playerMakesMoveAtIndex(7)
        XCTAssertEqual(res, false, "testIsGameOver is Failed")
    }
    
    func testGameStarted() {
        game.startNewGame()
        for i in 0..<GameConstants.gameDimension {
            let cell = game.gameBoard.cellAtIndex(i)
            XCTAssertEqual(cell.isEmpty, true, "startNewGame works wrong")
        }
    }
    
    func testFundAllCrossCell() {
        game.startNewGame()
        for i in 0..<GameConstants.gameDimension {
            game.gameBoard.changeCellAtIndex(i, newValue: CrossCell())
        }
        guard let set = game.gameBoard.findAllCellWithCross() else {
            XCTFail("testFundAllCrossCell is Failed")
            return
        }
        XCTAssertEqual(set.count, GameConstants.gameDimension, "testFundAllCrossCell is Failed")
    }
    
    func testFundNineZeroCell() {
        game.startNewGame()
        for i in 0..<GameConstants.gameDimension {
            game.gameBoard.changeCellAtIndex(i, newValue: ZeroCell())
        }
        guard let set = game.gameBoard.findAllCellWithZero() else {
            XCTFail("fintAllCellWithZero is Failed")
            return
        }
        XCTAssertEqual(set.count, GameConstants.gameDimension, "testFundNineZeroCell is Failed")
    }
    
    func testFundOneZeroCell() {
        game.startNewGame()
        for i in 0..<GameConstants.gameDimension {
            if (i == 7) {
                game.gameBoard.changeCellAtIndex(i, newValue: ZeroCell())
            }
        }
        guard let set = game.gameBoard.findAllCellWithZero() else {
            XCTFail("fintAllCellWithZero is Failed")
            return
        }
        XCTAssertEqual(set.count, 1, "testFundOneZeroCell is Failed")
        let cell = game.gameBoard.cellAtIndex(7)
        XCTAssertEqual(cell.type, CellType.zero, "testFundOneZeroCell is Failed")
    }
    
    func testIfCrossWin() {
        game.gameBoard.changeCellAtIndex(0, newValue: CrossCell())
        game.gameBoard.changeCellAtIndex(1, newValue: EmptyCell())
        game.gameBoard.changeCellAtIndex(2, newValue: ZeroCell())
        game.gameBoard.changeCellAtIndex(3, newValue: CrossCell())
        game.gameBoard.changeCellAtIndex(4, newValue: EmptyCell())
        game.gameBoard.changeCellAtIndex(5, newValue: ZeroCell())
        game.gameBoard.changeCellAtIndex(6, newValue: CrossCell())
        game.gameBoard.changeCellAtIndex(7, newValue: EmptyCell())
        game.gameBoard.changeCellAtIndex(8, newValue: EmptyCell())
        let res = GameResultController.findWiner()
        XCTAssertEqual(res, GameWinner.crossWinner, "testIfCrossWin works wrong")
    }
    
    func testIfZeroWin() {
        game.gameBoard.changeCellAtIndex(0, newValue: CrossCell())
        game.gameBoard.changeCellAtIndex(1, newValue: ZeroCell())
        game.gameBoard.changeCellAtIndex(2, newValue: CrossCell())
        game.gameBoard.changeCellAtIndex(3, newValue: EmptyCell())
        game.gameBoard.changeCellAtIndex(4, newValue: ZeroCell())
        game.gameBoard.changeCellAtIndex(5, newValue: EmptyCell())
        game.gameBoard.changeCellAtIndex(6, newValue: CrossCell())
        game.gameBoard.changeCellAtIndex(7, newValue: ZeroCell())
        game.gameBoard.changeCellAtIndex(8, newValue: EmptyCell())
        let res = GameResultController.findWiner()
        XCTAssertEqual(res, GameWinner.zeroWinner, "testIfZeroWin works wrong")
    }
    
    func testIsDraw() {
        game.gameBoard.changeCellAtIndex(0, newValue: CrossCell())
        game.gameBoard.changeCellAtIndex(1, newValue: ZeroCell())
        game.gameBoard.changeCellAtIndex(2, newValue: CrossCell())
        game.gameBoard.changeCellAtIndex(3, newValue: CrossCell())
        game.gameBoard.changeCellAtIndex(4, newValue: CrossCell())
        game.gameBoard.changeCellAtIndex(5, newValue: ZeroCell())
        game.gameBoard.changeCellAtIndex(6, newValue: ZeroCell())
        game.gameBoard.changeCellAtIndex(7, newValue: CrossCell())
        game.gameBoard.changeCellAtIndex(8, newValue: ZeroCell())
        let res = GameResultController.findWiner()
        XCTAssertEqual(res, GameWinner.draw, "testIfZeroNotWin works wrong")
    }
}
