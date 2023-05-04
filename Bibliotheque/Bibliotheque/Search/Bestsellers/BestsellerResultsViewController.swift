//
//  BestsellerResultsViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 03/05/2023.
//

import UIKit

class BestsellerResultsViewController: BooksListViewController {
    
    var books: [BestsellerBook]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.largeTitleDisplayMode = .never

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BestsellerResultCell.self, forCellReuseIdentifier: BestsellerResultCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension BestsellerResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let books = books else { return 0 }
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let books = books else { return UITableViewCell() }
        let book = books[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BestsellerResultCell.reuseID, for: indexPath) as! BestsellerResultCell
        cell.configureWith(book: book)
        cell.coverImageView.downloaded(from: book.imageUrl)
        return cell
    }
}
