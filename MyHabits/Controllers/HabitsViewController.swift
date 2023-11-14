//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 11.11.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private var habitsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.lightGray.color
        
        addHabitButton()
        setHabitsCollection()
        
        title = "Сегодня"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: - addHabitButton
    
    private func addHabitButton() {
        let addHabitButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped))
        addHabitButton.tintColor = AppColors.purpleColor.color
        navigationItem.rightBarButtonItem = addHabitButton
    }
    
    @objc func addButtonTapped() {
        // Код, который выполнится при нажатии на кнопку
    }
}
    
    // MARK: - habitsCollection

extension HabitsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0 :
            let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: "progressCell", for: indexPath) as! ProgressCollectionViewCell
            return progressCell
        default:
            let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: "habitCell", for: indexPath) as! HabitCollectionViewCell

            return habitCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: 500, height: 50)
        } else {
            return CGSize(width: 500, height: 500)
        }
    }
    
    
    private func setHabitsCollection() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset.top = 25
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: view.bounds.width, height: 130)
        habitsCollection = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: layout)
        habitsCollection.dataSource = self
        habitsCollection.delegate = self
        habitsCollection.translatesAutoresizingMaskIntoConstraints = false
        habitsCollection.isScrollEnabled = true
        habitsCollection.backgroundColor = AppColors.lightGray.color
        habitsCollection.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: "habitCell")
        habitsCollection.register(
            ProgressCollectionViewCell.self,
            forCellWithReuseIdentifier: "progressCell")
        habitsCollection.showsHorizontalScrollIndicator = false
        habitsCollection.showsVerticalScrollIndicator = false
        
        self.view.addSubview(habitsCollection)
        NSLayoutConstraint.activate([
            habitsCollection.topAnchor.constraint(equalTo: self.view.topAnchor),
            habitsCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            habitsCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            habitsCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
    }
}
