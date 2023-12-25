//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 18.11.2023.
//

import UIKit

class HabitViewController: UIViewController {
    
    // MARK: - Properties
    
    enum State {
           case save
           case edit
       }
    
    private var state: State = State.save
    private let store = HabitsStore.shared
    private var habitIndex: Int?
    
    // MARK: - Subviews
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset.bottom = 0
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = true
        contentView.backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        contentView.addGestureRecognizer(tapGesture)
        return contentView
    }()
    private let habitNameLabel: UILabel = {
        let habitName = UILabel()
        habitName.translatesAutoresizingMaskIntoConstraints = false
        habitName.font = .systemFont(ofSize: 13, weight: .semibold)
        habitName.sizeToFit()
        habitName.text = "НАЗВАНИЕ"
        return habitName
    }()
    private let habitNameTextField: UITextField = {
        let habitTextField = UITextField()
        habitTextField.placeholder = "Бегать по утрам, спать 8 и т.п."
        habitTextField.font = .systemFont(ofSize: 17, weight: .semibold)
        habitTextField.translatesAutoresizingMaskIntoConstraints = false
        return habitTextField
    }()
    private let colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.text = "ЦВЕТ"
        colorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        return colorLabel
    }()
    private lazy var colorPickerButton: UIButton = {
        let colorPickerButton = UIButton(type: .system)
        colorPickerButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        colorPickerButton.backgroundColor = .orange
        colorPickerButton.layer.cornerRadius = colorPickerButton.frame.height/2
        colorPickerButton.clipsToBounds = true
        colorPickerButton.addTarget(self, action: #selector(pickColor), for: .touchUpInside)
        colorPickerButton.translatesAutoresizingMaskIntoConstraints = false
        return colorPickerButton
    }()
    private let timelabel: UILabel = {
        let timelabel = UILabel()
        timelabel.text = "ВРЕМЯ"
        timelabel.font = .systemFont(ofSize: 13, weight: .semibold)
        timelabel.translatesAutoresizingMaskIntoConstraints = false
        return timelabel
    }()
    private let repeatDateLabel: UILabel = {
        let repeatDateLabel = UILabel()
        repeatDateLabel.translatesAutoresizingMaskIntoConstraints = false
        repeatDateLabel.text = "Каждый день в"
        repeatDateLabel.font = .systemFont(ofSize: 17, weight: .regular)
        return repeatDateLabel
    }()
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .appPurple
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "--:--"
        return dateLabel
    }()
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.contentMode = .scaleAspectFill
        datePicker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    private lazy var createHabitButton: UIBarButtonItem = {
        let saveHabitButton = UIBarButtonItem(title: "Cохранить", 
                                              style: .plain,
                                              target: self,
                                              action: #selector(createHabitButtonTapped))
        saveHabitButton.tintColor = .appPurple
        return saveHabitButton
    }()
    private lazy var cancelCreatingHabitButton: UIBarButtonItem = {
        let cancelHabitButton = UIBarButtonItem(title: "Отменить",
                                              style: .plain,
                                              target: self,
                                              action: #selector(cancelCreatingButtonTapped))
        cancelHabitButton.tintColor = .appPurple
        return cancelHabitButton
    }()
    private lazy var deleteHabitBotton: UIButton = {
        let deliteHabitBotton = UIButton(type: .system)
        deliteHabitBotton.translatesAutoresizingMaskIntoConstraints = false
        deliteHabitBotton.setTitle("Удалить привычку", for: .normal)
        deliteHabitBotton.tintColor = .red
        deliteHabitBotton.addTarget(self, action: #selector(deleteHabitBottonTapped), for: .touchUpInside)
        return deliteHabitBotton
    }()
    
    // MARK: - Lifecycle
    
    deinit {
        print("HabitViewController deinit")
    }
    
    init(state: State) {
        super.init(nibName: nil, bundle: nil)
        self.state = state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        tuneView()
        setupConstraints()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    // MARK: - Actions
    
    @objc private func deleteHabitBottonTapped() {
        showAlert(title: "Удалить привычку", message: "Вы хотите удалить привычку \(habitNameTextField.text ?? "error")?", target: self) { [weak self] action in
            guard let index = self?.habitIndex else { return }
            self?.store.habits.remove(at: index)
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func createHabitButtonTapped() {
        
        guard let habitName = habitNameTextField.text else { return }
        guard let buttonColor = colorPickerButton.backgroundColor else { return }
        let date = datePicker.date
        
        let newHabit = Habit(name: habitName,
                             date: date,
                             color: buttonColor)
        if state == .save {
            store.habits.append(newHabit)
        } else {
            guard let index = habitIndex else { return }
            store.habits[index] = newHabit
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancelCreatingButtonTapped() {
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func datePicked() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let locationTime = dateFormatter.string(from: datePicker.date)
        dateLabel.text = locationTime
    }
    
    @objc private func pickColor() {
        
        let colorPicker = UIColorPickerViewController()
            colorPicker.title = "Background Color"
            colorPicker.supportsAlpha = false
            colorPicker.delegate = self
            guard let buttonColor = colorPickerButton.backgroundColor else { return }
            colorPicker.selectedColor = buttonColor
            colorPicker.modalPresentationStyle = .popover
            self.present(colorPicker, animated: true)
    }
    
    @objc private func willShowKeyboard(_ notification: NSNotification) {
        
            let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
            guard let height = keyboardHeight else { print("get keyboardHeight error"); return }
            scrollView.contentInset.bottom = height
            print("height \(height)")
            print(scrollView.contentInset.bottom)
        
    }
    
    @objc private func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Private
    
    private func setupKeyboardObservers() {
            let notificationCenter = NotificationCenter.default
            
            notificationCenter.addObserver(
                self,
                selector: #selector(self.willShowKeyboard(_:)),
                name: UIResponder.keyboardDidShowNotification,
                object: nil
            )
            
            notificationCenter.addObserver(
                self,
                selector: #selector(self.willHideKeyboard(_:)),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
        }
        
        private func removeKeyboardObservers() {
            let notificationCenter = NotificationCenter.default
            notificationCenter.removeObserver(self)
        }
    
    private func addSubviews() {
        navigationItem.leftBarButtonItem = cancelCreatingHabitButton
        navigationItem.rightBarButtonItem = createHabitButton
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            habitNameLabel,
            habitNameTextField,
            colorLabel,
            colorPickerButton,
            timelabel,
            repeatDateLabel,
            dateLabel,
            datePicker)
        
        if state == State.edit {
            view.addSubview(deleteHabitBotton)
        }
        
    }
    
    private func tuneView() {
        view.backgroundColor = .white
        habitNameTextField.delegate = self
        navigationItem.largeTitleDisplayMode = .never
        habitNameTextField.textColor = colorPickerButton.backgroundColor
        
        if state == State.edit {
            title = "Править"
        } else {
            title = "Создать"
        }
    }
    
    private func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            habitNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            habitNameTextField.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 7),
            habitNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            habitNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            colorLabel.topAnchor.constraint(equalTo: habitNameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorPickerButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorPickerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timelabel.topAnchor.constraint(equalTo: colorPickerButton.bottomAnchor, constant: 15),
            timelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            repeatDateLabel.topAnchor.constraint(equalTo: timelabel.bottomAnchor, constant: 7),
            repeatDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: timelabel.bottomAnchor, constant: 7),
            dateLabel.leadingAnchor.constraint(equalTo: repeatDateLabel.trailingAnchor, constant: 4),
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            datePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
            
        ])
        
        if state == State.edit {
            NSLayoutConstraint.activate([
                deleteHabitBotton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
                deleteHabitBotton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                deleteHabitBotton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                deleteHabitBotton.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
    }
    
    // MARK: - Public
    
    public func updateData(store: HabitsStore, indexPath: IndexPath) {
        habitNameTextField.text = store.habits[indexPath.row - 1].name
        habitNameTextField.textColor = store.habits[indexPath.row - 1].color
        colorPickerButton.backgroundColor = store.habits[indexPath.row - 1].color
        dateLabel.text = store.habits[indexPath.row - 1].date.formatted(date: .omitted, time: .shortened)
        datePicker.date = store.habits[indexPath.row - 1].date
        habitIndex = indexPath.row - 1
    }
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorPickerButton.backgroundColor = viewController.selectedColor
        habitNameTextField.textColor = viewController.selectedColor
    }
}

extension HabitViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

