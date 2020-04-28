//
//  LeftMenuViewController.swift
//  TicTak
//
//  Created by liudmila vladimirova on 26/01/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

protocol LeftMenuViewControllerelSwipeGesture {
  func respondToSwipeGesture(gesture: UIGestureRecognizer)
}

class LeftMenuViewController: UIViewController {

    var delegate : LeftMenuViewControllerelSwipeGesture?
    let game = Game.shared
    @IBOutlet weak var settingsTable: UITableView!
    
    override func viewDidLoad() {
        title = "Settings"
        
        super.viewDidLoad()
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeftGesture.direction = .left
        self.view.addGestureRecognizer(swipeLeftGesture)
        
        settingsTable.backgroundColor = UIColor(white: 1, alpha: 0.3)
        let rect = CGRect(x: 10, y: 10, width: 100, height: 20)
        settingsTable.tableHeaderView =  UIView(frame: rect)
        settingsTable.tableHeaderView?.backgroundColor = UIColor(white: 1, alpha: 0.3)
        settingsTable.reloadData()
        
        if #available ( iOS 13.0, *){
        overrideUserInterfaceStyle = .light
        }
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
            game.needPlaySoundGameOver = mySwitch.isOn
        }
        if( mySwitch.tag == 2) {
            game.needPlaySoundOneStep = mySwitch.isOn
        }
    }
}

extension LeftMenuViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension LeftMenuViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingSwitchTableViewCell", for: indexPath) as! SettingSwitchTableViewCell

        if (indexPath.row == 0) {
            cell.title!.text = "Play vs iPhone"
            cell.settingSwitch!.isOn = game.playVSComputer
            cell.settingSwitch!.tag = 0
        }
        
        if (indexPath.row == 1) {
            cell.title!.text = "Play sound GameOver"
            cell.settingSwitch!.isOn = game.needPlaySoundGameOver
            cell.settingSwitch!.tag = 1
        }
        
        if (indexPath.row == 2) {
                   cell.title!.text = "Play sound One Step"
                   cell.settingSwitch!.isOn = game.needPlaySoundOneStep
                   cell.settingSwitch!.tag = 2
               }
       // settingsTable.headerView(forSection: 0)!.backgroundColor = UIColor(white: 1, alpha: 0.3)
       return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
}

