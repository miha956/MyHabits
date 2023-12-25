//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 13.11.2023.
//

import UIKit

final class ProgressCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let store = HabitsStore.shared
    
    // MARK: - Subviews
    
    private let mottoLabel: UILabel = {
        let mottoLabel = UILabel()
        mottoLabel.text = "Все получится!"
        mottoLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        mottoLabel.textColor = .systemGray
        
        mottoLabel.translatesAutoresizingMaskIntoConstraints = false
        return mottoLabel
    }()
    private let progressCountLabel: UILabel = {
        let progressCountLabel = UILabel()
        progressCountLabel.text = "50%"
        progressCountLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        progressCountLabel.textColor = .systemGray
        progressCountLabel.translatesAutoresizingMaskIntoConstraints = false
        return progressCountLabel
    }()
    private let todayProgress: UIProgressView = {
        let todayProgress = UIProgressView()
        todayProgress.translatesAutoresizingMaskIntoConstraints = false
        todayProgress.clipsToBounds = true
        todayProgress.layer.cornerRadius = 5
        todayProgress.layer.sublayers?[1].cornerRadius = 5
        todayProgress.subviews[1].clipsToBounds = true
        todayProgress.trackTintColor = .appTodayProgressTrackTint
        todayProgress.progressTintColor = .appPurple
        todayProgress.progress = 0.5
        
        return todayProgress
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tuneView()
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func tuneView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        todayProgress.progress = store.todayProgress
        progressCountLabel.text = "\(todayProgress.progress)%"
    }
    
    private func addSubViews() {
        addContentSubviews(mottoLabel,
                    progressCountLabel,
                    todayProgress
        )
    }
    
    private func setupConstraints() {

        
        NSLayoutConstraint.activate([
            mottoLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            mottoLabel.heightAnchor.constraint(equalToConstant: 18),
            mottoLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            progressCountLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            progressCountLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            todayProgress.topAnchor.constraint(equalTo: mottoLabel.bottomAnchor, constant: 10),
            todayProgress.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            todayProgress.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            todayProgress.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])  
    }
    
    // MARK: - Public
    public func updateData(habitsStore: HabitsStore) {
        let store = HabitsStore.shared
        todayProgress.progress = store.todayProgress
        progressCountLabel.text = "\(Int(store.todayProgress * 100))%"
    }
}
