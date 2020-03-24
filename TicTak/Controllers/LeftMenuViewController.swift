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

protocol LeftMenuViewControllerelSwipeGesture {
  //func didSelectMenu()
  func respondToSwipeGesture(gesture: UIGestureRecognizer)
}

class LeftMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var delegate : LeftMenuViewControllerelSwipeGesture?
    let game = Game.shared
    @IBOutlet weak var settingsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.respondToTapGesture))
        swipeLeftGesture.direction = .left
        self.view.addGestureRecognizer(swipeLeftGesture)
        
        title = "Settings"
        settingsTable.backgroundColor = UIColor(white: 1, alpha: 0.3)
        
        let rect = CGRect(x: 10, y: 10, width: 100, height: 20)
        settingsTable.tableHeaderView =  UIView(frame: rect)
        settingsTable.tableHeaderView?.backgroundColor = UIColor(white: 1, alpha: 0.3)
        //settingsTable.sectionHeaderHeight = 20
        
//        switch_playVSComputer.isOn = game.playVSComputer
//        switch_playVSComputer.tintColor = UIColor.black
//        switch_playVSComputer.onTintColor = UIColor.red
      //  switch_playVSComputer.backgroundColor = UIColor.black
    }
    
}

extension LeftMenuViewController {
    func gestureRecognizerShouldBegin(_ gesture: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        delegate?.respondToSwipeGesture(gesture: gesture)
    }
    
//    @objc
//    func respondToTapGesture(gesture : UIGestureRecognizer) {
//
//    }
    
    @IBAction func playVSComputerChanged(mySwitch: UISwitch) {
        if( mySwitch.tag == 0) {
            game.playVSComputer = mySwitch.isOn
        }
        if( mySwitch.tag == 1) {
            game.needPlaySound = mySwitch.isOn
        }
    }
}

extension LeftMenuViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingSwitchTableViewCell", for: indexPath) as! SettingSwitchTableViewCell

        if (indexPath.row == 0) {
            cell.title!.text = "Play vs iPhone"
            cell.settingSwitch!.isOn = game.playVSComputer
            cell.settingSwitch!.tag = 0
        }
        
        if (indexPath.row == 1) {
            cell.title!.text = "Play sound"
            cell.settingSwitch!.isOn = game.needPlaySound
            cell.settingSwitch!.tag = 1
        }
       // settingsTable.headerView(forSection: 0)!.backgroundColor = UIColor(white: 1, alpha: 0.3)
       return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
}

