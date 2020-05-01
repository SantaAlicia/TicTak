//
//  viewForDraw.swift
//  TicTak
//
//  Created by liudmila vladimirova on 28/04/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit
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
//class viewForDraw: UIView {
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//    override init(frame: CGRect) {
//       super.init(frame: frame)
//
//       self.backgroundColor = UIColor.darkGray
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func draw(_ rect: CGRect) {
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: 100, y: 100))
//
//        UIColor.purple.setStroke()
//        path.stroke()
//    }
//}

class CircleView: FigureView {
    init(frame : CGRect, drawNow : Bool){
        super.init(frame : frame)
        self.backgroundColor = UIColor.clear
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 20)/2, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        figureLayer = CAShapeLayer()
        figureLayer.path = circlePath.cgPath
        figureLayer.fillColor = UIColor.clear.cgColor
        figureLayer.strokeColor = UIColor.black.cgColor
        figureLayer.lineWidth = 9.0
        
        figureLayer.strokeEnd = (drawNow) ? 0 : 1
        layer.addSublayer(figureLayer)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder) is not beeing implemented")
    }
        
//    func animateCircle(duration: TimeInterval) {
//        let animation  = CABasicAnimation(keyPath: "strokeEnd")
//        animation.duration = duration
//        animation.fromValue = 0
//        animation.toValue = 1
//        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//        circleLayer.strokeEnd = 1
//        circleLayer.add(animation, forKey: "animateCircle")
//    }
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
        figureLayer.strokeColor = UIColor.red.cgColor
        figureLayer.lineWidth = 11.0
    
        figureLayer.strokeEnd = (drawNow) ?  0 : 1
        layer.addSublayer(figureLayer)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder) is not beeing implemented")
    }
        
//    func animateCross(duration: TimeInterval) {
//        let animation  = CABasicAnimation(keyPath: "strokeEnd")
//        animation.duration = duration
//        animation.fromValue = 0
//        animation.toValue = 1
//        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//        crossLayer.strokeEnd = 1
//        crossLayer.add(animation, forKey: "animateCross")
//    }
}

