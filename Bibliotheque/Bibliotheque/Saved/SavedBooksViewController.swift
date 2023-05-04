//
//  SavedBooksViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 23/04/2023.
//

import UIKit

class SavedBooksViewController: BooksListViewController {
    
    var savedBooks = [BookEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Saved Books"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reuseID)
        tableView.rowHeight = CustomCell.rowHeight
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchBooks()
    }
    
    func fetchBooks() {
        let books = CoreDataManager.shared.fetchBooks()
        
        if let books = books {
            savedBooks = books
            tableView.reloadData()
        } else {
            showErrorAlert(title: "Error", message: "We could not process your request. Please try again.")
        }
    }
    
    private func showErrorAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}

extension SavedBooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = savedBooks[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseID, for: indexPath) as! CustomCell
        cell.configureWith(bookName: book.trackName!, author: book.artistName!)
        if let imageData = book.imageData {
            cell.bookCoverImageView.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !savedBooks.isEmpty else { return }
        
        let book = savedBooks[indexPath.row]
        
        let bookDetails = SavedBookDetailsViewController()
        bookDetails.savedBook = book
        bookDetails.scrollView.contentOffset.y = -52
        navigationController?.pushViewController(bookDetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // how to make it differently? Displaying each cell in section instead of row didn't work: number of sections before and after deletion should be the same error
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        
//        let bookName = savedBooks[indexPath.row].trackName!
//        CoreDataManager.shared.deleteBook(withName: bookName)
        
        let book = savedBooks.remove(at: indexPath.row)
        book.isRead = true
        CoreDataManager.shared.updateBook(book: book)
        
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}
