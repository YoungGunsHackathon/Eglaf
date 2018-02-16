//
//  StoryboardInit.swift
//  Eglaf
//
//  Created by Zvada, Adam on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardInit { }

public extension StoryboardInit where Self: UIViewController {
    static func storyboardInit() -> Self {
        guard let rootVc = UIStoryboard(name: String(describing: self), bundle: Bundle(for: self)).instantiateInitialViewController() else {
            assertionFailure("No initial view controller \(String(describing: self))")
            return Self()
        }
        
        guard let vc = rootVc as? Self else {
            assertionFailure("Unknown root view controller \(rootVc)")
            return Self()
        }
        
        return vc
    }
}
