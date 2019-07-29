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
    //let game = Game.shared
    let game = Game()
    var currentPlayer : Player = Player.cross
    
    init() {
        game.preparationForNewGame()
    }

    func startNewGame() {
        game.preparationForNewGame()
        currentPlayer = Player.cross
    }
    
    func makeNextTurn() {
        currentPlayer = (currentPlayer == Player.cross) ? Player.zero : Player.cross
    }
//
//    func typeOfCellAtIndex(index : Int) -> CellType {
//        return game.cellAtIndex(index).type
//    }
    
    func playerDoesTapInCellAtIndex(_ index : Int) -> Bool {
        let cell : Cell = game.cellAtIndex(index)
        
        if !cell.isEmpty {
            return false
        }
        changeCellAtIndexByCurrentPlayer(index)
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
extension GameController {
    private func changeCellAtIndexByCurrentPlayer(_ atIndex : Int) {
        if (currentPlayer == Player.cross) {
            game.changeCellAtIndex(atIndex, newValue: CrossCell())
        } else {
            game.changeCellAtIndex(atIndex, newValue: ZeroCell())
        }
    }
}

