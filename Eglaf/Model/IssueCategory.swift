//
//  IssueCategory.swift
//  Eglaf
//
//  Created by Zvada, Adam on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit

enum IssueCategory: String {
    case catering = "#CATERING"
    case scanning = "#SCANNING"
    case infoPoint = "#INFO POINT"
    case security = "#SECURITY"
    case registration = "#REGISTRATION"
    case other = "#OTHER"
    
    var categoryColor: UIColor {
        switch self {
        case .catering:
            return UIColor(red:0, green:0.48, blue:1, alpha:1)
        case .scanning:
            return UIColor(red:0.91, green:0.73, blue:0, alpha:1)
        case .infoPoint:
            return UIColor(red:0.64, green:0.37, blue:1, alpha:1)
        case .security:
            return UIColor(red:1, green:0.58, blue:0, alpha:1)
        case .registration:
            return UIColor(red:0.35, green:0.43, blue:0.52, alpha:1)
        case .other:
            return UIColor(red:0.3, green:0.85, blue:0.39, alpha:1)
        }
    }
}
