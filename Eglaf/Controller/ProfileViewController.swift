//
//  ProfileViewController.swift
//  Eglaf
//
//  Created by Zvada, Adam on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, StoryboardInit {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavBar()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2.0
        profileImageView.clipsToBounds = true
        editButton.backgroundColor = .white
        editButton.layer.cornerRadius = editButton.frame.size.width / 2.0
    }
    
    func prepareNavBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0.1, blue: 0.22, alpha: 1)
        //self.navigationController?.view.backgroundColor = UIColor.red
        self.navigationItem.title = "MY PROFILE"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Regular", size: 14)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.kern: 4
        ]
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        
    }
}
