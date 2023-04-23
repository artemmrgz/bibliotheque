//
//  SearchResultsViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 12/04/2023.
//

import UIKit

class SearchResultsViewController: BooksListViewController {
    
    var books: Books?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let books = books else { return 0}
        return books.resultCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let books = books else { return UITableViewCell() }
        let book = books.results[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseID, for: indexPath) as! CustomCell
        cell.configureWith(bookName: book.trackName, author: book.artistName)

        if let imageLink = book.artworkUrl100 {
            cell.bookCoverImageView.downloaded(from: imageLink)
        } else {
            // TODO: add placeholder image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let books = books else { return }

        let book = books.results[indexPath.row]
        let bookDetails = SearchBookDetailsViewController()
        
        bookDetails.book = book
        bookDetails.scrollView.contentOffset.y = -52
        navigationController?.pushViewController(bookDetails, animated: true)
    }
}
