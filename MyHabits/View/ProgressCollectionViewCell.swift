//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 13.11.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
