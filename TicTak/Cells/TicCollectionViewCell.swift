//
//  TicCollectionViewCell.swift
//  TicTak
//
//  Created by liudmila vladimirova on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

class TicCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var imgView: UIImageView!
    var cell : Cell?
    
    func emptyCell() {
        cell = Cell()
        cell?.emptyCell()
        fillCell()
    }
    
    func crossCell() {
        cell = Cell()
        cell?.crossCell()
        fillCell()
    }
    
    func fillCell() {
        if cell != nil {
            imgView.image = cell?.image
            imgView.backgroundColor = cell?.backgroundColor
        }
    }
}

