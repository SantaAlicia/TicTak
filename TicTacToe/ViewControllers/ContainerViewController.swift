//
//  ContainerViewController.swift
//  Tic-Tac-Toe
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
    var leftNavigationController : UINavigationController!
    var centerNavigationController : UINavigationController!
    var tapGesture : UITapGestureRecognizer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        centerNavigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restorationIdentifier = "ContainerViewController"
        
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self

        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
    
        add(centerNavigationController)
        
        centerNavigationController.view.layer.shadowOpacity = 0.2
        centerNavigationController.view.layer.shadowOffset = CGSize(width: -4, height: 4)
        centerNavigationController.view.layer.shadowRadius = 3
        centerNavigationController.view.layer.shadowColor = UIColor.gray.cgColor
        centerNavigationController.view.layer.masksToBounds = false;
    }
}

//MARK: protocol CenterViewControllerLeftPanel
extension ContainerViewController: CenterViewControllerLeftPanel {
    
    func toggleLeftPanel() {
        if (currentState != .leftMenuExpanded) {
            addLeftMenuViewController()
        } else {
            centerViewController.refreshBoard()
        }
        moveControllers()
    }
}

private extension ContainerViewController {
    func addLeftMenuViewController() {
        if leftNavigationController == nil {
             leftNavigationController = UIStoryboard.leftMenuNavigatioController()
            (leftNavigationController.viewControllers.first as! LeftMenuViewController).delegate = self as? LeftMenuViewControllerelSwipeGesture
        }
        leftNavigationController.popToRootViewController(animated: true)
        
        addChild(leftNavigationController!)
        view.insertSubview(leftNavigationController?.view! ?? self.view, at: 0)
        leftNavigationController?.didMove(toParent: self)
    }
    
     func moveControllers() {
        guard let width = leftNavigationController.viewControllers.first?.view.frame.size.width else {return}
        
        if (currentState  == .leftMenuExpanded) {
            currentState  = .leftMenuCollapsed
            animateCentralPanelXPositoion(targetPositionLeft: 0, targetPositionCentral: 0,  completion : {finished -> Void in
                if finished {
                    self.leftNavigationController.remove()
                    guard let tapGesture = self.tapGesture else { return }
                    self.view.removeGestureRecognizer(tapGesture)
                }
            })
        } else {
            currentState  = .leftMenuExpanded
            animateCentralPanelXPositoion(targetPositionLeft: 0, targetPositionCentral: width*0.82)
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.respondToTapGesture))
            guard let tapGesture = tapGesture else { return }
            //this "view" is contanier view = current view
            view.addGestureRecognizer(tapGesture)
            tapGesture.delegate = self
        }
    }
    
    func animateCentralPanelXPositoion(targetPositionLeft : CGFloat, targetPositionCentral : CGFloat, completion: ((Bool) -> Void)? = nil)  {
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
//MARK:UIGestureRecognizerDelegate
extension ContainerViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                      shouldReceive touch: UITouch) -> Bool
    {
        if (touch.view!.superview!.isKind(of: SettingSwitchTableViewCell.self)) || (touch.view!.superview!.isKind(of: ColorSchemaTableViewCell.self)){
            return false
        }
        return true
    }
}

//MARK:LeftMenuViewControllerelSwipeGesture
extension ContainerViewController: LeftMenuViewControllerelSwipeGesture {
    
    @objc
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

//MARK:UIStoryboard extension
private extension UIStoryboard {
    static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
  
    static func centerViewController() -> CenterViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "CenterViewController") as? CenterViewController
    }
        
    static func leftMenuNavigatioController() -> LeftMenuNavigationController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? LeftMenuNavigationController
    }
}

//extension UIStackView {
//    func addBackground(color: UIColor) {
//        let subView = UIView(frame: bounds)
//        subView.backgroundColor = color
//        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        insertSubview(subView, at: 0)
//    }
//}

