//
//  GameController.swift
//  TicTak
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import Foundation

enum Player {
    case cross
    case zero
}

class GameController {

    static let shared = GameController()
    let game = Game.shared
    var currentPlayer : Player = Player.cross
    
    init() {
        game.preparationForNewGame()
    }

    func startNewGame() {
        game.preparationForNewGame()
        currentPlayer = Player.cross
    }
    
    func makeNextTurn() {
        if currentPlayer == Player.cross {
            currentPlayer = Player.zero
        } else {
            currentPlayer = Player.cross
        }
    }
    
    func typeOfCellInPosition(index : Int) -> CellType {
        return game.cellAtIndex(atIndex: index).type
    }
    
    func playerChangedCellBy(index : Int) -> Bool {
        let cell : Cell = game.cellAtIndex(atIndex: index)
        if !cell.isEmpty {
            return false
        }
        if (currentPlayer == Player.cross) {
            game.changeCellAtIndex(atIndex: index, newValue: CrossCell())
        } else {
            game.changeCellAtIndex(atIndex: index, newValue: ZeroCell())
        }
        makeNextTurn()
        return true
    }
    
    func isGameOver() -> Bool {
        return game.isGameOver()
    }
    
    func textAboutCurrentPlayer() -> String? {
        if (isGameOver()) {
            return nil
        }
        if (game.isGameJustStarted()) {
            return "First is Turn of Player \"Cross\""
        }
        switch currentPlayer {
        case Player.cross:
           return "Turn of Player \"Cross\""
            
        case Player.zero:
            return "Turn of Player \"Zero\""
        }
    }
    
    func textGameOver() -> String? {
        var result : String?
        if (isGameOver()) {
            result = "Game is Over!"
        }
        return result
    }
    
}
