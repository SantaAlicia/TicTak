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
        view.isHidden = true
        
        switch type {
        case CellType.empty:
            view.isHidden = true
            
        case CellType.cross:
            view.isHidden = false
            let crossView = CrossView(frame: view.frame, drawNow: isCurrent)
            view.addSubview(crossView)
            if isCurrent {
                crossView.animateFigure(duration: animationDuration, identifier: "animateCross")
            }
            
        case CellType.zero:
            view.isHidden = false
            let circleView  = CircleView(frame:view.frame, drawNow: isCurrent)
            view.addSubview(circleView)
            if isCurrent {
                circleView.animateFigure(duration: animationDuration, identifier: "animateCircle")
            }
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



