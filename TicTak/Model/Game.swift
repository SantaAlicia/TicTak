//
//  Game.swift
//  TicTak
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

class Game {
    let dimension = 3
    let playingField : Field = Field()
    
    static let shared = Game()

    init () {
        playingField.arr = Array(repeating: Array(repeating: Cell(), count: 3), count: 3)
    }
    
    func startGame() {
        for i in 0..<dimension {
            for j in 0..<dimension {
                let cell : Cell = playingField.arr[i][j]
                cell.isEmpty = true
            }
        }
    }
    
    func isGameOver() -> Bool {
        var result = false
        for i in 0..<dimension {
            for j in 0..<dimension {
                let cell : Cell = playingField.arr[i][j]
                result = cell.isEmpty && result
            }
        }
        return result
    }
    
}

