//
//  CustomCell.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 19/04/2023.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let rowHeight: CGFloat = 90
    class var reuseID: String {
        return "CustomCell"
    }
    
    let cellView = UIView()
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
        contentView.backgroundColor = Resources.Color.backgroundBeige
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.layer.cornerRadius = 14
        cellView.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameLabel.font = .boldSystemFont(ofSize: 20)
        bookNameLabel.textColor = Resources.Color.textNavy
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        authorLabel.numberOfLines = 0
        authorLabel.textColor = Resources.Color.textNavy
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")!.withTintColor(Resources.Color.textNavy, renderingMode: .alwaysOriginal)
        chevronImageView.image = chevronImage
        chevronImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func layout() {
        stackView.addArrangedSubview(bookNameLabel)
        stackView.addArrangedSubview(authorLabel)
        cellView.addSubview(stackView)
        cellView.addSubview(chevronImageView)
        contentView.addSubview(cellView)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
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
