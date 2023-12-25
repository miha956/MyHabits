//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 13.11.2023.
//

import UIKit

final class HabitCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var tapTrackHabit: (() -> Void)?
    
    // MARK: - Subviews
    
    private let nameLabel:  UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        nameLabel.text = "nameLabel"
        return nameLabel
    }()
    private let repeatDateLabel: UILabel = {
        let repeatDateLabel = UILabel()
        repeatDateLabel.translatesAutoresizingMaskIntoConstraints = false
        repeatDateLabel.textColor = .systemGray2
        repeatDateLabel.textAlignment = .left
        repeatDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        repeatDateLabel.text = "Каждый день в"
        return repeatDateLabel
    }()
    private let counterLabel: UILabel = {
        let counterLabel = UILabel()
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.textColor = .systemGray
        counterLabel.textAlignment = .left
        counterLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        counterLabel.text = "Счетчик:"
        return counterLabel
    }()
    private let counterNumber: UILabel = {
        let counterNumber = UILabel()
        counterNumber.translatesAutoresizingMaskIntoConstraints = false
        counterNumber.textColor = .systemGray
        counterNumber.textAlignment = .left
        counterNumber.font = .systemFont(ofSize: 13, weight: .semibold)
        counterNumber.text = "2"
        return counterNumber
    }()
    lazy var trackHabitButton: UIButton = {
        let trackHabitButton = UIButton(type: .system)
        trackHabitButton.translatesAutoresizingMaskIntoConstraints = false
        trackHabitButton.addTarget(self, action: #selector(trackHabitButtonTapped), for: .touchUpInside)
        return trackHabitButton
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func trackHabitButtonTapped() {
        tapTrackHabit?()
    }
    
    // MARK: - Private
    
    private func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
     }
    
    private func addSubviews() {
        
        self.addContentSubviews(nameLabel,
                                repeatDateLabel,
                                counterLabel,
                                counterNumber,
                                trackHabitButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            repeatDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            repeatDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            counterLabel.topAnchor.constraint(equalTo: repeatDateLabel.bottomAnchor, constant: 30),
            counterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            counterNumber.topAnchor.constraint(equalTo: repeatDateLabel.bottomAnchor, constant: 30),
            counterNumber.leadingAnchor.constraint(equalTo: counterLabel.trailingAnchor, constant: 4),
            trackHabitButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            trackHabitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            trackHabitButton.heightAnchor.constraint(equalToConstant: 38),
            trackHabitButton.widthAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    // MARK: - Public
    
    public func updateData(habits: [Habit], indexPath: IndexPath) {
        nameLabel.text = habits[indexPath.row - 1].name
        nameLabel.textColor = habits[indexPath.row - 1].color
        trackHabitButton.tintColor = habits[indexPath.row - 1].color
        repeatDateLabel.text = habits[indexPath.row - 1].dateString
        counterNumber.text = String(habits[indexPath.row - 1].trackDates.count)
        if habits[indexPath.row - 1].isAlreadyTakenToday == true {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 38)
            let symbolImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: symbolConfiguration)
            trackHabitButton.setImage(symbolImage, for: .normal)
            trackHabitButton.setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
        } else {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 38)
            let symbolImage = UIImage(systemName: "circle", withConfiguration: symbolConfiguration)
            trackHabitButton.setImage(symbolImage, for: .normal)
            trackHabitButton.setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
        }
    }
}
