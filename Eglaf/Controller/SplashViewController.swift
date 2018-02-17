//
//  SplashViewController.swift
//  Eglaf
//
//  Created by Zvada, Adam on 17.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

class SplashViewController: UIViewController, StoryboardInit {
    
    @IBOutlet weak var youRockLabel: UILabel!
    
    override func viewDidLoad() {
        let string = "YOU ROCK!"
        let attributedString = NSAttributedString(string: string, attributes: [
            NSAttributedStringKey.kern: 2
            ])
        youRockLabel.attributedText = attributedString
    }
}
