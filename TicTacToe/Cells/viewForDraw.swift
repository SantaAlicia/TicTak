//
//  viewForDraw.swift
//  Tic-Tac-Toe
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

enum ColorShemaType : Int {
    case whiteGray = 0
    case blackRed = 1
}

//class CellDesignSettings {
//    static let shared = CellDesignSettings()
//    var type : CellDesign = CellDesign.blackRed
//    static var colorshema : ColorShemaType = .whiteGray
//}

class ColorShema {
    static let shared = ColorShema()
    static var colorShemaType : ColorShemaType = ColorShemaType.whiteGray {
        didSet {
            if colorShemaType == ColorShemaType.whiteGray  {
                let whiteImage = UIImage(named: "chalk")!
                white = (UIColor(patternImage: whiteImage)).cgColor
                
                ColorShema.crossColor = white
                ColorShema.circleColor = white
                ColorShema.borderColor = borderWG
                ColorShema.backgroungColor = backgroundWG
            }
            if colorShemaType == ColorShemaType.blackRed  {
                let redImage = UIImage(named: "redChalk")!
                red = (UIColor(patternImage: redImage)).cgColor
                
                let blackImage = UIImage(named: "blackChalk")!
                black = (UIColor(patternImage: blackImage)).cgColor
                
                ColorShema.crossColor = red
                ColorShema.circleColor = black
                ColorShema.borderColor = borderBR
                ColorShema.backgroungColor = backgroundBR
            }
        }
    }
    static var crossColor : CGColor!
    static var circleColor : CGColor!
    static var borderColor : CGColor!
    static var backgroungColor : UIColor!

    private static var white: CGColor = UIColor.white.cgColor
    private static var black : CGColor  = UIColor.black.cgColor
    private static var red : CGColor = UIColor.red.cgColor
    private static let borderWG : CGColor = UIColor.blue.cgColor
    private static let borderBR : CGColor = UIColor.lightGray.cgColor
    private static let backgroundWG : UIColor = UIColor.darkGray
    private static let backgroundBR : UIColor = UIColor(white: 1, alpha: 0)
}

class Figure {
    var figureView : FigureView!
    let animationDuration = 0.7
    
    func createFigure(view : UIView, cellType:CellType, isCurrent: Bool) {
        view.backgroundColor = ColorShema.backgroungColor
        
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
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 28)/2, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        figureLayer = CAShapeLayer()
        figureLayer.path = circlePath.cgPath
        figureLayer.fillColor = UIColor.clear.cgColor
        figureLayer.strokeColor = ColorShema.circleColor
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
        let delta = CGFloat(15)
        crossPath.move(to: CGPoint(x: 0+delta, y: 0+delta))
        crossPath.addLine(to: CGPoint(x: frame.size.width-delta, y: frame.size.height-delta))
        //crossPath.close()
        crossPath.move(to: CGPoint(x: frame.size.width-delta, y: 0+delta))
        crossPath.addLine(to: CGPoint(x: 0+delta, y: frame.size.height-delta))
        
        figureLayer = CAShapeLayer()
        figureLayer.path = crossPath.cgPath
        figureLayer.fillColor = UIColor.clear.cgColor
        figureLayer.strokeColor = ColorShema.crossColor
        figureLayer.lineWidth = 11.0
        figureLayer.lineCap = CAShapeLayerLineCap.round
    
        figureLayer.strokeEnd = (drawNow) ?  0 : 1
        layer.addSublayer(figureLayer)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder) is not beeing implemented")
    }
}

