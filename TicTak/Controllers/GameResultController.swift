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
let    AllWinCombinations  : Set<Set<Int>> =  [[0,1,2],[0,3,6],[3,4,5],[1,4,7],[6,7,8],[2,5,8],[0,4,8],[2,4,6]]

protocol GameResultControllerProtocol {
    static func findWiner() -> GameWinner
    //static func findWinSet() -> Set<Int>?
}

struct GameResultController : GameResultControllerProtocol {
    
    static func findWiner() -> GameWinner {
        let crossWin = isCrossWin()
        let zeroWin = isZeroWin()
        
        if (zeroWin) {
            return GameWinner.zeroWinner
        }
        if (crossWin) {
            return GameWinner.crossWinner
        }
        return GameWinner.draw
    }
    
//    static func findWinSet() -> Set<Int>? {
//        let game  = Game.shared
//        var set : Set<Int>?
//        if game.gameResult == GameWinner.crossWinner {
//            set = game.gameBoard.findAllCellWithCross()
//        }
//        if game.gameResult == GameWinner.zeroWinner {
//            set = game.gameBoard.findAllCellWithZero()
//        }
//        return findWinCombination(set: set)
//    }
}

//find winner
extension GameResultController {
    
    private static func isWin(set : Set<Int>?) -> Bool {
        guard let set = set else {
            return false
        }
        var result : (Bool, Set<Int>?)  = (false, nil)
        let game  = Game.shared
        for combination in AllWinCombinations {
            result = checkOneCombination(setForCheck: set, oneWinCombination: combination)
            if result.0 {
                game.winCombination = result.1
                return result.0
            }
        }
        return result.0
    }
    
    private static func isCrossWin() -> Bool {
        let game  = Game.shared
        let cellsForCross = game.gameBoard.findAllCellWithCross()
        return isWin(set : cellsForCross)
    }
    
    private static func isZeroWin() -> Bool {
        let game  = Game.shared
        let cellsForZero = game.gameBoard.findAllCellWithZero()
        return isWin(set : cellsForZero)
    }
}

//find the winning combination
extension GameResultController {
//    private static func findWinCombination(set : Set<Int>?) -> Set<Int>? {
//        guard let set = set else {
//            return nil
//        }
//        var result : (Bool, Set<Int>?)  = (false, nil)
//        for combination in AllWinCombinations {
//            result = checkOneCombination(setForCheck: set, oneWinCombination: combination)
//            if result.0 {
//                return result.1
//            }
//        }
//        return result.1
//    }
//
    private static func checkOneCombination(setForCheck : Set<Int>, oneWinCombination : Set<Int>) -> (Bool, Set<Int>?) {
        if oneWinCombination.isSubset(of: setForCheck) {
            return (true, oneWinCombination)
        }
        return (false, nil)
    }
}
