//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 13.11.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    let nameLabel:  UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "nameLabel"
        return nameLabel
    }()
    let repeatDateLabel: UILabel = {
        let repeatDateLabel = UILabel()
        repeatDateLabel.translatesAutoresizingMaskIntoConstraints = false
        repeatDateLabel.text = "Каждый день в"
        return repeatDateLabel
    }()
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "7:30"
        return dateLabel
    }()
    let counterLabel: UILabel = {
        let counterLabel = UILabel()
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.text = "Счетчик:"
        return counterLabel
    }()
    let counterNumber: UILabel = {
        let counter = UILabel()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.text = "2"
        return counter
    }()
    let trackHabitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHabitCollectionCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: - setupCollectionCell
    
    private func setupHabitCollectionCell() {
        self.backgroundColor = .white
        
        self.contentView.addSubview(nameLabel)
        nameLabel.textColor = AppColors.blueColor.color
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        ])
       
        self.contentView.addSubview(repeatDateLabel)
        repeatDateLabel.textColor = .systemGray2
        repeatDateLabel.textAlignment = .left
        repeatDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        NSLayoutConstraint.activate([
            repeatDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            repeatDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        self.contentView.addSubview(dateLabel)
        dateLabel.textColor = .systemGray2
        dateLabel.textAlignment = .left
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: repeatDateLabel.trailingAnchor, constant: 4)
        ])
        
        self.contentView.addSubview(counterLabel)
        counterLabel.textColor = .systemGray
        counterLabel.textAlignment = .left
        counterLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        NSLayoutConstraint.activate([
            counterLabel.topAnchor.constraint(equalTo: repeatDateLabel.bottomAnchor, constant: 30),
            counterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        self.contentView.addSubview(counterNumber)
        counterNumber.textColor = .systemGray
        counterNumber.textAlignment = .left
        counterNumber.font = .systemFont(ofSize: 13, weight: .semibold)
        NSLayoutConstraint.activate([
            counterNumber.topAnchor.constraint(equalTo: repeatDateLabel.bottomAnchor, constant: 30),
            counterNumber.leadingAnchor.constraint(equalTo: counterLabel.trailingAnchor, constant: 4)
        ])
        
        self.addSubview(trackHabitButton)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 38)
        let symbolImage = UIImage(systemName: "circle", withConfiguration: symbolConfiguration)
        trackHabitButton.setImage(symbolImage, for: .normal)
        trackHabitButton.setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
        trackHabitButton.tintColor = .brown
        NSLayoutConstraint.activate([
            trackHabitButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            trackHabitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            trackHabitButton.heightAnchor.constraint(equalToConstant: 38),
            trackHabitButton.widthAnchor.constraint(equalToConstant: 38)
        ])
    }
    
}
