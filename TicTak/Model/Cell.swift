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
    var image : UIImage!
    var type : CellType = CellType.empty
    
    func emptyCell() {
        type = CellType.empty
        isEmpty = true
        image = nil
    }
    
    func crossCell() {
        type = CellType.cross
        isEmpty = false
        image = UIImage(named: "cross")
    }
    
    func zeroCell() {
        type = CellType.zero
        isEmpty = false
        image = UIImage(named: "zero")
    }
}




