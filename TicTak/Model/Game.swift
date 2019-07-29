//
//  Game.swift
//  TicTak
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

private class Field  {
    var arr = [Cell]()
    //static let shared = Field()
}

class Game {
    private let gameBorder = Field()
    //static let shared = Game()

    init () {
        for _ in 0..<GameConstants.gameDimension  {
            gameBorder.arr.append(EmptyCell())
        }
    }
    
    func preparationForNewGame() {
        for i in 0..<GameConstants.gameDimension  {
            gameBorder.arr[i] = EmptyCell()
        }
    }
}

extension Game {
    func changeCellAtIndex(_ atIndex : Int, newValue : Cell) {
        gameBorder.arr[atIndex]  = newValue
    }
    
    func cellAtIndex(_ atIndex : Int) -> Cell{
        let cell = gameBorder.arr[atIndex]
        return cell
    }
}

extension Game {
     func isGameOver() -> Bool {
        var result = true
        for i in 0..<GameConstants.gameDimension  {
            let cell : Cell = gameBorder.arr[i]
            result = !cell.isEmpty && result
        }
        return result
    }
    
     func isGameJustStarted() -> Bool {
        var result = true
        for i in 0..<GameConstants.gameDimension  {
            let cell : Cell = gameBorder.arr[i]
            result = cell.isEmpty && result
        }
        return result
    }
}

extension Game {
    private func findAllCellWithType(type : CellType) -> [Int]? {
        if (!isGameOver()) {
            return nil
        }
        var array : [Int] = [Int]()
        for i in 0..<GameConstants.gameDimension  {
            let cell : Cell = gameBorder.arr[i]
            if (cell.type == type) {
                array.append(i)
            }
        }
        return array
    }
    func fintAllCellWithCross() ->[Int]? {
        return findAllCellWithType(type: CellType.cross)
    }
    
    func fintAllCellWithZero() ->[Int]? {
        return findAllCellWithType(type: CellType.zero)
    }
}

