//
//  BookDetailViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 17/04/2023.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    let coverPlaceholderView = CoverView()
    let floatingCoverView = CoverView()
    
    let bookTitle = UILabel()
    let author = UILabel()
    let genres = UILabel()
    let releaseDate = UILabel()
    let rating = UILabel()
    let bookDescription = UILabel()
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    var book: Book? {
        didSet {
            guard let book = book else { return }
            if let userRating = book.averageUserRating {
                rating.text = String(describing: userRating)
            }
            
            bookTitle.text = book.trackName
            author.text = book.artistName
            genres.text = book.genres.joined(separator: ", ")
            releaseDate.text = book.releaseDate
            bookDescription.text = book.description
            floatingCoverView.coverUrl = book.artworkUrl100
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        setupGradientBackground()
        style()
        layout()
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [Resources.Color.textNavy.cgColor, Resources.Color.backgroundBeige.cgColor]
        gradientLayer.locations = [0.2, 0.6]

        view.layer.addSublayer(gradientLayer)
    }
    
    private func style() {
        floatingCoverView.translatesAutoresizingMaskIntoConstraints = false
        
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        bookTitle.numberOfLines = 0
        bookTitle.font = UIFont.systemFont(ofSize: 35)
        
        author.translatesAutoresizingMaskIntoConstraints = false
        author.numberOfLines = 0
        author.font = UIFont.systemFont(ofSize: 25)
        
        genres.translatesAutoresizingMaskIntoConstraints = false
        
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        
        rating.translatesAutoresizingMaskIntoConstraints = false
        
        bookDescription.translatesAutoresizingMaskIntoConstraints = false
        bookDescription.numberOfLines = 0
        bookDescription.font = UIFont.systemFont(ofSize: 20)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        stackView.addArrangedSubview(coverPlaceholderView)
        stackView.addArrangedSubview(bookTitle)
        stackView.addArrangedSubview(author)
        stackView.addArrangedSubview(releaseDate)
        stackView.addArrangedSubview(rating)
        stackView.addArrangedSubview(bookDescription)
        
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        view.addSubview(floatingCoverView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            floatingCoverView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            floatingCoverView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension BookDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        floatingCoverView.scrollViewDidScroll(scrollView)
    }
}
