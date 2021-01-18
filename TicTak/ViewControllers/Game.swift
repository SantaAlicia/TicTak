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

protocol GameProtocol {
    var gameResult : GameWinner? { get }
    var currentPlayer : Player { get }
    var state : GameState { get }
    func startNewGame()
    func playerMakesMoveAtIndex(_ index : Int) -> Bool
    func isGameOver() -> Bool
}

class Game : GameProtocol {

    static let shared = Game()
    let gameBoard = GameBoard()
    var currentPlayer : Player = Player.cross
    var state = GameState.isNotStarted
    var gameResult : GameWinner?
    
    init() {
        gameBoard.setupInitialPosition()
    }

    func startNewGame() {
        gameBoard.setupInitialPosition()
        currentPlayer = Player.cross
        state = GameState.isStarted
    }
    
    func playerMakesMoveAtIndex(_ index : Int) -> Bool {
        let cell : Cell = gameBoard.cellAtIndex(index)
        
        if !cell.isEmpty {
            return false
        }
        if (isGameOver()) {
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
}

extension Game {
    func isGameOver() -> Bool {
        gameResult = GameResultController.findWiiner()
        if (gameResult == GameWinner.crossWinner) || (gameResult == GameWinner.zeroWinner) {
            return true
        }
        return gameBoard.isFull()
    }
    private func changeCellAtIndexByCurrentPlayer(_ atIndex : Int) {
        if (currentPlayer == Player.cross) {
            gameBoard.changeCellAtIndex(atIndex, newValue: CrossCell())
        } else {
            gameBoard.changeCellAtIndex(atIndex, newValue: ZeroCell())
        }
    }
    
    private func changeCurrentPlayer() {
        currentPlayer = (currentPlayer == Player.cross) ? Player.zero : Player.cross
    }
}

