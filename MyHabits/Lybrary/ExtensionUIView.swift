//
//  File.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 23.12.2023.
//

import Foundation
import UIKit

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.addSubview(i)
        }
    }
}

public extension UICollectionViewCell {
    func addContentSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.contentView.addSubview(i)
        }
    }
}
