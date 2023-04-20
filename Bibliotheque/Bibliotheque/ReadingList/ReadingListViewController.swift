//
//  ReadingListViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 19/04/2023.
//

import UIKit

class ReadingListViewController: BooksListViewController {
    var savedBooks = [BookEntity]()
    let bookDetails = SavedBookDetailsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchBooks()
    }
    
    func setup() {
        tableView.register(ReadingListCell.self, forCellReuseIdentifier: ReadingListCell.reuseID)
        tableView.rowHeight = ReadingListCell.rowHeight
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchBooks() {
        let books = CoreDataManager.shared.fetchBooks()
        
        if let books = books {
            savedBooks = books
            tableView.reloadData()
        } else {
            // TODO: display error
        }
    }
    
}

extension ReadingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = savedBooks[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: ReadingListCell.reuseID, for: indexPath) as! ReadingListCell
        cell.configureWith(bookName: book.trackName!, author: book.artistName!)
        
        cell.deleteTapped = { [weak self] in
            let bookName = book.trackName!
            CoreDataManager.shared.deleteBook(withName: bookName)
            
            self?.savedBooks.remove(at: indexPath.row)
            self?.tableView.reloadData()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !savedBooks.isEmpty else { return }
        
        let book = savedBooks[indexPath.row]
        bookDetails.savedBook = book
        bookDetails.scrollView.contentOffset.y = -52
        navigationController?.pushViewController(bookDetails, animated: true)
    }
}
