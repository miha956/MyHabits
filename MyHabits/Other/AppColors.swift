//
//  Colors.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 11.11.2023.
//

import Foundation
import UIKit

enum AppColors {

    case systemGray
    case systemGray2
    case lightGray
    case purpleColor
    case blueColor
    case greenColor
    case indigoColor
    case orangeColor
    
    var color: UIColor {
        switch self {
        case .systemGray: return .systemGray
        case .systemGray2: return .systemGray2
        case .lightGray: return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        case .purpleColor: return UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
        case .blueColor: return UIColor(red: 41/255, green: 109/255, blue: 255/255, alpha: 1)
        case .greenColor: return UIColor(red: 29/255, green: 179/255, blue: 34/255, alpha: 1)
        case .indigoColor: return UIColor(red: 98/255, green: 54/255, blue: 255/255, alpha: 1)
        case .orangeColor: return UIColor(red: 255/255, green: 159/255, blue: 79/255, alpha: 1)
            
        }
    }
    
}
