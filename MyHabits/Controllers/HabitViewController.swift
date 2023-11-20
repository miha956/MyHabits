//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 18.11.2023.
//

import UIKit

class HabitViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let habitName: UILabel = {
        let habitName = UILabel()
        habitName.translatesAutoresizingMaskIntoConstraints = false
        habitName.text = "Название"
        return habitName
    }()
    let habitNameTextField: UITextField = {
        let habitTextField = UITextField()
        habitTextField.placeholder = "Бегать по утрам, спать 8 и т.п."
        habitTextField.font = .systemFont(ofSize: 17, weight: .semibold)
        habitTextField.translatesAutoresizingMaskIntoConstraints = false
        return habitTextField
    }()
    let colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.text = "ЦВЕТ"
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        return colorLabel
    }()
    let colorPickerButton: UIButton = {
        let colorPickerButton = UIButton(type: .system)
        colorPickerButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        colorPickerButton.backgroundColor = .orange
        colorPickerButton.layer.cornerRadius = colorPickerButton.frame.height/2
        colorPickerButton.clipsToBounds = true
        
        colorPickerButton.translatesAutoresizingMaskIntoConstraints = false
        return colorPickerButton
    }()
    let timelabel: UILabel = {
        let timelabel = UILabel()
        timelabel.text = "ВРЕМЯ"
        timelabel.translatesAutoresizingMaskIntoConstraints = false
        return timelabel
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
        dateLabel.text = "--:--"
        return dateLabel
    }()
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.contentMode = .scaleAspectFill
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    deinit {
        print("HabitViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "Создать"
        setHabitView()
        saveHabitButton()
        
    }
    

    
    // MARK: - setHabitView
    
    private func setHabitView() {
        
        colorPickerButton.addTarget(self, action: #selector(pickColor), for: .touchUpInside)
        datePicker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
        habitNameTextField.textColor = colorPickerButton.backgroundColor
        
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)

        ])
        
        scrollView.addSubview(habitName)
        NSLayoutConstraint.activate([
            habitName.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 21),
            habitName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16)
            
        ])
        scrollView.addSubview(habitNameTextField)
        NSLayoutConstraint.activate([
            habitNameTextField.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 7),
            habitNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            habitNameTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 16)
        ])
        scrollView.addSubview(colorLabel)
        NSLayoutConstraint.activate([
            colorLabel.topAnchor.constraint(equalTo: habitNameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16)
        ])
        scrollView.addSubview(colorPickerButton)
        NSLayoutConstraint.activate([
            colorPickerButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorPickerButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16)
        ])
        scrollView.addSubview(timelabel)
        NSLayoutConstraint.activate([
            timelabel.topAnchor.constraint(equalTo: colorPickerButton.bottomAnchor, constant: 15),
            timelabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16)
        ])
        scrollView.addSubview(repeatDateLabel)
        NSLayoutConstraint.activate([
            repeatDateLabel.topAnchor.constraint(equalTo: timelabel.bottomAnchor, constant: 7),
            repeatDateLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16)
        ])
        scrollView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: timelabel.bottomAnchor, constant: 7),
            dateLabel.leadingAnchor.constraint(equalTo: repeatDateLabel.trailingAnchor, constant: 4)
        ])
        scrollView.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            datePicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    // MARK: - saveHabitButton
    
    private func saveHabitButton() {
        
        let saveHabitButton = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveHabitButtonTapped))
        saveHabitButton.tintColor = .appPurple
        navigationItem.rightBarButtonItem = saveHabitButton
    
    }
    
    @objc func saveHabitButtonTapped() {
        
//        let newHabit = Habit(name: "Выпить стакан воды перед завтраком",
//                             date: Date(),
//                             color: .systemRed)
//        let store = HabitsStore.shared
//        store.habits.append(newHabit)

    }
}

    // MARK: - ColorPicker

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorPickerButton.backgroundColor = viewController.selectedColor
        habitNameTextField.textColor = viewController.selectedColor
    }
    
    @objc func pickColor() {
        
        let colorPicker = UIColorPickerViewController()
            colorPicker.title = "Background Color"
            colorPicker.supportsAlpha = false
            colorPicker.delegate = self
            guard let buttonColor = colorPickerButton.backgroundColor else { return }
            colorPicker.selectedColor = buttonColor
            colorPicker.modalPresentationStyle = .popover
            self.present(colorPicker, animated: true)
    }
    
    // MARK: - datePicker
    
    @objc func datePicked() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let locationTime = dateFormatter.string(from: datePicker.date)
        dateLabel.text = locationTime
    }

}
