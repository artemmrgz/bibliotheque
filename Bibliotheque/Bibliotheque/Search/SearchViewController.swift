//
//  SearchViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 12/04/2023.
//

import UIKit

class SearchViewController: UIViewController {
    let networkService = NetworkService()
    let searchController =  UISearchController(searchResultsController: SearchResultsViewController())
    var bestsellersVC: BestsellerResultsViewController? = nil
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let fictionBestsellerView = BestsellerView(category: "Fiction")
    let nonfictionBestsellerView = BestsellerView(category: "Nonfiction")
    
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
        stackView.spacing = 24
        
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
            self?.networkService.fetchBestsellers(for: BestsellerCategory.fiction) { result in
                self?.processResult(result)
            }
        }
        
        nonfictionBestsellerView.onClick = { [weak self] in
            self?.presentBestsellersVC(withTitle: "Nonfiction Bestsellers")
            self?.networkService.fetchBestsellers(for: BestsellerCategory.nonFiction) { result in
                self?.processResult(result)
            }
        }
    }
    
    private func presentBestsellersVC(withTitle title: String) {
        bestsellersVC = BestsellerResultsViewController()
        bestsellersVC?.title = title
        navigationController?.pushViewController(bestsellersVC!, animated: true)
    }
    
    private func processResult(_ result: Result<[BestsellerBook], NetworkError>) {
        guard let bestsellersVC = bestsellersVC else { return }
        switch result {
        case .success(let books):
            bestsellersVC.books = books
        case .failure(let error):
            displayError(error)
        }
    }
    
    private func displayError(_ error: NetworkError) {
        let (title, message) = titleAndMessage(for: error)
        bestsellersVC?.displaySPAlert(title: title, message: message, preset: .custom(UIImage(systemName: "exclamationmark.circle")!), haptic: .error)
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
            message = "We could not process your request. Please try again."
        }
        return (title, message)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        let updatedText = searchText.replacingOccurrences(of: " ", with: "+")
        
        networkService.fetchBooks(containing: updatedText) { [weak self] result in
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
    
