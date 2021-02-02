//
//  LeftMenuViewController.swift
//  TicTak
//
//  Created by liudmila vladimirova on 26/01/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit

extension UIViewController {
    //To add a view controller as a child
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

//MARK:protocol
protocol LeftMenuViewControllerelSwipeGesture {
  func respondToSwipeGesture(gesture: UIGestureRecognizer)
}

class LeftMenuViewController: UIViewController {

    var delegate : LeftMenuViewControllerelSwipeGesture?
    let game = Game.shared
    @IBOutlet weak var settingsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        addSwipe()
        backgrounfForTable()
        settingsTable.reloadData()
        
        if #available ( iOS 13.0, *){
        overrideUserInterfaceStyle = .light
        }
        self.navigationController?.navigationBar.barStyle = .default
        
        //guard let tapGesture = self.ta.tapGesture else { return }
        //self.view.removeGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingsTable.reloadData()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showLeftMenuColorSchema") {
            segue.destination.presentationController?.delegate = self
        }
    }
    
    func addSwipe() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeftGesture.direction = .left
        self.view.addGestureRecognizer(swipeLeftGesture)
    }
    
    func backgrounfForTable() {
        settingsTable.backgroundColor = UIColor(white: 1, alpha: 0.3)
        //let rect = CGRect(x: 10, y: 10, width: 100, height: 20)
        //settingsTable.tableHeaderView =  UIView(frame: rect)
        //settingsTable.tableHeaderView?.backgroundColor = UIColor(white: 1, alpha: 0.3)
    }
}

//MARK:gesture extension
extension LeftMenuViewController {
    func gestureRecognizerShouldBegin(_ gesture: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        delegate?.respondToSwipeGesture(gesture: gesture)
    }
}

//MARK: UITableViewDelegate extension
extension LeftMenuViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          let v = UIView()
          v.backgroundColor = UIColor(white: 1, alpha: 0.3)
          return v
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            game.playVSComputer = !game.playVSComputer
        }
        if (indexPath.row == 1) {
            game.needPlaySoundGameOver = !game.needPlaySoundGameOver
        }
        if (indexPath.row == 2) {
            game.needPlaySoundOneStep = !game.needPlaySoundOneStep
        }
        tableView.reloadData()
    }
}

//MARK: UITableViewDataSource extension
extension LeftMenuViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingSwitchTableViewCell", for: indexPath) as! SettingSwitchTableViewCell
            cell.title!.text = "Play vs iPhone"
            cell.checkmarkImage.isHidden = !game.playVSComputer
            return cell
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingSwitchTableViewCell", for: indexPath) as! SettingSwitchTableViewCell
            cell.title!.text = "Play sound GameOver"
            cell.checkmarkImage.isHidden = !game.needPlaySoundGameOver
            return cell
        } else if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingSwitchTableViewCell", for: indexPath) as! SettingSwitchTableViewCell
            cell.title!.text = "Play sound One Step"
            cell.checkmarkImage.isHidden = !game.needPlaySoundOneStep
            return cell
        } else {
            let cellColorScheme = tableView.dequeueReusableCell(withIdentifier: "settingColorSchemeiewCell", for: indexPath) as! ColorSchemaTableViewCell
            cellColorScheme.colotSchemaTypeLabel.text = (ColorShema.colorShemaType.rawValue == 0) ? "White and grey" : "Black and red"
            return cellColorScheme
        }
    }
}

//MARK: UIAdaptivePresentationControllerDelegate extension
extension LeftMenuViewController : UIAdaptivePresentationControllerDelegate {
//    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
//        print("presentationControllerWillDismiss")
//        //changeColorShemaColorShemaType()
//        settingsTable.reloadData()
//
//    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        settingsTable.reloadData()
    }
    
//    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
//        print("presentationControllerDidAttemptToDismiss")
//        //changeColorShemaColorShemaType()
//        settingsTable.reloadData()
//    }
}

