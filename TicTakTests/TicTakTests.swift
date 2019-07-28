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

    func testPreparationForNewGame() {
        let game = Game()
        game.changeItem(atIndex: 4, newValue: CrossCell())
        game.preparationForNewGame()
        
        for i in 0..<size {
            let cell = game.playingField.arr[i]
            XCTAssertEqual(cell.isEmpty, true, "preparationForNewGame works wrong")
        }
    }
    
    func testGameStarted() {
        let gameController = GameController.shared
        gameController.startNewGame()
        
        for i in 0..<size {
            let cell = gameController.game.playingField.arr[i]
            XCTAssertEqual(cell.isEmpty, true, "startNewGame works wrong")
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
    
    //func testplayerChangeCellBy() {
    func testpFirsMove() {
        let gameController = GameController.shared
        gameController.startNewGame()
        gameController.playerChangeCellBy(index: 3)
        
        let cell : Cell = gameController.game.playingField.arr[3]
         XCTAssertEqual(cell.type, CellType.cross, "testpFirsMove is Failed")
    }
    
     func testplayerChangeCellBy() {
        let gameController = GameController.shared
        gameController.startNewGame()
        gameController.game.changeItem(atIndex: 4, newValue: CrossCell())
        gameController.currentPlayer = Player.zero
        gameController.playerChangeCellBy(index: 4)
        
        let cell : Cell = gameController.game.playingField.arr[4]
        //cell does not have to be changed
        XCTAssertEqual(cell.type, CellType.cross, "testplayerChangeCellBy is Failed")
    }
    
    func testZeroPlayerChangeCellBy() {
        let gameController = GameController.shared
        gameController.startNewGame()
        gameController.currentPlayer = Player.zero
        gameController.playerChangeCellBy(index: 5)
        
        let cell : Cell = gameController.game.playingField.arr[5]
        XCTAssertEqual(cell.type, CellType.zero, "testZeroPlayerChangeCellBy is Failed")
    }
    
    func testCrossPlayerChangeCellBy() {
        let gameController = GameController.shared
        gameController.startNewGame()
        gameController.currentPlayer = Player.cross
        gameController.playerChangeCellBy(index: 4)
    
    let cell : Cell = gameController.game.playingField.arr[4]
    XCTAssertEqual(cell.type, CellType.cross, "testCrossPlayerChangeCellBy is Failed")
    }
}
