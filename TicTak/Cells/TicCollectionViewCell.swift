//
//  TicCollectionViewCell.swift
//  TicTak
//
//  Created by liudmila vladimirova on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

class TicCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var imageView: UIImageView!
    
    func fillCell(cell : Cell) {
        
        switch cell.type {
        case CellType.empty:
            imageView.image = nil
            
        case CellType.cross:
            imageView.image = UIImage(named: "cross")
            
        case CellType.zero:
            imageView.image = UIImage(named: "zero")
            
        default:
            imageView.image = nil
        }
    }
}

