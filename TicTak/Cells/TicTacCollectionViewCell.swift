//
//  TicCollectionViewCell.swift
//  TicTak
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
            if (CellDesignSettings.shared.type == .whiteGray) {
                layer.borderColor = UIColor.blue.cgColor
            }
            if (CellDesignSettings.shared.type == .blackRed) {
                layer.borderColor = UIColor.lightGray.cgColor
            }
        } else {
            layer.borderWidth = 1
        }
    }
}



