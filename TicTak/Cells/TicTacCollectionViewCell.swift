//
//  TicCollectionViewCell.swift
//  TicTak
//
//  Created by liudmila_vladimirova 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

class TicTacCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var imageView: UIImageView!
    
    func fillCell(type : CellType, isWinCell : Bool) {
        
        switch type {
        case CellType.empty:
            imageView.image = nil
            
        case CellType.cross:
            imageView.image = UIImage(named: "cross")
            
        case CellType.zero:
            imageView.image = UIImage(named: "zero")
        }
        drawCellBorder(isWinCell: isWinCell)
    }
    
    func drawCellBorder(isWinCell : Bool) {
        if isWinCell {
            layer.borderWidth = 5
        } else {
            layer.borderWidth = 1
        }
    }
}

