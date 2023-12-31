//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 13.11.2023.
//

import UIKit

final class ProgressCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
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
        todayProgress.progress = 0
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
        self.todayProgress.layoutSubviews()
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
    
    public func animateProgress(habitsStore: HabitsStore) {
        let currrentProgress = Int(todayProgress.progress * 100)
        let duration: Double = 0.6
        if currrentProgress < (Int(habitsStore.todayProgress * 100)) {
            DispatchQueue.global().async {
                for i in currrentProgress ... (Int(habitsStore.todayProgress * 100)) {
                    let sleepTime = ((duration/Double(habitsStore.todayProgress * 100)) * 1000000.0)
                    usleep(useconds_t(sleepTime))
                    DispatchQueue.main.async {
                        self.progressCountLabel.text = "\(i)%"
                    }
                }
            }
        } else {
            var numbers = Array ((Int(habitsStore.todayProgress * 100))...currrentProgress)
            numbers.sort(by: >)
            DispatchQueue.global().async {
                for i in numbers {
                    if Double(habitsStore.todayProgress * 100) == 0 {
                        let sleepTime = ((duration / Double(100 / habitsStore.habits.count)) * 1000000.0)
                        usleep(useconds_t(sleepTime))
                    } else {
                        let sleepTime = ((duration / Double(habitsStore.todayProgress * 100)) * 1000000.0)
                        usleep(useconds_t(sleepTime))
                    }
                    DispatchQueue.main.async {
                        self.progressCountLabel.text = "\(i)%"
                    }
                }
            }
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.todayProgress.progress = habitsStore.todayProgress
            self.todayProgress.layoutSubviews()
        }
    }
}

