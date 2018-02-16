//
//  CategoryCollectionViewCell.swift
//  Eglaf
//
//  Created by Zvada, Adam on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    var cellColor = UIColor(red:0.27, green:0.71, blue:0.77, alpha:1)
    var categoryType: IssueCategory = .catering {
        didSet {
            self.categoryNameLabel.text = categoryType.rawValue
            self.categoryNameLabel.textColor = categoryType.categoryColor
            self.bgView.layer.borderColor = categoryType.categoryColor.cgColor
        }
    }
    var inverted = false {
        didSet {
            if oldValue != inverted {
                self.categoryNameLabel.textColor = inverted ? .white : categoryType.categoryColor
                self.bgView.backgroundColor = inverted ? categoryType.categoryColor : .clear
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.borderWidth = 1
        self.bgView.layer.borderColor = cellColor.cgColor
        self.categoryNameLabel.textColor = cellColor
        self.bgView.layer.cornerRadius = 4
    }

}
