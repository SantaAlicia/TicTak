//
//  GameBoard.swift
//  TicTak
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

class GameBoard {
    private var cellSet = [Cell]()

    init () {
        for _ in 0..<GameConstants.gameDimension  {
            cellSet.append(EmptyCell())
        }
    }
    
    func setupInitialPosition() {
        for i in 0..<GameConstants.gameDimension  {
            cellSet[i] = EmptyCell()
        }
    }
}

extension GameBoard {
    func changeCellAtIndex(_ atIndex : Int, newValue : Cell) {
        cellSet[atIndex]  = newValue
    }
    
    func cellAtIndex(_ atIndex : Int) -> Cell{
        let cell = cellSet[atIndex]
        return cell
    }
}

extension GameBoard {
    //isOver
     func isFull() -> Bool {
        var result = true
        for i in 0..<GameConstants.gameDimension  {
            let cell : Cell = cellSet[i]
            result = !cell.isEmpty && result
        }
        return result
    }
}

extension GameBoard {
    private func findAllCellWithType(type : CellType) -> [Int]? {
        var array : [Int] = [Int]()
        for i in 0..<GameConstants.gameDimension  {
            let cell : Cell = cellSet[i]
            if (cell.type == type) {
                array.append(i)
            }
        }
        return array
    }
    
//    func fintAllCellWithCross() ->[Int]? {
//        return findAllCellWithType(type: CellType.cross)
//    }
//
//    func fintAllCellWithZero() ->[Int]? {
//        return findAllCellWithType(type: CellType.zero)
//    }

    func findAllCellWithCross() ->Set<Int>? {
        return findAllCellWithType(CellType.cross)
    }
    
    func findAllCellWithZero() ->Set<Int>? {
        return findAllCellWithType(CellType.zero)
    }
    func findAllCellWithEmpty() ->Set<Int>? {
        return findAllCellWithType(CellType.empty)
    }

    func findOneEmptyCell() -> Int? {
        guard let set = findAllCellWithEmpty() else {
            return nil
        }
        guard let index = set.randomElement() else {
            return nil
        }
        return index
    }
    
private func findAllCellWithType(_ type : CellType) ->Set<Int>? {
        var cellsForType : Set<Int> = []
        let arr : [Int]?  =  findAllCellWithType(type:type)
        guard let unwrappedArr = arr else {
            return nil
        }
        for element in unwrappedArr {
            cellsForType.insert(element)
        }
        return cellsForType
    }
}



