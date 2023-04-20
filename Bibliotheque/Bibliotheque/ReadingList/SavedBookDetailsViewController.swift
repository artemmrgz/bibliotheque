//
//  SavedBookDetailsViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 20/04/2023.
//

import UIKit

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
}
