//
//  LeftMenuColorShemaViewController.swift
//  TicTak
//
//  Created by liudmila vladimirova on 16/01/2021.
//  Copyright © 2021 SantaAlicia. All rights reserved.
//

import UIKit

class LeftMenuColorShemaViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = false
    }
    
    @IBAction func closeThisWindow() {
        self.presentationController?.delegate?.presentationControllerDidDismiss?(self.presentationController!)
        dismiss(animated: true)
    }
}

    //MARK: UITableViewDelegate extension
extension LeftMenuColorShemaViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ColorShema.colorShemaType = ColorShemaType(rawValue: indexPath.row) ?? ColorShemaType.whiteGray
        tableView.reloadData()
    }
}

//MARK: UITableViewDataSource extension
extension LeftMenuColorShemaViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingColorShemaTableViewCell", for: indexPath) as! ColorSchemaTableViewCell
        cell.title.text = (indexPath.row == 0) ? "White and grey" : "Black and red"
        cell.accessoryType = ifNeedCheckmark(indexPath: indexPath)
        return cell
    }
    
    private func ifNeedCheckmark(indexPath: IndexPath) -> UITableViewCell.AccessoryType  {
        if (ColorShema.colorShemaType.rawValue == indexPath.row) {
            return UITableViewCell.AccessoryType.checkmark
        } else {
           return UITableViewCell.AccessoryType.none
        }
    }
}
