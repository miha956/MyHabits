//
//  MainTabBarController.swift
//  MyHabits
//
//  Created by Миша Вашкевич on 12.11.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        setTabBarAppearance()
    }
    
    private func setTabBar() {
        
        let habitsNavigationController = UINavigationController(rootViewController: HabitsViewController())
        let infoNavigationController = UINavigationController(rootViewController: InfoViewController())
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.shadowColor = UIColor(red: 60/255, green: 60/255, blue: 0/255, alpha: 0.29)
        navBarAppearance.backgroundColor = UIColor.white.withAlphaComponent(1)
        habitsNavigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        habitsNavigationController.navigationBar.standardAppearance = navBarAppearance
        habitsNavigationController.navigationBar.compactAppearance = navBarAppearance
        habitsNavigationController.navigationBar.compactScrollEdgeAppearance = navBarAppearance
        
        infoNavigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        infoNavigationController.navigationBar.standardAppearance = navBarAppearance
        infoNavigationController.navigationBar.compactAppearance = navBarAppearance
        infoNavigationController.navigationBar.compactScrollEdgeAppearance = navBarAppearance
        
        habitsNavigationController.navigationBar.prefersLargeTitles = true
        habitsNavigationController.navigationBar.tintColor = .appPurple
        habitsNavigationController.toolbar.tintColor = .red
        
        self.viewControllers = [
            setVC(
                viewController: habitsNavigationController,
                title: "Привычки",
                image: UIImage(named: "habitsImage")),
            setVC(
                viewController: infoNavigationController,
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
        tabBar.standardAppearance = tabBarAppearance
    }
}
