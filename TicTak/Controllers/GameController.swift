//
//  GameController.swift
//  TicTak
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import Foundation

class GameController {
    
    static let shared = GameController()
    let game = Game.shared
    
    init() {
    }

    func startNewGame() {
        game.startGame()
    }
}
