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
    
    init () {
        playingField.arr = Array(repeating: Array(repeating: Cell(), count: 3), count: 3)
    }
}

