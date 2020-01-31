//
//  ContainerViewController.swift
//  TicTak
//
//  Created by liudmila vladimirova on 31/01/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    var centerViewController : CenterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        centerViewController = UIStoryboard.centerViewController()
//        centerViewController.delegate = self
//
//        // wrap the centerViewController in a navigation controller, so we can push views to it
//        // and display bar button items in the navigation bar
//        centerNavigationController = UINavigationController(rootViewController: centerViewController)
//        view.addSubview(centerNavigationController.view)
//        addChild(centerNavigationController)
//
//        centerNavigationController.didMove(toParent: self)
//
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
//        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

private extension UIStoryboard {
  static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
  
  static func centerViewController() -> CenterViewController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "CenterViewController") as? CenterViewController
  }
}
