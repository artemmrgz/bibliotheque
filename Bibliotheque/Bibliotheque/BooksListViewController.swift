//
//  BooksListViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 19/04/2023.
//

protocol DataSourceable: UITableViewDataSource {
    func setDataSource()
}

protocol CellRegisterable {
    func registerCustomCell()
}

import UIKit

class BooksListViewController: UIViewController {
    var books: Books?
    let tableView = UITableView()
    let bookDetails = BookDetailViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Resources.Color.backgroundBeige
        navigationItem.largeTitleDisplayMode = .never

        setupTable()
    }

    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.delegate = self
        
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

extension BooksListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let books = books else { return }

        let book = books.results[indexPath.row]
        bookDetails.book = book
        bookDetails.scrollView.contentOffset.y = -52
        navigationController?.pushViewController(bookDetails, animated: true)
    }
}
