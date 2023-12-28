//
//  DatesTableViewCell.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 28.12.2023.
//

import UIKit

class DatesTableViewCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = .systemFont(ofSize: 17, weight: .regular)
        dateLabel.textColor = .black
        return dateLabel
    }()
    private let isTackedLabel: UILabel = {
        let isTackedLabel = UILabel()
        isTackedLabel.translatesAutoresizingMaskIntoConstraints = false
        isTackedLabel.text = "\u{2713}"
        isTackedLabel.isHidden = true
        isTackedLabel.font = .systemFont(ofSize: 17, weight: .bold)
        isTackedLabel.textColor = .appPurple
        return isTackedLabel
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,reuseIdentifier: reuseIdentifier)
        
        tuneView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func tuneView() {
        backgroundColor = .white
    }
    
    private func addSubviews() {
        addContentSubviews(dateLabel,
                           isTackedLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            isTackedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            isTackedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // MARK: - Public
    
    public func updateData(date: String, chackmark: Bool) {
        dateLabel.text = date
        if chackmark == true {
            isTackedLabel.isHidden = false
        } else {
            isTackedLabel.isHidden = true
        }
        
    }
}
