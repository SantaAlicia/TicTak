//
//  Cell.swift
//  TicTak
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

enum CellType {
    case cross
    case zero
    case empty
}

protocol CellProtocol {
    var isEmpty : Bool {get}
    var type : CellType {get}
}

class Cell : CellProtocol {
    var isEmpty = true
    var type = CellType.empty
}

class EmptyCell : Cell {
    override init() {
        super.init()
        isEmpty = true
        type = CellType.empty
    }
}

class CrossCell : Cell {
    override init() {
        super.init()
        isEmpty = false
        type = CellType.cross
    }
}

class ZeroCell : Cell {
    override init() {
        super.init()
        isEmpty = false
        type = CellType.zero
    }
}






