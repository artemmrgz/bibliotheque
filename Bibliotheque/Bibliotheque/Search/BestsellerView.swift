//
//  BestsellerView.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 16/04/2023.
//

import UIKit

class BestsellerView: UIView {
    
    let height: CGFloat = 180
    let category: String
    
    let logoImageView = UIImageView()
    let textLabel = UILabel()
    
    init(category: String) {
        self.category = category
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Resources.Color.textNavy
        layer.cornerRadius = 200 * 10 / 57
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "nyt-logo")
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.attributedText = makeFormattedText(category: category)
    }
    
    private func layout() {
        addSubview(logoImageView)
        addSubview(textLabel)

        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: height),
            
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            textLabel.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: logoImageView.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }
    
    private func makeFormattedText(category: String) -> NSAttributedString {
        var categoryYellowAttrString = [NSAttributedString.Key: AnyObject]()
        categoryYellowAttrString[.font] = UIFont.systemFont(ofSize: 40, weight: .bold)
        categoryYellowAttrString[.foregroundColor] = Resources.Color.accentYellow
        
        var bestsellerGrayAttrString = [NSAttributedString.Key: AnyObject]()
        bestsellerGrayAttrString[.font] = UIFont.systemFont(ofSize: 40, weight: .light)
        bestsellerGrayAttrString[.foregroundColor] = UIColor.systemGray3
        
        let attrText = NSMutableAttributedString(string: category, attributes: categoryYellowAttrString)
        attrText.append(NSAttributedString(string: " Bestsellers", attributes: bestsellerGrayAttrString))

        return attrText
    }
}
