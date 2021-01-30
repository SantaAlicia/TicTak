//
//  ColorSchemaTableViewCell.swift
//  Tic-Tac-Toe
//
//  Created by liudmila vladimirova on 16/01/2021.
//  Copyright © 2021 SantaAlicia. All rights reserved.
//

import UIKit

class ColorSchemaTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var colotSchemaTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
