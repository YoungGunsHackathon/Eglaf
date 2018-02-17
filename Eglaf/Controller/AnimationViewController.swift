//
//  AnimationViewController.swift
//  Eglaf
//
//  Created by Zvada, Adam on 17.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class AnimationViewController: UIViewController {
    override func viewDidLoad() {
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let animationView = LOTAnimationView(name: "data")
        animationView.loopAnimation = false
        animationView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.view.addSubview(animationView)
        self.view.bringSubview(toFront: animationView)
        animationView.center = CGPoint(x: view.frame.width / 2.0, y: view.frame.height / 2.0)
        animationView.play { (completion) in
            self.view.window?.rootViewController = TabBarViewController()
//            UIView.transition(with: self.view.window!, duration: 2, options: [.transitionCrossDissolve], animations: {
//                self.view.window?.rootViewController = TabBarViewController()
//            }, completion: nil)
        }
    }
}
