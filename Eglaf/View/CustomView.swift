//
//  CustomView.swift
//  Eglaf
//
//  Created by Adam Zvada on 17.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomView: UIView {
    
    // Our custom view from the XIB file
    var view: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = instanceFromNib()
        self.addSubview(view)
        
        // Layout
        view.translatesAutoresizingMaskIntoConstraints = false
        let views: [String : Any] = [
            "view" : view
        ]
        let horizonalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", metrics: nil, views: views)
        NSLayoutConstraint.activate(horizonalConstraints)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", metrics: nil, views: views)
        NSLayoutConstraint.activate(verticalConstraints)
    }
    
    func instanceFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibFileName(), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    // Override if xib name is different than class name
    func nibFileName() -> String {
        return String(describing: type(of:self))
    }
}

