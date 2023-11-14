//
//  MainTabBarController.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 12.11.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        setTabBarAppearance()
    }
    
    private func setTabBar() {
        
        let rootViewController = HabitsViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.shadowColor = UIColor(red: 60/255, green: 60/255, blue: 0/255, alpha: 0.29)
        navBarAppearance.backgroundColor = UIColor.white.withAlphaComponent(1)
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController.navigationBar.prefersLargeTitles = true
        
        viewControllers = [
            setVC(
                viewController: navigationController,
                title: "Привычки",
                image: UIImage(named: "habitsImage")),
            setVC(
                viewController: InfoViewController(),
                title: "Информация",
                image: UIImage(named: "infoImage"))
        ]
    }
    
    private func setVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBar.tintColor = AppColors.purpleColor.color
        tabBar.unselectedItemTintColor = AppColors.systemGray2.color
        tabBar.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        tabBarAppearance.shadowColor = UIColor(red: 60/255, green: 60/255, blue: 0/255, alpha: 0.29)
        tabBar.scrollEdgeAppearance = tabBarAppearance

    }
}
