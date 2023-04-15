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
        let searchVC = SearchViewController(searchResultController: SearchResultViewController())
        let listVC = ReadingListViewController()
        let profileVC = ProfileViewController()
        
        searchVC.setTabBarImage(imageName: "magnifyingglass", title: "Search", tag: 0)
        listVC.setTabBarImage(imageName: "list.bullet", title: "Reading List", tag: 1)
        profileVC.setTabBarImage(imageName: "person.crop.circle", title: "Profile", tag: 2)
        
        let searchNC = UINavigationController(rootViewController: searchVC)
        let listNC = UINavigationController(rootViewController: listVC)
        let profileNC = UINavigationController(rootViewController: profileVC)
        
        viewControllers = [searchNC, listNC, profileNC]
    }
    
    private func setupTabBar() {
        tabBar.tintColor = UIColor(red: 211/255, green: 172/255, blue: 43/255, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 51/255, green: 61/255, blue: 81/255, alpha: 1)
    }
}

class ReadingListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}
