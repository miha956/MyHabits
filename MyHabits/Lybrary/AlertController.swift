//
//  AlertController.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 25.12.2023.
//

import Foundation
import UIKit

public func showAlert(title: String?, message: String?, target: UIViewController, handler: ((UIAlertAction) -> Void)?) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
    let deleteAction = UIAlertAction(title: "Удалить", style: .destructive, handler: handler)
    alertController.addAction(cancelAction)
    alertController.addAction(deleteAction)
    target.present(alertController, animated: true)
}
