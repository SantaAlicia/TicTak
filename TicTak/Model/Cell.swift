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
    var isEmpty : Bool = true
    var type : CellType = CellType.empty
}

class EmptyCell : Cell {
    
    override init() {
        super.init()
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




