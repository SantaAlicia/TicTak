//
//  ContainerViewController.swift
//  TicTak
//
//  Created by liudmila vladimirova on 31/01/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit

enum SlideOutState {
    case leftMenuExpanded
    case leftMenuCollapsed
}

protocol ContainerViewControllerProtocol {
    var currentState : SlideOutState {get}
}

 class ContainerViewController: UIViewController, ContainerViewControllerProtocol {

    var currentState : SlideOutState = .leftMenuCollapsed
    var centerViewController : CenterViewController!
    var leftMenuViewController : LeftMenuViewController!
    var centerNavigationController : UINavigationController!
    var tapGesture : UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self

        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        
        view.addSubview(centerNavigationController.view)
        addChild(centerNavigationController)
        centerNavigationController.didMove(toParent: self)
    
        centerNavigationController.view.layer.shadowOpacity = 0.2
        centerNavigationController.view.layer.shadowOffset = CGSize(width: -4, height: 4)
        centerNavigationController.view.layer.shadowRadius = 3
        centerNavigationController.view.layer.shadowColor = UIColor.gray.cgColor
        centerNavigationController.view.layer.masksToBounds = false;
        
//        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.respondToTapGesture))
//        guard let tapGesture = tapGesture else { return }
//        self.view.addGestureRecognizer(tapGesture)
    }
}

extension ContainerViewController: CenterViewControllerLeftPanel {
    
    func toggleLeftPanel() {
        if (currentState != .leftMenuExpanded) {
            addLeftMenuViewController()
        }
        moveControllers()
    }
    
    private func addLeftMenuViewController() {
        guard leftMenuViewController == nil else {return}
        if let vc =  UIStoryboard.leftMenuViewController() {
            addChildViewController(vc)
            leftMenuViewController = vc
        }
        
        //let parentController = leftMenuViewController.parent as! ContainerViewController
       
        
        //self.leftMenuViewController?.view.frame.size.width = self.view.frame.size.width * 0.66
        //self.leftMenuViewController?.view.frame.origin.x = (self.leftMenuViewController?.view.frame.size.width)!*(-1)
    }
    
    private func addChildViewController(_ vc : LeftMenuViewController) {
        vc.delegate = self as? LeftMenuViewControllerelSwipeGesture
           view.insertSubview(vc.view, at: 0)
           addChild(vc)
           vc.didMove(toParent: self)
    }
    
    private func moveControllers() {
        guard let width = self.leftMenuViewController?.view.frame.size.width else {return}
        
        if (currentState  == .leftMenuExpanded) {
            currentState  = .leftMenuCollapsed
            animateCentralPanelXPositoion(targetPositionLeft: 0, targetPositionCentral: 0,  completion : {finished -> Void in
                if finished {
//                    self.leftMenuViewController?.view.removeFromSuperview()
//                    self.leftMenuViewController.delegate = nil
//                    self.leftMenuViewController = nil
                      self.leftMenuViewController.remove()
                      self.leftMenuViewController = nil
                    
                    guard let tapGesture = self.tapGesture else { return }
                    self.view.removeGestureRecognizer(tapGesture)
                }
            })
        } else {
            currentState  = .leftMenuExpanded
            animateCentralPanelXPositoion(targetPositionLeft: 0, targetPositionCentral: width*0.82)
            //animateCentralPanelXPositoion(targetPositionLeft: 0, targetPositionCentral: width*0.82, completion : { finished -> Void in self.updateStatusBar()})
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.respondToTapGesture))
            guard let tapGesture = tapGesture else { return }
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    private func animateCentralPanelXPositoion(targetPositionLeft : CGFloat, targetPositionCentral : CGFloat, completion: ((Bool) -> Void)? = nil)  {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.centerNavigationController?.view.frame.origin.x = targetPositionCentral
                        },
                       completion: completion)
    }
}

extension ContainerViewController: LeftMenuViewControllerelSwipeGesture {
//    func didSelectMenu() {
//    }

    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if (currentState != .leftMenuExpanded) {
            return
        }
        toggleLeftPanel()
    }
    
    @objc
    func respondToTapGesture(gesture : UIGestureRecognizer) {
        respondToSwipeGesture(gesture: gesture)
    }
}

private extension UIStoryboard {
    
  static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
  
  static func centerViewController() -> CenterViewController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "CenterViewController") as? CenterViewController
  }
    
  static func leftMenuViewController() -> LeftMenuViewController? {
      return mainStoryboard().instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController
  }
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

