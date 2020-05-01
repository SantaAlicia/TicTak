//
//  GameController.swift
//  TicTak
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import Foundation
import AVFoundation

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
    var playVSComputer : Bool { get }
    
    func startNewGame()
    func playerMakesTurnAtIndex(_ index : Int) -> Bool
    func isGameOver() -> Bool
}

class Game : GameProtocol {

    static let shared = Game()
    let gameBoard = GameBoard.shared
    var currentPlayer : Player = Player.cross
    var state = GameState.isNotStarted
    var gameResult : GameWinner?
    var winCombination : Set<Int>?
    var playVSComputer = false
    
    var needPlaySoundGameOver = false
    var needPlaySoundOneStep = false
    var currentPosition : Int = -1
    
    init() {
        gameBoard.setupInitialPosition()
    }

    func startNewGame() {
        gameBoard.setupInitialPosition()
        currentPlayer = Player.cross
        state = GameState.isStarted
        winCombination = nil
    }
    
    func playerMakesTurnAtIndex(_ index : Int) -> Bool {
        let cell : Cell = gameBoard.cellAtIndex(index)
        currentPosition = -1
        
        if !cell.isEmpty {
            return false
        }
        if (isGameOver()) {
            return false
        }
        changeCellAtIndexByCurrentPlayer(index)
        if (isGameOver()) {
            state = GameState.isOver
        } else {
            state = GameState.isProceed
            changeCurrentPlayer()
        }
        currentPosition = index
        return true
    }
    
    func isGameOver() -> Bool {
        gameResult = GameResultController.findWiner()
        if (gameResult == GameWinner.crossWinner) || (gameResult == GameWinner.zeroWinner) {
            if needPlaySoundGameOver {
                GameEffectsController.shared.playSoundGameOver()
            }
            return true
        }
        return gameBoard.isFull()
    }
}

extension Game {
    func isCellInsideWinCombination(index : Int) -> Bool {
        if let winC = winCombination {
            let  tmpSet : Set<Int> = [index]
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
        if needPlaySoundOneStep {
            GameEffectsController.shared.playSoundOneStep()
        }
    }
    
    private func changeCurrentPlayer() {
        currentPlayer = (currentPlayer == Player.cross) ? Player.zero : Player.cross
    }
}


