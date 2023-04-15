//
//  SearchResultsCell.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 12/04/2023.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    static let reuseID = "SearchResultsCell"
    static let rowHeight: CGFloat = 90
    
    let cellView = UIView()
    let bookCoverImageView = UIImageView()
    let stackView = UIStackView()
    let bookNameLabel = UILabel()
    let authorLabel = UILabel()
    let chevronImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = UIColor(red: 244/255, green: 243/255, blue: 234/255, alpha: 1.0)
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.layer.cornerRadius = 14
        cellView.backgroundColor = .white
        
        bookCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        bookCoverImageView.layer.cornerRadius = 8
        bookCoverImageView.clipsToBounds = true
        bookCoverImageView.contentMode = .scaleAspectFill
        bookCoverImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameLabel.font = .boldSystemFont(ofSize: 20)
        bookNameLabel.textColor = UIColor(red: 51/255, green: 61/255, blue: 81/255, alpha: 1)
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        authorLabel.numberOfLines = 0
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")!.withTintColor(UIColor(red: 51/255, green: 61/255, blue: 81/255, alpha: 1), renderingMode: .alwaysOriginal)
        chevronImageView.image = chevronImage
        chevronImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func layout() {
        stackView.addArrangedSubview(bookNameLabel)
        stackView.addArrangedSubview(authorLabel)
        cellView.addSubview(bookCoverImageView)
        cellView.addSubview(stackView)
        cellView.addSubview(chevronImageView)
        contentView.addSubview(cellView)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bookCoverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bookCoverImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
            
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: bookCoverImageView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
            
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16)
        ])
    }
    
    func configureWith(bookName: String, author: String) {
        bookNameLabel.text = bookName
        authorLabel.text = author
    }
}
