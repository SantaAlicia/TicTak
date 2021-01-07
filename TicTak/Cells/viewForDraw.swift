//
//  viewForDraw.swift
//  TicTak
//
//  Created by liudmila vladimirova on 28/04/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit

enum CellDesign {
    case whiteGray
    case blackRed
    case empty
}

class CellDesignSettings {
    static let shared = CellDesignSettings()
    //var type : CellDesign = CellDesign.whiteGray
    var type : CellDesign = CellDesign.blackRed
}

class Figure {
    var figureView : FigureView!
    let animationDuration = 0.7
    
    func createFigure(view : UIView, cellType:CellType, isCurrent: Bool) {
        if (CellDesignSettings.shared.type == .whiteGray) {
            view.backgroundColor = UIColor(white: 1, alpha: 0.5)//UIColor.darkGray
        }
        if (CellDesignSettings.shared.type == .blackRed) {
            view.backgroundColor = UIColor(white: 1, alpha: 0)
        }
        if (cellType == .empty) { return }
        if (cellType == .cross) {
            figureView =  CrossView(frame: view.frame, drawNow: isCurrent)
        }
        if (cellType == .zero) {
            figureView =  CircleView(frame: view.frame, drawNow: isCurrent)
        }
        view.addSubview(figureView)
        if isCurrent {
            figureView.animateFigure(duration: animationDuration, identifier: "animateFigure")
        }
    }
}

class FigureView: UIView {
    var figureLayer : CAShapeLayer!
    
    func animateFigure(duration: TimeInterval, identifier : String) {
        let animation  = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        figureLayer.strokeEnd = 1
        figureLayer.add(animation, forKey: identifier)
    }
}

class CircleView: FigureView {
    init(frame : CGRect, drawNow : Bool){
        super.init(frame : frame)
        self.backgroundColor = UIColor.clear
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 20)/2, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        figureLayer = CAShapeLayer()
        figureLayer.path = circlePath.cgPath
        figureLayer.fillColor = UIColor.clear.cgColor
        
        if (CellDesignSettings.shared.type == .whiteGray) {
            (figureLayer.strokeColor = UIColor.white.cgColor)
        }
        if (CellDesignSettings.shared.type == .blackRed) {
            (figureLayer.strokeColor = UIColor.black.cgColor)
        }
        
        figureLayer.lineWidth = 9.0
        
        figureLayer.strokeEnd = (drawNow) ? 0 : 1
        layer.addSublayer(figureLayer)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder) is not beeing implemented")
    }
}

class CrossView: FigureView {    
     init(frame : CGRect, drawNow : Bool){
        super.init(frame : frame)
        self.backgroundColor = UIColor.clear
        
        let crossPath = UIBezierPath()
        let delta = CGFloat(8)
        crossPath.move(to: CGPoint(x: 0+delta, y: 0+delta))
        crossPath.addLine(to: CGPoint(x: frame.size.width-delta, y: frame.size.height-delta))
        crossPath.close()
        crossPath.move(to: CGPoint(x: frame.size.width-delta, y: 0+delta))
        crossPath.addLine(to: CGPoint(x: 0+delta, y: frame.size.height-delta))
        
        figureLayer = CAShapeLayer()
        figureLayer.path = crossPath.cgPath
        figureLayer.fillColor = UIColor.clear.cgColor
        if (CellDesignSettings.shared.type == CellDesign.whiteGray) {
            (figureLayer.strokeColor = UIColor.white.cgColor)
        }
        if (CellDesignSettings.shared.type == CellDesign.blackRed) {
            (figureLayer.strokeColor = UIColor.red.cgColor)
        }
        figureLayer.lineWidth = 11.0
    
        figureLayer.strokeEnd = (drawNow) ?  0 : 1
        layer.addSublayer(figureLayer)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder) is not beeing implemented")
    }
}

