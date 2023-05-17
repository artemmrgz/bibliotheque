//
//  BooksListViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 19/04/2023.
//

import UIKit
import SPAlert

class BooksListViewController: BaseViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Resources.Color.backgroundBeige
        navigationController?.navigationBar.prefersLargeTitles = true

        setupTable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        SPAlert.dismiss()
    }

    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Resources.Color.backgroundBeige
        tableView.separatorStyle = .none

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
