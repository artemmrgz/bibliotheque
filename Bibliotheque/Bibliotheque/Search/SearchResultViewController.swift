//
//  SearchResultViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 12/04/2023.
//

import UIKit

class SearchResultViewController: BooksListViewController, CellRegisterable, DataSourceable {

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCustomCell()
        setDataSource()
    }

    func registerCustomCell() {
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.reuseID)
        tableView.rowHeight = SearchResultCell.rowHeight
    }

    func setDataSource() {
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let books = books else { return 0}
        return books.resultCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let books = books else { return UITableViewCell() }
        let book = books.results[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseID, for: indexPath) as! SearchResultCell
        cell.configureWith(bookName: book.trackName, author: book.artistName)

        if let imageLink = book.artworkUrl100 {
            cell.bookCoverImageView.downloaded(from: imageLink)
        } else {
            // TODO: add placeholder image
        }
        return cell
    }
}
