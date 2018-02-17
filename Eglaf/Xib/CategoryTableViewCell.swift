//
//  CategoryTableViewCell.swift
//  Eglaf
//
//  Created by Zvada, Adam on 17.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    var categoryType: IssueCategory = .catering {
        didSet {
            self.categoryNameLabel.text = categoryType.rawValue
            self.bgView.layer.borderColor = categoryType.categoryColor.cgColor
            self.categoryNameLabel.textColor = isSelected ? .white : categoryType.categoryColor
            self.bgView.backgroundColor = isSelected ? categoryType.categoryColor : UIColor(red: 0, green: 0.1, blue: 0.22, alpha: 1)

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.borderWidth = 1
        self.bgView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectedBackgroundView?.backgroundColor = .clear
        self.categoryNameLabel.textColor = isSelected ? .white : categoryType.categoryColor
        self.bgView.backgroundColor = isSelected ? categoryType.categoryColor : UIColor(red: 0, green: 0.1, blue: 0.22, alpha: 1)

    }
    
}
