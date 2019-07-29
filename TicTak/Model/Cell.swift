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

class Cell {
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




