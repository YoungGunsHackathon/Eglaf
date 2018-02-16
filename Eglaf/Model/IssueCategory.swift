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
            return UIColor(red:0.27, green:0.71, blue:0.77, alpha:1)
        case .scanning:
            return UIColor(red:1, green:0.95, blue:0.33, alpha:1)
        case .infoPoint:
            return UIColor(red:0.73, green:0.53, blue:0.99, alpha:1)
        case .security:
            return UIColor(red:1, green:0.62, blue:0.35, alpha:1)
        case .registration:
            return UIColor(red:0.45, green:1, blue:0.6, alpha:1)
        case .other:
            return UIColor(red:0.45, green:1, blue:0.6, alpha:1)
        }
    }
}
