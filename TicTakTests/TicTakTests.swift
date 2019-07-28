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
        
        for i in 0..<GameConstants.gameDimension {
            let cell = game.valueForCell(atIndex: i)
            XCTAssertEqual(cell.isEmpty, true, "Game init wrong")
        }
    }

    func testPreparationForNewGame() {
        let game = Game()
        game.changeOneCell(atIndex: 4, newValue: CrossCell())
        game.preparationForNewGame()
        
        for i in 0..<GameConstants.gameDimension {
            let cell = game.valueForCell(atIndex: i)
            XCTAssertEqual(cell.isEmpty, true, "preparationForNewGame works wrong")
        }
    }
    
    func testGameStarted() {
        let gameController = GameController.shared
        gameController.startNewGame()
        
        for i in 0..<GameConstants.gameDimension {
            let cell = gameController.game.valueForCell(atIndex: i)
            XCTAssertEqual(cell.isEmpty, true, "startNewGame works wrong")
        }
        let text = gameController.textGameOver()
        XCTAssertEqual(text, nil, "testIsGameOver is Failed")
    }
    
    func testChangeItems() {
        let game = Game()
        game.changeOneCell(atIndex: 4, newValue: CrossCell())
        
        for i in 0..<GameConstants.gameDimension {
            let cell = game.valueForCell(atIndex: i)
            if i == 4 {
                XCTAssertEqual(cell.type, CellType.cross, "ChangeItems works wrong")}
        }
    }
    
    func testFirsTurm() {
        let gameController = GameController.shared
        gameController.startNewGame()
        let res : Bool = gameController.playerChangeCellBy(index: 3)
        XCTAssertTrue(res)
        let cell = gameController.game.valueForCell(atIndex: 3)
         XCTAssertEqual(cell.type, CellType.cross, "testFirsTurm is Failed")
    }
    
     func testPlayerChangeCellBy() {
        let gameController = GameController.shared
        gameController.startNewGame()
        gameController.game.changeOneCell(atIndex: 4, newValue: CrossCell())
        gameController.currentPlayer = Player.zero
        let res : Bool = gameController.playerChangeCellBy(index: 4)
        XCTAssertFalse(res)
        
        let cell = gameController.game.valueForCell(atIndex: 4)
        //cell does not have to be changed
        XCTAssertEqual(cell.type, CellType.cross, "testPlayerChangeCellBy is Failed")
    }
    
    func testZeroPlayerChangeCellBy() {
        let gameController = GameController.shared
        gameController.startNewGame()
        gameController.currentPlayer = Player.zero
        let res : Bool = gameController.playerChangeCellBy(index: 5)
        
        XCTAssertTrue(res)
        let cell = gameController.game.valueForCell(atIndex: 5)
        XCTAssertEqual(cell.type, CellType.zero, "testZeroPlayerChangeCellBy is Failed")
    }
    
    func testCrossPlayerChangeCellBy() {
        let gameController = GameController.shared
        gameController.startNewGame()
        gameController.currentPlayer = Player.cross
        let res : Bool = gameController.playerChangeCellBy(index: 4)
    
        XCTAssertTrue(res)
        let cell : Cell = gameController.game.valueForCell(atIndex: 4)
        XCTAssertEqual(cell.type, CellType.cross, "testCrossPlayerChangeCellBy is Failed")
        
        let text = gameController.textGameOver()
        XCTAssertEqual(text, nil, "testCrossPlayerChangeCellBy is Failed")
        let textCurrenPlayer = gameController.textAboutCurrentPlayer()
        XCTAssertNotEqual(textCurrenPlayer, nil, "testCrossPlayerChangeCellBy is Failed")
    }
    
    func testIsGameOver() {
        let gameController = GameController.shared
        for i in 0..<GameConstants.gameDimension {
            gameController.game.changeOneCell(atIndex: i, newValue: CrossCell())
        }
        let res : Bool = gameController.isGameOver()
        XCTAssertEqual(res, true, "testIsGameOver is Failed")
        
        let text = gameController.textGameOver()
        XCTAssertNotEqual(text, nil, "testIsGameOver is Failed")
        
        
    }
}
