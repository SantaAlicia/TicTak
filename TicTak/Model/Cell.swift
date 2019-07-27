//
//  Cell.swift
//  TicTak
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

enum CellFill {
    case cross
    case zero
}

class Cell {
    var isEmpty : Bool = true
    var fill : CellFill!
    var image : UIImage!
    var backgroundColor : UIColor!
    
    func emptyCell() {
        isEmpty = true
        fill = nil
        image = nil
        backgroundColor = UIColor.lightGray
    }
    
    func crossCell() {
        isEmpty = false
        fill = CellFill.cross
        image = UIImage(named: "cross")
        backgroundColor = nil
    }
    
    func zeroCell() {
        isEmpty = false
        fill = CellFill.zero
        image = UIImage(named: "zero")
        backgroundColor = nil
    }
}




