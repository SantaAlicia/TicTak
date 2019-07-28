//
//  Game.swift
//  TicTak
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

class Game {
    let dimension = 9
    let playingField : Field = Field()
    
    static let shared = Game()

    init () {
        for _ in 0..<dimension {
            playingField.arr.append(EmptyCell())
        }
    }
    
    func startGame() {
        for i in 0..<dimension {
            //let cell : Cell = playingField.arr[i]
            playingField.arr[i] = ZeroCell()
        }
    }
    
    func isGameOver() -> Bool {
        var result = false
        for i in 0..<dimension {
                let cell : Cell = playingField.arr[i]
                result = cell.isEmpty && result
        }
        return result
    }
    
    func changeItem(atIndex : Int, newValue : Cell) {
        playingField.arr[atIndex]  = newValue
    }
}

