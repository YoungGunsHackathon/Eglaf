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
        prepareTabBar()
        prepareUI()
    }
}

extension TabBarViewController {
    func prepareTabBar() {
        qrViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "scan"), selectedImage: nil)
        qrViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        self.setViewControllers([qrViewController], animated: false)
    }
}

//MARK: - TabBarViewController (UI)

extension TabBarViewController {
    func prepareUI() {
        self.tabBar.barTintColor = UIColor(red: 0, green: 0.1, blue: 0.22, alpha: 1)
        self.tabBar.tintColor = .white
        self.tabBar.isTranslucent = false
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 30, width: view.frame.size.width, height: 120))
        navBar.barTintColor = UIColor(red:0, green:0.1, blue:0.22, alpha:1)
        navBar.isTranslucent = false
        
        
        
        let navItem = UINavigationItem(title: "SomeTitle")
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
}
