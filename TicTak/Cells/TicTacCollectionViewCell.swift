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
    @IBOutlet weak var view: viewForDraw!
    let animationDuration = 0.7
    
    func fillCell_old(type : CellType, isWinCell : Bool) {
        
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
    
    ///
    func fillCell2(type : CellType, isWinCell : Bool) {

        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let myView = viewForDraw.init(frame: rect)
        
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        imageView.isHidden = true
        view.isHidden = true
        
        switch type {
        case CellType.empty:
            imageView.image = nil
            
        case CellType.cross:
            view.isHidden = false
            myView.draw(rect)
            view.addSubview(myView)
            
        case CellType.zero:
            view.isHidden = false
            //let circleView  = addCircleView(frame: <#T##CGRect#>)
            //view.addSubview(circleView)//imageView.image = //UIImage(named: "zero")
            //circleView.animateCircle(duration: 1.0)
            
        }
        drawCellBorder(isWinCell: isWinCell)
    }
    
    func fillCell(type : CellType, isWinCell : Bool, isCurrent : Bool) {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        imageView.isHidden = true
        view.isHidden = true
        
        switch type {
        case CellType.empty:
            imageView.image = nil
            
        case CellType.cross:
            view.isHidden = false
            let crossView = addCrossView(frame : view.frame, isCurrent: isCurrent)
            view.addSubview(crossView)
            if isCurrent {
                crossView.animateCross(duration: animationDuration)
            }
            
        case CellType.zero:
            view.isHidden = false
            let circleView  = addCircleView(frame : view.frame, isCurrent: isCurrent)
            view.addSubview(circleView)
            if isCurrent {
                circleView.animateCircle(duration: animationDuration)
            }
        }
        drawCellBorder(isWinCell: isWinCell)
    }
    
    func addCircleView(frame: CGRect, isCurrent : Bool) -> CircleView {
        let circleView = CircleView(frame:frame, drawNow: isCurrent)
        return circleView
    }
    
    func addCrossView(frame: CGRect, isCurrent : Bool) -> CrossView {
        let crossView = CrossView(frame: frame, drawNow: isCurrent)
        return crossView
    }
}



