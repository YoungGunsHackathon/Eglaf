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
    @IBOutlet weak var button: UIButton!
    
    class func instanceFromNib() -> ResponseView {
        return UINib(nibName: "ResponseView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ResponseView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func conformResponse(name: String) {
        descriptionLabel.text = "Access confirmed"
        nameLabel.text = name
    }
    
    func notConformResponse() {
        descriptionLabel.text = "Access denied"
        descriptionLabel.textColor = .red
        nameLabel.text = ""
        conformImageView.image = UIImage(named: "CloseRed")
    }
}
