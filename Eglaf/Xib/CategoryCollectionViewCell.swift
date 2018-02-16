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
    var categoryType: IssueCategory = .catering {
        didSet {
            self.categoryNameLabel.text = categoryType.rawValue
            self.bgView.layer.borderColor = categoryType.categoryColor.cgColor
            self.categoryNameLabel.textColor = isSelected ? .white : categoryType.categoryColor
            self.bgView.backgroundColor = isSelected ? categoryType.categoryColor : .clear
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if oldValue != isSelected {
                self.categoryNameLabel.textColor = isSelected ? .white : categoryType.categoryColor
                self.bgView.backgroundColor = isSelected ? categoryType.categoryColor : .clear
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.borderWidth = 1
        //self.bgView.layer.borderColor = categoryType.categoryColor.cgColor
        self.bgView.layer.cornerRadius = 4
    }

}
