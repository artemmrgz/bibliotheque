//
//  BookDetailsViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 23/04/2023.
//

import UIKit
import SPAlert

class BookDetailsViewController: UIViewController {
    
    let coverPlaceholderView = CoverView()
    let floatingCoverView = CoverView()
    
    let bookTitle = UILabel()
    let author = UILabel()
    let genres = UILabel()
    let releaseDate = UILabel()
    let rating = UILabel()
    let bookDescription = UILabel()
    let addButton  = CustomButton(defaultTitle: "Add to Saved", selectedTitle: "Mark as Read")
   
    let topUnderlineView = UnderlineView(color: Resources.Color.textNavy)
    let bottomUnderlineView = UnderlineView(color: Resources.Color.textNavy)

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    var buttonTappedCallback: (_ button: UIButton) -> Void = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        styleNavBar()
        styleTabBar()
        styleView()
        layout()
    }
    
    private func styleNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func styleTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = Resources.Color.backgroundBeige
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: Resources.Color.textNavy]
        appearance.stackedLayoutAppearance.normal.iconColor = Resources.Color.textNavy
        tabBarController?.tabBar.standardAppearance = appearance
        tabBarController?.tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setupGradientBackground() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [Resources.Color.textNavy.cgColor, Resources.Color.backgroundBeige.cgColor]
        gradientLayer.locations = [0, 0.6]
        
        return gradientLayer
    }
    
    private func styleView() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = Resources.Color.textNavy
        
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let gradient = setupGradientBackground()
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
    
    func showSPAlert(withTitle title: String, preset: SPAlertIconPreset, completion: @escaping () -> Void) {
        let alertView = SPAlertView(title: title, preset: preset)
        styleSPAlert(alertView)
        alertView.present(haptic: .success, completion: completion)
    }
    
    private func styleSPAlert(_ alert: SPAlertView) {
        alert.layout.iconSize = .init(width: 100, height: 100)
        alert.layout.margins.top = 32
        alert.iconView?.tintColor = Resources.Color.textNavy
        alert.titleLabel?.textColor = Resources.Color.textNavy
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
        buttonTappedCallback(sender)
    }
}

