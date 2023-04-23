//
//  ReadingListViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 19/04/2023.
//

import UIKit

class ReadingListViewController: BooksListViewController {
    
    var savedBooks = [BookEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        fetchBooks()
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
        
        let bookName = savedBooks[indexPath.row].trackName!
        savedBooks.remove(at: indexPath.row)
        CoreDataManager.shared.deleteBook(withName: bookName)
        
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}
