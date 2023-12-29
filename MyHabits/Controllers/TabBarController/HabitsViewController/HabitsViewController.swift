//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 11.11.2023.
//

import UIKit

final class HabitsViewController: UIViewController {
    
    // MARK: - Properties
    
    let store = HabitsStore.shared
    
    // MARK: - Subviews
    
    private var habitsCollection: UICollectionView!
    private lazy var addHabitButton: UIBarButtonItem = {
        let addHabitButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped))
        addHabitButton.tintColor = .appPurple
        return addHabitButton
    }()
    private lazy var congratulationView: UIView = {
        let congratulationView = UIView(frame: CGRect(x: UIScreen.main.bounds.midX - 125, y: UIScreen.main.bounds.midY - 125, width: 250, height: 250))
        //congratulationView.translatesAutoresizingMaskIntoConstraints = false
        congratulationView.backgroundColor = .appPurple
        congratulationView.layer.cornerRadius = congratulationView.frame.height/10
        congratulationView.clipsToBounds = true
        congratulationView.alpha = 0
        return congratulationView
    }()
    let congratulationLabel: UILabel = {
        let congratulationLabel = UILabel()
        congratulationLabel.text = 
        """
        Поздравляем!
        
        Вы выполнили все привычки.
        
        Так держать!

        """
        congratulationLabel.translatesAutoresizingMaskIntoConstraints = false
        congratulationLabel.numberOfLines = 0
        return congratulationLabel
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tuneView()
        tuneCollectionView()
        addSabviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        habitsCollection.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: - Private
    
    private func addSabviews() {
        navigationItem.rightBarButtonItem = addHabitButton
        self.view.addSubview(habitsCollection)
    }
    
    private func showCongratulationView() {
        self.view.addSubview(congratulationView)
        self.view.bringSubviewToFront(congratulationView)
        congratulationView.addSubview(congratulationLabel)
        NSLayoutConstraint.activate([
            congratulationLabel.topAnchor.constraint(equalTo: congratulationView.topAnchor, constant: 16),
            congratulationLabel.leadingAnchor.constraint(equalTo: congratulationView.leadingAnchor, constant: 16),
            congratulationLabel.trailingAnchor.constraint(equalTo: congratulationView.trailingAnchor, constant: -16),
            congratulationLabel.bottomAnchor.constraint(equalTo: congratulationView.bottomAnchor, constant: -16),
        ])
    }
    
    private func tuneCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset.top = 25
        layout.minimumLineSpacing = 12
        habitsCollection = UICollectionView(frame: self.view.bounds,
                                            collectionViewLayout: layout)
        habitsCollection.dataSource = self
        habitsCollection.delegate = self
        habitsCollection.translatesAutoresizingMaskIntoConstraints = false
        habitsCollection.isScrollEnabled = true
        habitsCollection.backgroundColor = .appLightGray
        habitsCollection.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: "habitCell")
        habitsCollection.register(
            ProgressCollectionViewCell.self,
            forCellWithReuseIdentifier: "progressCell")
        habitsCollection.showsHorizontalScrollIndicator = false
        habitsCollection.showsVerticalScrollIndicator = false
    }
    
    private func tuneView() {
        view.backgroundColor = .appLightGray
        title = "Сегодня"
    }
    
    private func setupConstraints() {
    
        NSLayoutConstraint.activate([
            habitsCollection.topAnchor.constraint(equalTo: self.view.topAnchor),
            habitsCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            habitsCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            habitsCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
    }
    
    // MARK: - Actions
    
    @objc func addButtonTapped() {
        
        guard let navigationController = navigationController else { return }
        let vc = HabitViewController(state: .create)
        navigationController.pushViewController(vc, animated: true)
    }
}
    


extension HabitsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1 :
            return HabitsStore.shared.habits.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: "progressCell", for: indexPath) as! ProgressCollectionViewCell
        let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: "habitCell", for: indexPath) as! HabitCollectionViewCell
        
        switch indexPath.section {
        case 0 :
            progressCell.animateProgress(habitsStore: store)
            if store.todayProgress == 1 {
                UIView.animate(withDuration: 1) {
                    self.showCongratulationView()
                    self.congratulationView.alpha = 1
                }
            }
            return progressCell
        default:
            
            habitCell.updateData(habits: store.habits, indexPath: indexPath)
            let habit = self.store.habits[indexPath.row]
            habitCell.tapTrackHabit = {
                if habit.isAlreadyTakenToday {
                    print("уже затрекана")
                    habit.trackDates.removeLast()
                    self.store.save()
                    collectionView.reloadData()
                } else {
                    print("трекаем привычку")
                    self.store.track(habit)
                    collectionView.reloadData()
                }
            }
            return habitCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width - 30, height: 60)
        } else {
            return CGSize(width: view.frame.width - 30, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            guard let navigationController = navigationController else { return }
            let vc = HabitDetailsViewController()
            vc.updateData(indexPath: indexPath)
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
