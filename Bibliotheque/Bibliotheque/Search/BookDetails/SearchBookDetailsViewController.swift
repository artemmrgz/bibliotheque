//
//  SearchBookDetailsViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 17/04/2023.
//

import UIKit

class SearchBookDetailsViewController: BookDetailsViewController {
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
            
            let savedBook = CoreDataManager.shared.fetchBook(withName: book.trackName)
            
            if sender.isSelectedState {
                if let savedBook = savedBook {
                    savedBook.isRead = false
                    CoreDataManager.shared.updateBook(book: savedBook)
                } else {
                    let imageData = self?.floatingCoverView.imageView.image?.pngData()
                    let saved = CoreDataManager.shared.saveBook(book: book, imageData: imageData)
                    if saved == nil {
                        // TODO: display saving error
                    }
                }
                self?.showSPAlert(withTitle: "Added to Saved", preset: .heart, completion: {
                    sender.setSelectedStyle()
                })
            } else {
                guard let savedBook = savedBook else { return }
                savedBook.isRead = true
                CoreDataManager.shared.updateBook(book: savedBook)
                
                self?.showSPAlert(withTitle: "Marked as Read", preset: .done, completion: {
                    sender.setDefaultStyle()
                })
            }
        }
        
        setButtonStyle()
    }
    
    func setButtonStyle() {
        guard let bookName = book?.trackName else { return }
        let book = CoreDataManager.shared.fetchBook(withName: bookName)
        
        if let book = book, book.isRead == false {
            addButton.isSelectedState = true
            addButton.setSelectedStyle()
        } else {
            addButton.setDefaultStyle()
        }
    }
}
