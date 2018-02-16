//
//  TabBarViewController.swift
//  Eglaf
//
//  Created by Zvada, Adam on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    //MARK: Propertiess
    
    let qrViewController = QRViewController.storyboardInit()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        qrViewController.tabBarItem = UITabBarItem(title: "QR", image: nil, selectedImage: nil)
        qrViewController.tabBarItem.tag = 0
        
        self.setViewControllers([qrViewController], animated: false)
    }
}
