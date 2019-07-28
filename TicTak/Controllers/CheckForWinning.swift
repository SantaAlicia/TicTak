//
//  CheckForWinning.swift
//  TicTak
//
//  Created by liudmila vladimirova on 28/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

class CheckForWinning {

    static func isWin(ar : [Int]) -> Bool {
        let winArray = [[0,1,2],[0,3,6],[3,4,5],[1,4,7],[6,7,8],[2,5,8],[0,4,8],[2,4,6]]
        return winArray.contains(ar)
    }
    
//    static func FindAlCross(gameController : GameController) -> [Int] {
//
//    }
}
