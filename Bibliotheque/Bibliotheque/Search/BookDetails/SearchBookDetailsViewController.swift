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
            
            let savedBook = self?.savedBookManager.fetchBook(withName: book.trackName)
            
            if sender.isSelectedState {
                if let savedBook = savedBook {
                    savedBook.isRead = false
                    self?.savedBookManager.updateBook(book: savedBook)
                } else {
                    let imageData = self?.floatingCoverView.imageView.image?.pngData()
                    let saved = self?.savedBookManager.saveBook(book: book, imageData: imageData)
                    if saved == nil {
                        self?.displaySPAlert(title: "Error", message: "Unfortunatelly we couldn't save the book. Please try again.", preset: .custom(UIImage(systemName: "exclamationmark.circle")!), haptic: .error)
                    }
                }
                self?.displaySPAlert(title: "Added to Saved", preset: .custom(UIImage(systemName: "books.vertical")!), haptic: .success, completion: {
                    sender.setSelectedStyle()
                })
            } else {
                guard let savedBook = savedBook else { return }
                savedBook.isRead = true
                self?.savedBookManager.updateBook(book: savedBook)
                
                self?.displaySPAlert(title: "Marked as Read", preset: .done, haptic: .success, completion: {
                    sender.setDefaultStyle()
                })
            }
        }
        
        setButtonStyle()
    }
    
    func setButtonStyle() {
        guard let bookName = book?.trackName else { return }
        let book = savedBookManager.fetchBook(withName: bookName)
        
        if let book = book, book.isRead == false {
            addButton.isSelectedState = true
            addButton.setSelectedStyle()
        } else {
            addButton.setDefaultStyle()
        }
    }
}
