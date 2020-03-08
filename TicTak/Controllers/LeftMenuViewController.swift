//
//  LeftMenuViewController.swift
//  TicTak
//
//  Created by liudmila vladimirova on 26/01/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit

//extension UIViewController {
//    func add(_ child: UIViewController) {
//        addChild(child)
//        view.addSubview(child.view)
//        child.didMove(toParent: self)
//    }
//
//    func remove() {
//        // Just to be safe, we check that this view controller
//        // is actually added to a parent before removing it.
//        guard parent != nil else {
//            return
//        }
//
//        willMove(toParent: nil)
//        view.removeFromSuperview()
//        removeFromParent()
//    }
//}

class LeftMenuViewController: UIViewController {

    var delegate : LeftMenuViewControllerelDelegate?
    @IBOutlet weak var navigationBar : UINavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        self.title = "Settings"
    }
    
    func gestureRecognizerShouldBegin(_ gesture: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        delegate?.respondToSwipeGesture(gesture: gesture)
    }
}

protocol LeftMenuViewControllerelDelegate {
  func didSelectMenu()
  func respondToSwipeGesture(gesture: UIGestureRecognizer)
}
