//
//  SearchResultsCell.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 12/04/2023.
//

import UIKit

class SearchResultCell: CustomCell {
    
    override static var reuseID: String {
        return "SearchResultsCell"
    }
    
    let bookCoverImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        bookCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        bookCoverImageView.layer.cornerRadius = 8
        bookCoverImageView.clipsToBounds = true
        bookCoverImageView.contentMode = .scaleAspectFill
        bookCoverImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func layout() {
        cellView.addSubview(bookCoverImageView)
        
        NSLayoutConstraint.activate([
            bookCoverImageView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 4),
            bookCoverImageView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -4),
            bookCoverImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
            bookCoverImageView.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -16),
            bookCoverImageView.widthAnchor.constraint(equalTo: bookCoverImageView.heightAnchor, multiplier: 0.65),
        ])
    }
}
