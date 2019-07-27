//
//  TicTakTests.swift
//  TicTakTests
//
//  Created by liudmila vladimirova on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import XCTest
@testable import TicTak

class TicTakTests: XCTestCase {
    let size: Int = 3

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
            for j in 0..<size {
                let cell = game.playingField.arr[i][j]
                XCTAssertEqual(cell.isEmpty, true, "Game init wrong")
            }
        }
    }

}
