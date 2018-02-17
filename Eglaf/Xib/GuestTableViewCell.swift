//
//  GuestTableViewCell.swift
//  Eglaf
//
//  Created by Adam Zvada on 17.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import UIKit

class GuestTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
