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
    
    func makeNextMove() {
        if currentPlayer == Player.cross {
            currentPlayer = Player.zero
        } else {
            currentPlayer = Player.cross
        }
    }
    
    func typeOfCellinPosition(index : Int) -> CellType {
        return game.playingField.arr[index].type
    }
    
    func playerChangeCellBy(index : Int) -> Bool {
        let cell : Cell = game.playingField.arr[index]
        if !cell.isEmpty {
            return false
        }
        if (currentPlayer == Player.cross) {
            game.changeItem(atIndex: index, newValue: CrossCell())
        } else {
            game.changeItem(atIndex: index, newValue: ZeroCell())
        }
        makeNextMove()
        return true
    }
}
