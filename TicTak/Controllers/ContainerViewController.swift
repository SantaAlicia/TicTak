//
//  ContainerViewController.swift
//  TicTak
//
//  Created by liudmila vladimirova on 31/01/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    enum SlideOutState {
        case leftMenuExpanded
        case leftMenuCollapsed
    }
    var centerViewController : CenterViewController!
    var leftMenuViewController : LeftMenuViewController!
    var centerNavigationController : UINavigationController!
    var currentState : SlideOutState = .leftMenuCollapsed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self

        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        //centerNavigationController.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(centerNavigationController.view)
        self.addChild(centerNavigationController)
        
        centerNavigationController.didMove(toParent: self)

        //let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        //centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)

        // Do any additional setup after loading the view.
        
        //centerNavigationController.navigationBar.barStyle = .black
        //statusBarStyle = .lightContent
        
        centerNavigationController.view.layer.shadowOpacity = 0.2
        centerNavigationController.view.layer.shadowOffset = CGSize(width: -4, height: 4)
        centerNavigationController.view.layer.shadowRadius = 3
        centerNavigationController.view.layer.shadowColor = UIColor.gray.cgColor
        centerNavigationController.view.layer.masksToBounds = false;
    }
    
     var statusBarHidden = false {
            didSet(newValue) {
                setNeedsStatusBarAppearanceUpdate()
            }
        }
        
        override var prefersStatusBarHidden: Bool {
          return statusBarHidden
        }
        
        var statusBarStyle = UIStatusBarStyle.default{
            didSet (newValue) {
                setNeedsStatusBarAppearanceUpdate()
            }
        }
        
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return statusBarStyle
        }

    //    @IBAction func buttonTapped(_ sender: Any) {
    //        statusBarStyle = .darkContent
    //        statusBarHidden = !statusBarHidden
    //    }
    //
    //    @IBAction func button2Tapped(_ sender: Any) {
    //        statusBarStyle = .lightContent
    //    }
    
//    public func updateStatusBar() {
//        UINavigationBar.appearance().barTintColor = UIColor(red: 13/225, green: 71/255, blue:161/255, alpha: 1.0)
//        setNeedsStatusBarAppearanceUpdate()
//    }
}

extension ContainerViewController: CenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        if (currentState != .leftMenuExpanded) {
            addLeftMenuViewController()
        }
        //statusBarStyle = .lightContent
        //statusBarHidden = false
        
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
        vc.delegate = self as? LeftMenuViewControllerelDelegate //centerViewController
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
                    self.leftMenuViewController?.view.removeFromSuperview()
                    self.leftMenuViewController = nil
                }
            })
        } else {
            currentState  = .leftMenuExpanded
            animateCentralPanelXPositoion(targetPositionLeft: 0, targetPositionCentral: width*0.82)
            //animateCentralPanelXPositoion(targetPositionLeft: 0, targetPositionCentral: width*0.82, completion : { finished -> Void in self.updateStatusBar()})
        }
    }
    
    private func animateCentralPanelXPositoion(targetPositionLeft : CGFloat, targetPositionCentral : CGFloat, completion: ((Bool) -> Void)? = nil)  {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {//self.leftMenuViewController?.view.frame.origin.x = targetPositionLeft
                        self.centerNavigationController?.view.frame.origin.x = targetPositionCentral
                        },
                       completion: completion)
    }
}

extension ContainerViewController: LeftMenuViewControllerelDelegate {
    func didSelectMenu() {
    }

    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if (currentState != .leftMenuExpanded) {
            return
        }
        toggleLeftPanel()
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

