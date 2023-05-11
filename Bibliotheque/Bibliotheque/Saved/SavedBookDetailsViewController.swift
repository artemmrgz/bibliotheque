//
//  SavedBookDetailsViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 20/04/2023.
//

import UIKit
import SPAlert

class SavedBookDetailsViewController: BookDetailsViewController {
    var savedBook: BookEntity? {
        didSet {
            guard let savedBook = savedBook else { return }
            if let userRating = savedBook.averageUserRating {
                rating.text = "Average User Rating\n" + userRating
            }
            bookTitle.text = savedBook.trackName
            author.text = savedBook.artistName
            genres.text = "Genres\n" + savedBook.genres!
            bookDescription.attributedText = savedBook.bookDescription!.htmlAttributedString()
            releaseDate.text = "Release Date\n" + savedBook.releaseDate!
            
            if let imageData = savedBook.imageData {
                floatingCoverView.imageView.image = UIImage(data: imageData)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonTappedCallback = { [weak self] _ in
            guard let book = self?.savedBook else { return }
            
            book.isRead = true
            CoreDataManager.shared.updateBook(book: book)
            
            let alertView = SPAlertView(title: "Marked as Read", preset: .done)
            alertView.present(haptic: .success) {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        addButton.setSelectedStyle()
    }
    
    private func showErrorAlert(title: String, message: String?, handler: @escaping (UIAlertAction) -> Void) {
        let message = message ?? nil
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
        present(ac, animated: true)
    }
}
