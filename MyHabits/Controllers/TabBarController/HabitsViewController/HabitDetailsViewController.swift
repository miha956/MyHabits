//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 27.12.2023.
//

import UIKit

final class HabitDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private var habitIndexPath: IndexPath?
    let store = HabitsStore.shared
    
    // MARK: - Subviews
    
    private let datesTableView: UITableView = {
        let datesTableView = UITableView(frame: .zero, style: .grouped)
        datesTableView.translatesAutoresizingMaskIntoConstraints = false
        datesTableView.backgroundColor = .clear
        datesTableView.allowsSelection = false
        return datesTableView
    }()
    private lazy var editHabitButton: UIBarButtonItem = {
        let editHabitButton = UIBarButtonItem(title: "Править",
                                              style: .plain,
                                              target: self,
                                              action: #selector(editButtonTapped))
        editHabitButton.tintColor = .appPurple
        return editHabitButton
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tuneView()
        addSabview()
        tuneTableView()
        setupConstraints()
    }
    
    // MARK: -  Actions
    
    @objc private func editButtonTapped() {
        
        guard let navigationController = navigationController else { return }
        guard let habitIndexPath = habitIndexPath else { return }
        let vc = HabitViewController(state: .edit)
        vc.updateData(store: store, indexPath: habitIndexPath)
        navigationController.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private
    
    private func tuneView() {
        view.backgroundColor = .appLightGray
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func tuneTableView() {
        datesTableView.delegate = self
        datesTableView.dataSource = self
        datesTableView.register(DatesTableViewCell.self, forCellReuseIdentifier: "dateCell")
    }
    
    private func addSabview() {
        view.addSubviews(datesTableView)
        navigationItem.rightBarButtonItem = editHabitButton
    }
    
    private func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            datesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            datesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datesTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Public
    
    public func updateData(indexPath: IndexPath) {
        title = store.habits[indexPath.row - 1].name
        habitIndexPath = indexPath
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        store.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateCell = datesTableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as! DatesTableViewCell
        let chackmark = store.habit(store.habits[(habitIndexPath?.row ?? 0) - 1], isTrackedIn: store.dates.sorted(by: >)[indexPath.row])
        let date = store.trackDateString(forIndex: store.dates.count - indexPath.row - 1) ?? "error"
            dateCell.updateData(date: date, chackmark: chackmark)
        return dateCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }
}
