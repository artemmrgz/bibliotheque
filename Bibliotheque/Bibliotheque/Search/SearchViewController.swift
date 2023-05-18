//
//  SearchViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 12/04/2023.
//

import UIKit

class SearchViewController: BaseViewController {
    let searchController =  UISearchController(searchResultsController: SearchResultsViewController())
    var bestsellersVC: BestsellerResultsViewController? = nil
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let fictionBestsellerView = BestsellerView(category: "Fiction")
    let nonfictionBestsellerView = BestsellerView(category: "Nonfiction")
    
    var bookManager: BookManageable = BookManager()
    var bestsellerBookManager: BestsellerBookManageable = BestsellerBookManager()
    
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
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupBestsellerView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        stackView.addArrangedSubview(fictionBestsellerView)
        stackView.addArrangedSubview(nonfictionBestsellerView)
        
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        fictionBestsellerView.onClick = { [weak self] in
            self?.presentBestsellersVC(withTitle: "Fiction Bestsellers")
            self?.bestsellerBookManager.fetchBooks(for: .fiction) { result in
                self?.processResult(result)
            }
        }
        
        nonfictionBestsellerView.onClick = { [weak self] in
            self?.presentBestsellersVC(withTitle: "Nonfiction Bestsellers")
            self?.bestsellerBookManager.fetchBooks(for: .nonFiction) { result in
                self?.processResult(result)
            }
        }
    }
    
    private func presentBestsellersVC(withTitle title: String) {
        bestsellersVC = BestsellerResultsViewController()
        bestsellersVC?.title = title
        navigationController?.pushViewController(bestsellersVC!, animated: false)
    }
    
    private func processResult(_ result: Result<[BestsellerBook], NetworkError>) {
        switch result {
        case .success(let books):
            bestsellersVC?.books = books
            bestsellersVC?.tableView.reloadData()
        case .failure(let error):
            displayError(error)
        }
    }
    
    private func displayError(_ error: NetworkError) {
        let (title, message) = titleAndMessage(for: error)
        displaySPAlert(title: title, message: message, preset: .custom(UIImage(systemName: "exclamationmark.circle")!), haptic: .error)
    }
    
    private func titleAndMessage(for error: NetworkError) -> (String, String) {
        let title: String
        let message: String

        switch error {
        case .serverError:
            title = "Server Error"
            message = "Please make sure you are connected to the internet"
        case .decodingError:
            title = "Network Error"
            message = "We could not process your request. Please try again"
        }
        return (title, message)
    }
}

//MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        let updatedText = searchText.replacingOccurrences(of: " ", with: "+")
        
        fetchBooks(containing: updatedText)
    }
    
    private func fetchBooks(containing text: String) {
        bookManager.fetchBooks(containing: text) { [weak self] result in
            switch result {
            case .success(let books):
                let vc = self?.searchController.searchResultsController as? SearchResultsViewController
                vc?.books = books
                vc?.tableView.reloadData()
                guard let vc = vc else { return }
                self?.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                self?.displayError(error)
            }
        }
    }
}

// MARK: Unit testing
extension SearchViewController {
    func titleAndMessageForTesting(for error: NetworkError) -> (String, String) {
        return titleAndMessage(for: error)
    }
    
    func forceFetchBooks() {
        fetchBooks(containing: "test text")
    }
    
    func forceFetchBestsellerBooks() {
        bestsellerBookManager.fetchBooks(for: .fiction) { [weak self] result in
            self?.processResult(result)
        }
    }
}
    
