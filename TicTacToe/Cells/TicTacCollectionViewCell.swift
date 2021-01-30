//
//  TicCollectionViewCell.swift
//  Tic-Tac-Toe
//
//  Created by liudmila_vladimirova 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

class TicTacCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var view: UIView!
    let animationDuration = 0.7
    
    func fillCell(type : CellType, isWinCell : Bool, isCurrent : Bool) {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        let figure = Figure()
        figure.createFigure(view : view, cellType: type, isCurrent: isCurrent)

        drawCellBorder(isWinCell: isWinCell)
    }
    
    func drawCellBorder(isWinCell : Bool) {

        if isWinCell {
            layer.borderWidth = 5
            layer.borderColor = ColorShema.borderColor
        } else {
            layer.borderWidth = 1
        }
    }
}



