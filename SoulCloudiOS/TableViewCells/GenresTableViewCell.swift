//
//  GenresTableViewCell.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 20/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit
import BEMCheckBox

class GenresTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBox: BEMCheckBox!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
