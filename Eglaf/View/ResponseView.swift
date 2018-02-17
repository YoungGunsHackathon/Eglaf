//
//  ResponseView.swift
//  Eglaf
//
//  Created by Adam Zvada on 17.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import UIKit

class ResponseView: UIView {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var conformImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func conformResponse(name: String) {
        descriptionLabel.text = "Access confirm"
        nameLabel.text = name
    }
    
    func notConformResponse() {
        descriptionLabel.text = "Access denided"
        conformImageView.image = UIImage(named: "")
    }
    
}
