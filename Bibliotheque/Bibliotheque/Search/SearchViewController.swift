//
//  SearchViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 12/04/2023.
//

import UIKit

class SearchViewController: UIViewController {
    var timer: Timer?
    let networkService = NetworkService()
    let searchResultController: SearchResultViewController
    let searchController: UISearchController
    
    init(searchResultController: SearchResultViewController) {
        self.searchResultController = searchResultController
        self.searchController = UISearchController(searchResultsController: self.searchResultController)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 244/255, green: 243/255, blue: 234/255, alpha: 1.0)
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let updatedText = searchText.replacingOccurrences(of: " ", with: "+")
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            self.networkService.fetchBooks(containing: updatedText) { result in
                switch result {
                case .success(let books):
                    self.searchResultController.books = books
                    self.searchResultController.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}
