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
}

