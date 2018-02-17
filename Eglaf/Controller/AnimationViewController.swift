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
        print("CALLED")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("I was first")
        super.viewDidAppear(animated)
        let animationView = LOTAnimationView(name: "data")
        animationView.loopAnimation = false
        self.view.addSubview(animationView)
        self.view.bringSubview(toFront: animationView)
        animationView.center = CGPoint(x: view.frame.width / 2.0, y: view.frame.height / 2.0)
        animationView.play { (completion) in
            UIView.transition(with: self.view, duration: 0.2, options: [.transitionCrossDissolve], animations: {
                animationView.removeFromSuperview()
                self.dismiss(animated: true, completion: nil)
            }, completion: nil)
        }
    }
}
