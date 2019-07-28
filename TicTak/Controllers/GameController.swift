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
        game.startGame()
    }

    func startNewGame() {
        game.startGame()
        currentPlayer = Player.cross
    }
    
    func makeNextMove() {
        if currentPlayer == Player.cross {
            currentPlayer = Player.zero
        } else {
            currentPlayer = Player.cross
        }
    }
}
