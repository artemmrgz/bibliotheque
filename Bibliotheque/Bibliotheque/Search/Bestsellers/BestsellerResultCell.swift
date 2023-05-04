//
//  BestsellerResultCell.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 03/05/2023.
//

import UIKit

class BestsellerResultCell: UITableViewCell {
    
    static let reuseID = "BestsellerResultCell"
    
    let cellView = UIView()
    let rankView = UIView()
    
    let authorLabel = UILabel()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let rankLabel = UILabel()
    let separator = UIView()
    let weeksOnList = UILabel()
    let coverImageView = UIImageView()
    
    let titleAuthorSV = UIStackView()
    let coverTitleAuthorSV = UIStackView()
    let descriptionCoverTitleAuthorSV = UIStackView()
    let rankSV = UIStackView()
    
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
        
        rankView.translatesAutoresizingMaskIntoConstraints = false
        rankView.layer.cornerRadius = 10
        rankView.backgroundColor = Resources.Color.textNavy
        rankView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        titleAuthorSV.translatesAutoresizingMaskIntoConstraints = false
        titleAuthorSV.axis = .vertical
        titleAuthorSV.spacing = 8
        titleAuthorSV.distribution = .fillEqually
        
        coverTitleAuthorSV.translatesAutoresizingMaskIntoConstraints = false
        coverTitleAuthorSV.spacing = 8
        
        descriptionCoverTitleAuthorSV.translatesAutoresizingMaskIntoConstraints = false
        descriptionCoverTitleAuthorSV.axis = .vertical
        descriptionCoverTitleAuthorSV.spacing = 8
        descriptionCoverTitleAuthorSV.distribution = .equalCentering
        
        rankSV.translatesAutoresizingMaskIntoConstraints = false
        rankSV.axis = .vertical
        rankSV.spacing = 8
        rankSV.distribution = .fillEqually
        rankSV.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textColor = Resources.Color.textNavy
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        authorLabel.numberOfLines = 0
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        descriptionLabel.numberOfLines = 0
        
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.layer.cornerRadius = 8
        coverImageView.clipsToBounds = true
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.backgroundColor = .systemGreen
        
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankLabel.textAlignment = .center
        rankLabel.adjustsFontSizeToFitWidth = true
        rankLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        weeksOnList.translatesAutoresizingMaskIntoConstraints = false
        weeksOnList.numberOfLines = 0
        weeksOnList.textAlignment = .center
        weeksOnList.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = Resources.Color.secondaryAccentGray
        separator.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func layout() {
        titleAuthorSV.addArrangedSubview(titleLabel)
        titleAuthorSV.addArrangedSubview(authorLabel)
        coverTitleAuthorSV.addArrangedSubview(coverImageView)
        coverTitleAuthorSV.addArrangedSubview(titleAuthorSV)
        descriptionCoverTitleAuthorSV.addArrangedSubview(coverTitleAuthorSV)
        descriptionCoverTitleAuthorSV.addArrangedSubview(descriptionLabel)
        
        rankView.addSubview(rankLabel)
        rankView.addSubview(weeksOnList)
        rankView.addSubview(separator)
        
        cellView.addSubview(rankView)
        cellView.addSubview(descriptionCoverTitleAuthorSV)
        contentView.addSubview(cellView)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            rankView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8),
            rankView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8),
            rankView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
            rankView.widthAnchor.constraint(equalToConstant: 70),
            
            descriptionCoverTitleAuthorSV.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8),
            descriptionCoverTitleAuthorSV.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8),
            descriptionCoverTitleAuthorSV.leadingAnchor.constraint(equalTo: rankView.trailingAnchor, constant: 8),
            descriptionCoverTitleAuthorSV.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8),
            
            rankLabel.topAnchor.constraint(equalTo: rankView.topAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: rankView.leadingAnchor, constant: 4),
            rankLabel.trailingAnchor.constraint(equalTo: rankView.trailingAnchor, constant: -4),
            rankLabel.heightAnchor.constraint(equalTo: rankView.heightAnchor, multiplier: 0.6),
            
            separator.topAnchor.constraint(equalTo: rankLabel.bottomAnchor),
            separator.centerXAnchor.constraint(equalTo: rankView.centerXAnchor),
            separator.heightAnchor.constraint(equalToConstant: 2),
            separator.widthAnchor.constraint(equalTo: rankView.widthAnchor, multiplier: 0.6),
            
            weeksOnList.topAnchor.constraint(equalTo: separator.bottomAnchor),
            weeksOnList.leadingAnchor.constraint(equalTo: rankLabel.leadingAnchor, constant: 4),
            weeksOnList.trailingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: -4),
            weeksOnList.bottomAnchor.constraint(equalTo: rankView.bottomAnchor, constant: -4),
            
            
            coverImageView.widthAnchor.constraint(equalToConstant: 70),
            coverImageView.heightAnchor.constraint(equalToConstant: 110),
        ])
    }
    
    private func makeFormattedText(number: String, description: String) -> NSAttributedString {
        var numberAttrString = [NSAttributedString.Key: AnyObject]()
        numberAttrString[.foregroundColor] = Resources.Color.secondaryAccentGray
        numberAttrString[.font] = UIFont.systemFont(ofSize: 20)

        var descriptionAttrString = [NSAttributedString.Key: AnyObject]()
        descriptionAttrString[.foregroundColor] = Resources.Color.secondaryAccentGray
        descriptionAttrString[.font] = UIFont.systemFont(ofSize: 10)

        let attrText = NSMutableAttributedString(string: number, attributes: numberAttrString)
        attrText.append(NSAttributedString(string: "\n"))
        attrText.append(NSAttributedString(string: description, attributes: descriptionAttrString))

        return attrText
    }
    
    func configureWith(book: BestsellerBook) {
        authorLabel.text = book.author
        titleLabel.text = book.title
        descriptionLabel.text = book.description
        rankLabel.attributedText = RankFormatter().makeAttrebutedRank(currentRank: book.rank, rankLastWeek: book.rankLastWeek)
        weeksOnList.attributedText = makeFormattedText(number: String(describing: book.weeksOnList), description: "weeks on list")
    }
}
