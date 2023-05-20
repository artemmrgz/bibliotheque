//
//  SavedBooksViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 23/04/2023.
//

import UIKit

class SavedBooksViewController: BooksListViewController {
    
    var savedBooks = [BookEntity]()
    let emptySavedView = EmptySavedView()
    
    let savedBookManager = SavedBookManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Saved Books"
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reuseID)
        tableView.rowHeight = CustomCell.rowHeight
        tableView.delegate = self
        tableView.dataSource = self
        
        layoutEmptySavedView()
    }
    
    private func layoutEmptySavedView() {
        view.addSubview(emptySavedView)
        
        NSLayoutConstraint.activate([
            emptySavedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptySavedView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchBooks()
        setEmptySavedView()
    }
    
    func fetchBooks() {
        let books = savedBookManager.fetchBooks()
        
        if let books = books {
            savedBooks = books
            tableView.reloadData()
        } else {
            displaySPAlert(title: "Error", message: "We could not process your request. Please try again.", preset: .custom(UIImage(systemName: "exclamationmark.circle")!), haptic: .error)
        }
    }
    
    private func setEmptySavedView() {
        emptySavedView.isHidden = !savedBooks.isEmpty
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
        
        let book = savedBooks.remove(at: indexPath.row)
        book.isRead = true
        savedBookManager.updateBook(book: book)
        
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
        
        setEmptySavedView()
    }
}
