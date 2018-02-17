//
//  UIImasgeView+Extension.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func circleImage() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
    
    func loadImageWithURL(urlString: String) {
        if let myUrl = URL(string: urlString) {
            URLSession.shared.dataTask(with: myUrl, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                print("Size of retrived photos is \((data?.count)!/1024)KB")
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }).resume()
        }
        
    }
}
