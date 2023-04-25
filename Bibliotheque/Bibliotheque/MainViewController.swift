//
//  MainViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 12/04/2023.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTabBar()
    }
    
    private func setupViews() {
        let searchVC = SearchViewController()
        let listVC = SavedBooksViewController()
        let profileVC = ProfileViewController()
        
        searchVC.setTabBarImage(imageName: "magnifyingglass", title: "Search", tag: 0)
        listVC.setTabBarImage(imageName: "list.bullet", title: "Saved", tag: 1)
        profileVC.setTabBarImage(imageName: "person.crop.circle", title: "Profile", tag: 2)
        
        let searchNC = UINavigationController(rootViewController: searchVC)
        let listNC = UINavigationController(rootViewController: listVC)
        let profileNC = UINavigationController(rootViewController: profileVC)
        
        viewControllers = [searchNC, listNC, profileNC]
    }
    
    private func setupTabBar() {
        tabBar.tintColor = Resources.Color.accentYellow
        tabBar.unselectedItemTintColor = Resources.Color.textNavy
        tabBar.barTintColor = Resources.Color.backgroundBeige
    }
}
