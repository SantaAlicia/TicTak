//
//  GameResultController.swift
//  Tic-Tac-Toe
//
//  Created by liudmila vladimirova on 28/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

enum GameWinner {
    case crossWinner
    case zeroWinner
    case draw
}
let    allWinCombinations  : Set<Set<Int>> =  [[0,1,2],[0,3,6],[3,4,5],[1,4,7],[6,7,8],[2,5,8],[0,4,8],[2,4,6]]

protocol GameResultControllerProtocol {
    static func findWiner() -> GameWinner
}

struct GameResultController : GameResultControllerProtocol {
    
    static func findWiner() -> GameWinner {
        if isCrossWin() {
           return GameWinner.crossWinner
        }
        if isZeroWin() {
                    return GameWinner.zeroWinner
        }
        return GameWinner.draw
    }
}

//MARK: find winner
private extension GameResultController {
    
     static func isWin(set : Set<Int>?) -> Bool {
        guard let set = set else {
            return false
        }
        var result : (Bool, Set<Int>?) = (false, nil)
        let game  = Game.shared
        for combination in allWinCombinations {
            result = checkOneCombination(setForCheck: set, oneWinCombination: combination)
            if result.0 {
                game.winCombination = result.1
                return result.0
            }
        }
        return result.0
    }
    
    static func isCrossWin() -> Bool {
        let game  = Game.shared
        let cellsForCross = game.gameBoard.findAllCellWithCross()
        return isWin(set : cellsForCross)
    }
    
    static func isZeroWin() -> Bool {
        let game  = Game.shared
        let cellsForZero = game.gameBoard.findAllCellWithZero()
        return isWin(set : cellsForZero)
    }
}

//MARK:find the winning combination
private extension GameResultController {
    
    static func checkOneCombination(setForCheck : Set<Int>, oneWinCombination : Set<Int>) -> (Bool, Set<Int>?) {
        if oneWinCombination.isSubset(of: setForCheck) {
            return (true, oneWinCombination)
        }
        return (false, nil)
    }
    
    static func findPositionToCompleteWinCombination(setForCheck : Set<Int>, oneWinCombination : Set<Int>, partnerSet : Set<Int>, amount : Int) -> (Bool, Int?) {
        var newSet = oneWinCombination
        let result : (Bool, Int?) = (false, nil)
        
        //if at least one element of oneWinCombination is already busy by partherSet
        guard (newSet.isDisjoint(with: partnerSet)) else {return result}
        
        let commonPartSet = newSet.intersection(setForCheck)
        guard (commonPartSet.count > amount) else {return result}
        
        //newSet will contain only cells "Empty"
        newSet.subtract(commonPartSet)
        guard let index = newSet.randomElement() else {
            return result
        }
        return (true, index)
    }
    
    private func findStepToPreventCrossWin(oneWinCombination : Set<Int>) {
        
    }
}

//MARK: text - who win
extension GameResultController {
    
    static func winnerText() -> (String, String) {
        let game  = Game.shared
        var st2 = ""
        guard let result = game.gameResult else {
            return ("", "")
        }
        switch result {
        case GameWinner.crossWinner:
            let st1 = "Player \"Cross\" is the winner"
            if (game.playVSComputer) {
                st2 = "You Win!"
            }
            return (st1, st2)
            
        case GameWinner.zeroWinner:
            let st1 = "Player \"Zero\" is the winner"
            if (game.playVSComputer) {
                st2 = "iPhone Win!"
            }
            return (st1, st2)
            
        case GameWinner.draw :
            let st1 = "Draw. Nobody win"
            st2 = "Game Over"
            return (st1, st2)
        }
    }
}

//MARK:try to do next turn, (playVSComputer = true) in one winCombination
extension GameResultController {
    
     static func doSmartDecision () -> (Bool, Int?){
        let game = Game.shared
        var result : (Bool, Int?) = (false, nil)
        guard let cellsForZero = game.gameBoard.findAllCellWithZero() else {return result}
        guard let cellsForCross = game.gameBoard.findAllCellWithCross() else {return result}
        
        //find winCombination with 2 cells wich already have Zero type in it
       for combination in allWinCombinations {
           result = findPositionToCompleteWinCombination(setForCheck: cellsForZero, oneWinCombination: combination, partnerSet: cellsForCross, amount: 1)
           if (result.0) {break}
       }
       if (result.0) {return result}
        
        //find winCombination with 2 cells already have Cross type in it
        //to prevent Cross win
        for combination in allWinCombinations {
            result = findPositionToCompleteWinCombination(setForCheck: cellsForCross, oneWinCombination: combination, partnerSet: cellsForZero, amount: 1)
            if (result.0) {break}
        }
        if (result.0) {return result}
        
        //if 1 cells already have Zero type in winCombination
        for combination in allWinCombinations {
            result = findPositionToCompleteWinCombination(setForCheck: cellsForZero, oneWinCombination: combination, partnerSet: cellsForCross, amount: 0)
            if (result.0) {break}
        }
        return result
    }
}
