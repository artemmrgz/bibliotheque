//
//  ReadingListViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 19/04/2023.
//

import UIKit

class ReadingListViewController: BooksListViewController, CellRegisterable, DataSourceable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCustomCell()
        setDataSource()
    }
    
    func registerCustomCell() {
        tableView.register(ReadingListCell.self, forCellReuseIdentifier: ReadingListCell.reuseID)
        tableView.rowHeight = ReadingListCell.rowHeight
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

        let cell = tableView.dequeueReusableCell(withIdentifier: ReadingListCell.reuseID, for: indexPath) as! ReadingListCell
        cell.configureWith(bookName: book.trackName, author: book.artistName)

        return cell
    }
}
