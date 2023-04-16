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
    let searchController =  UISearchController(searchResultsController: SearchResultViewController())
    
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let stackView = UIStackView()
    let fictionBestsellerView = BestsellerView(category: "Fiction")
    let nonfictionBestsellerView = BestsellerView(category: "Nonfiction")
    let hcBestsellerView = BestsellerView(category: "Hardcover Nonfiction")
    let anotherBestsellerView = BestsellerView(category: "Another")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Resources.Color.backgroundBeige
        title = "Search"
        
        setupNavigationBar()
        setupSearchBar()
        setupBestsellerView()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = Resources.Color.accentYellow
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Resources.Color.backgroundBeige
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupBestsellerView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        
        stackView.addArrangedSubview(fictionBestsellerView)
        stackView.addArrangedSubview(nonfictionBestsellerView)
        stackView.addArrangedSubview(hcBestsellerView)
        stackView.addArrangedSubview(anotherBestsellerView)
        
        contentView.addSubview(stackView)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
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
                    let vc = self.searchController.searchResultsController as? SearchResultViewController
                    vc?.books = books
                    vc?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}
