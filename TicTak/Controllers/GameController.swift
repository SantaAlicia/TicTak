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

enum GameState {
    case isNotStarted
    case isStarted
    case isProceed
    case isOver
}

class GameController {

    static let shared = GameController()
    let game = Game()
    var currentPlayer : Player = Player.cross
    var state = GameState.isNotStarted
    var gameResult : GameWinner?
    
    init() {
        game.preparationForNewGame()
    }

    func startNewGame() {
        game.preparationForNewGame()
        currentPlayer = Player.cross
        state = GameState.isStarted
    }
    
    func playerDoesTapInCellAtIndex(_ index : Int) -> Bool {
        let cell : Cell = game.cellAtIndex(index)
        
        if !cell.isEmpty {
            return false
        }
        changeCellAtIndexByCurrentPlayer(index)
        if (isGameOver()) {
            state = GameState.isOver
            gameResult = GameResultController.findWiiner()
        } else {
            state = GameState.isProceed
            changeCurrentPlayer()
        }
        return true
    }
    
    func isGameOver() -> Bool {
        gameResult = GameResultController.findWiiner()
        if (gameResult == GameWinner.crossWinner) || (gameResult == GameWinner.zeroWinner) {
            return true
        }
        return game.isGameOver()
    }
}

extension GameController {
    private func changeCellAtIndexByCurrentPlayer(_ atIndex : Int) {
        if (currentPlayer == Player.cross) {
            game.changeCellAtIndex(atIndex, newValue: CrossCell())
        } else {
            game.changeCellAtIndex(atIndex, newValue: ZeroCell())
        }
    }
    
    private func changeCurrentPlayer() {
        currentPlayer = (currentPlayer == Player.cross) ? Player.zero : Player.cross
    }
}

