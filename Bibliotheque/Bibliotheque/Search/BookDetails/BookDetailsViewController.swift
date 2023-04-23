//
//  BookDetailViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 17/04/2023.
//

import UIKit

class BookDetailsViewController: DetailsVC {
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
        
        buttonTappedCallback = { [weak self] button in
            guard let sender = button as? CustomButton, let book = self?.book else { return }
            sender.isSelectedState.toggle()
            
            let imageData = self?.floatingCoverView.imageView.image?.pngData()
            
            if sender.isSelectedState {
                let saved = CoreDataManager.shared.saveBook(book: book, imageData: imageData)
                if saved != nil {
                    sender.setSelectedStyle()
                } else {
                    // TODO: display saving error
                }
            } else {
                CoreDataManager.shared.deleteBook(withName: book.trackName)
                sender.setDefaultStyle()
            }
        }
        
        setButtonStyle()
    }
    
    func setButtonStyle() {
        guard let bookName = book?.trackName else { return }
        let book = CoreDataManager.shared.fetchBook(withName: bookName)
        if book != nil {
            addButton.isSelectedState = true
            addButton.setSelectedStyle()
        }
    }
}
