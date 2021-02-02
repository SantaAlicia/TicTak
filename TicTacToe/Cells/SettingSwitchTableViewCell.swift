//
//  SettingSwitchTableViewCell.swift
//  Tic-Tac-Toe
//
//  Created by liudmila vladimirova on 15/03/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit

class SettingSwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var checkmarkImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
    }

   override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }
}
