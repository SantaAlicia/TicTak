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
    var winCombination : Set<Int>? {get}
    
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
    var winCombination : Set<Int>?
    
    init() {
        gameBoard.setupInitialPosition()
    }

    func startNewGame() {
        gameBoard.setupInitialPosition()
        currentPlayer = Player.cross
        state = GameState.isStarted
        winCombination = nil
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
            //winCombination = GameResultController.findWinSet()
        } else {
            state = GameState.isProceed
            changeCurrentPlayer()
        }
        return true
    }
}

extension Game {
    func isGameOver() -> Bool {
        gameResult = GameResultController.findWiner()
        if (gameResult == GameWinner.crossWinner) || (gameResult == GameWinner.zeroWinner) {
            return true
        }
        return gameBoard.isFull()
    }
    
    func isCellInsideWinCombination(index : Int) -> Bool {
        if let winC = winCombination {
            let  tmpSet : Set<Int> = [index]
            ////tmpSet.insert(indexPath.row)
            if (tmpSet.isSubset(of: winC)) {
                return true
            }
        }
        return false
    }
    
//    func winSet () -> Set<Int>? {
//        return GameResultController.findWinSet()
//    }
}

extension Game {
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

