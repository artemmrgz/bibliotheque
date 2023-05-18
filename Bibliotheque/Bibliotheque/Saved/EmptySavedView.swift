//
//  EmptySavedView.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 18/05/2023.
//

import UIKit

class EmptySavedView: UIView {
    let imageView = UIImageView(image: UIImage(systemName: "text.book.closed")!)
    let textLabel = UILabel()
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 200, height: 200)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        backgroundColor = .white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = Resources.Color.textNavy
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "There are no books yet"
        textLabel.textColor = Resources.Color.textNavy
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 20)
        textLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func layout() {
        addSubview(imageView)
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}


