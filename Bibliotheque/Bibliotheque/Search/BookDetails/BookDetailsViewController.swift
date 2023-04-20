//
//  BookDetailViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 17/04/2023.
//

import UIKit

class BookDetailsViewController: UIViewController {
    
    let coverPlaceholderView = CoverView()
    let floatingCoverView = CoverView()
    
    let bookTitle = UILabel()
    let author = UILabel()
    let genres = UILabel()
    let releaseDate = UILabel()
    let rating = UILabel()
    let bookDescription = UILabel()
    let addButton  = CustomButton(defaultTitle: "Add to Read List", selectedTitle: "✓ Added")
   
    let topUnderlineView = UnderlineView(color: Resources.Color.textNavy)
    let bottomUnderlineView = UnderlineView(color: Resources.Color.textNavy)

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    var book: Book? {
        didSet {
            guard let book = book else { return }
            if let userRating = book.averageUserRating {
                rating.text = "Average User Rating\n" + String(describing: userRating)
            }
            bookTitle.text = book.trackName
            author.text = book.artistName
            genres.text = "Genres\n" + book.genres.joined(separator: ", ")
            bookDescription.attributedText = book.description.htmlAttributedString()

            let date = "Release Date\n" + book.releaseDate.components(separatedBy: "T")[0]
            releaseDate.text = date

            let newURL = book.artworkUrl100?.replacingOccurrences(of: "100x100", with: "600x600")
            floatingCoverView.coverUrl = newURL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let TBappearance = UITabBarAppearance()
        TBappearance.backgroundColor = Resources.Color.backgroundBeige
        tabBarController?.tabBar.standardAppearance = TBappearance
        tabBarController?.tabBar.scrollEdgeAppearance = TBappearance
       
        navigationItem.largeTitleDisplayMode = .never
        scrollView.delegate = self
        style()
        layout()
    }
    
    private func setupGradientBackground() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [Resources.Color.textNavy.cgColor, Resources.Color.backgroundBeige.cgColor]
        gradientLayer.locations = [0, 0.6]
        
        return gradientLayer
    }
    
    private func style() {
        floatingCoverView.translatesAutoresizingMaskIntoConstraints = false
        
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        bookTitle.numberOfLines = 0
        bookTitle.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        bookTitle.textColor = UIColor.darkGray
        bookTitle.textAlignment = .center
        
        author.translatesAutoresizingMaskIntoConstraints = false
        author.numberOfLines = 0
        author.font = UIFont.systemFont(ofSize: 20)
        author.textAlignment = .center
        
        genres.translatesAutoresizingMaskIntoConstraints = false
        genres.textAlignment = .center
        genres.numberOfLines = 0
        
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.textAlignment = .center
        releaseDate.numberOfLines = 0
        
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.textAlignment = .center
        rating.numberOfLines = 0
        
        bookDescription.translatesAutoresizingMaskIntoConstraints = false
        bookDescription.numberOfLines = 0
        bookDescription.font = UIFont.systemFont(ofSize: 20)
        
        // TODO: fetch book with title and if exist change button style
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let gradient = setupGradientBackground()
        view.backgroundColor = Resources.Color.textNavy

        scrollView.layer.addSublayer(gradient)
    }
    
    private func layout() {
        stackView.addArrangedSubview(coverPlaceholderView)
        stackView.addArrangedSubview(bookTitle)
        stackView.addArrangedSubview(author)
        stackView.addArrangedSubview(topUnderlineView)
        stackView.addArrangedSubview(genres)
        stackView.addArrangedSubview(releaseDate)
        stackView.addArrangedSubview(rating)
        stackView.addArrangedSubview(bottomUnderlineView)
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(bookDescription)
        
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        view.addSubview(floatingCoverView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            floatingCoverView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            floatingCoverView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension BookDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        floatingCoverView.scrollViewDidScroll(scrollView)
        
        let y = scrollView.contentOffset.y

        if y > 230 {
            navigationItem.title = bookTitle.text
        } else {
            navigationItem.title = ""
        }

        if y > 0 {
            scrollView.backgroundColor = Resources.Color.backgroundBeige
        } else {
            scrollView.backgroundColor = Resources.Color.textNavy
        }
    }
}

extension BookDetailsViewController {
    @objc func addButtonTapped(_ sender: UIButton) {
        guard let sender = sender as? CustomButton, let book = book else { return }
        sender.isSelectedState.toggle()
        
        let imageData = floatingCoverView.imageView.image?.pngData()
        
        if sender.isSelectedState {
            let saved = CoreDataManager.shared.saveBook(book: book, imageData: imageData)
            if saved != nil {
                addButton.setSelectedStyle()
            } else {
                sender.isSelectedState.toggle()
            }
        } else {
            CoreDataManager.shared.deleteBook(withName: book.trackName)
            addButton.setDefaultStyle()
        }
    }
}
