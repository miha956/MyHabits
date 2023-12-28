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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: "progressCell", for: indexPath) as! ProgressCollectionViewCell
        let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: "habitCell", for: indexPath) as! HabitCollectionViewCell
        
        switch indexPath.row {
        case 0 :
               progressCell.updateData(habitsStore: store)
                //progressCell.animateProgress()
            return progressCell
        default:
            habitCell.updateData(habits: store.habits, indexPath: indexPath)
            
            let habit = self.store.habits[indexPath.row - 1]
            
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
        if indexPath.row == 0 {
            return CGSize(width: view.frame.width - 30, height: 60)
        } else {
            return CGSize(width: view.frame.width - 30, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            guard let navigationController = navigationController else { return }
            let vc = HabitDetailsViewController()
            vc.updateData(indexPath: indexPath)
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
