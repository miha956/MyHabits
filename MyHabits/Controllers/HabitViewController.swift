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
    let habitTextField: UITextField = {
        let habitTextField = UITextField()
        habitTextField.placeholder = "Бегать по утрам, спать 8 и т.п."
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
        dateLabel.text = "7:30"
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
    
    let colorPicker = UIColorPickerViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "Создать"
        setHabitView()
        colorPickerButton.addTarget(self, action: #selector(pickColor), for: .touchUpInside)
    }
    
    @objc func pickColor() {
        
        let colorPicker = UIColorPickerViewController()
            colorPicker.title = "Background Color"
            colorPicker.supportsAlpha = false
            colorPicker.delegate = self
            colorPicker.modalPresentationStyle = .popover
        if #available(iOS 16.0, *) {
            colorPicker.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
        } else {
            // Fallback on earlier versions
        }
            self.present(colorPicker, animated: true)
    }
    
    private func setHabitView() {
        
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
        scrollView.addSubview(habitTextField)
        NSLayoutConstraint.activate([
            habitTextField.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 7),
            habitTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            habitTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 16)
        ])
        scrollView.addSubview(colorLabel)
        NSLayoutConstraint.activate([
            colorLabel.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: 15),
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
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorPickerButton.backgroundColor = viewController.selectedColor
    }
}
