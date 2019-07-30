//
//  CheckForWinning.swift
//  TicTak
//
//  Created by SantaAlicia on 28/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

enum GameWinner {
    case crossWinner
    case zeroWinner
    case draw
}

class GameResultController {
    
    private static func isWin(set : Set<Int>?) -> Bool {
        let winSet: Set<Set<Int>> =  [[0,1,2],[0,3,6],[3,4,5],[1,4,7],[6,7,8],[2,5,8],[0,4,8],[2,4,6]]
        guard let unwrapped = set else {
            return false
        }
        var result = false
        for combination in winSet {
            result = result || combination.isSubset(of: unwrapped)        }
        return result
    }
    
    static func isCrossWin() -> Bool {
        let gameController  = GameController.shared
        let cellsForCross = gameController.game.findAllCellWithCross()
        return isWin(set : cellsForCross)
    }
    
    static func isZeroWin() -> Bool {
        let gameController  = GameController.shared
        let cellsForZero = gameController.game.findAllCellWithZero()
        return isWin(set : cellsForZero)
    }
    
    static func findWiiner() -> GameWinner {
        let crossWin = isCrossWin()
        let zeroWin = isZeroWin()
        
        //both have win combination
        if (crossWin && zeroWin) {
            return GameWinner.draw
        }
        //both not win combination
        if !(crossWin || zeroWin) {
            return GameWinner.draw
        }
        if (zeroWin) {
            return GameWinner.zeroWinner
        }
        if (crossWin) {
            return GameWinner.crossWinner
        }
        return GameWinner.draw
    }
}
