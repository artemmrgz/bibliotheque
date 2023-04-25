//
//  ProfileViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 24/04/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let imageViewSideSize: CGFloat = 150
    var imageViewConerRadius: CGFloat {
       return imageViewSideSize / 2
    }
    
    let imageView = UIImageView()
    let stackView = UIStackView()
    
    let savedBooks = StatisticsView()
    let readBooks = StatisticsView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let savedTotal = getSavedTotal()
        savedBooks.configureWith(category: "Number of Saved Books", number: savedTotal)
        
        //TODO: create Core Data entity for books that have been read
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        savedBooks.height = savedBooks.bounds.height
        readBooks.height = readBooks.bounds.height
    }
    
    private func style() {
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = Resources.Color.backgroundBeige
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = Resources.Color.secondaryAccentGray
        imageView.layer.cornerRadius = imageViewConerRadius
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "personIcon")
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
    }
    
    private func layout() {
        view.addSubview(imageView)
        stackView.addArrangedSubview(savedBooks)
        stackView.addArrangedSubview(readBooks)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageViewSideSize),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16),
        ])
    }
    
    private func getSavedTotal() -> String {
        let books = CoreDataManager.shared.fetchBooks()
        let count = books?.count ?? 0
        return String(describing: count)
    }
}
