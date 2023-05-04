//
//  ProfileViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 24/04/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let imageViewSideSize: CGFloat = 150
    
    let imageView = UIImageView()
    let stackView = UIStackView()
    
    let savedBooks = StatisticsView()
    let readBooks = StatisticsView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        setupGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let savedTotal = getSavedTotal()
        savedBooks.configureWith(category: "Number of Saved Books", number: savedTotal)
        
        let readTotal = getReadTotal()
        readBooks.configureWith(category: "Number of Read Books", number: readTotal)
    }
    
    private func style() {
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = Resources.Color.backgroundBeige
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = Resources.Color.secondaryAccentGray
        imageView.layer.cornerRadius = imageViewSideSize / 2
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
    
    private func getReadTotal() -> String {
        let books = CoreDataManager.shared.fetchBooks(isRead: true)
        let count = books?.count ?? 0
        return String(describing: count)
    }
    
    private func setupGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc func imageTapped() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        imageView.image = image
        dismiss(animated: true)
    }
}
