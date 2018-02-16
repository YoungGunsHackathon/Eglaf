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
    
    var controllers = [UIViewController]()
    let qrViewController = QRViewController.storyboardInit()
    let homeViewController = HomeViewController.storyboardInit()
    let profileViewController = ProfileViewController.storyboardInit()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        prepareTabBar()
        prepareUI()
    }
}

extension TabBarViewController {
    func prepareTabBar() {
        homeViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "dashboard"), selectedImage: nil)
        homeViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        qrViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "scan"), selectedImage: nil)
        qrViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        profileViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "profile"), selectedImage: nil)
        profileViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        controllers.append(homeViewController)
        controllers.append(qrViewController)
        controllers.append(profileViewController)
        
        controllers = controllers.map { UINavigationController(rootViewController: $0)}
        self.setViewControllers(controllers, animated: false)
    }
}

//MARK: - TabBarViewController (UI)

extension TabBarViewController {
    func prepareUI() {
        self.tabBar.barTintColor = UIColor(red: 0, green: 0.1, blue: 0.22, alpha: 1)
        self.tabBar.tintColor = .white
        self.tabBar.isTranslucent = false
    }
}
