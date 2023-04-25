//
//  StatisticsView.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 25/04/2023.
//

import UIKit

class StatisticsView: UIView {
    
    var height: CGFloat? {
        didSet {
            guard let height = height else { return }
            layer.cornerRadius = height * 0.17
        }
    }
    
    let infoView = UIView()
    let categoryLabel = UILabel()
    let numberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        backgroundColor = Resources.Color.textNavy
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.textColor = UIColor.systemGray3
        categoryLabel.font = .systemFont(ofSize: 20)
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.textColor = Resources.Color.accentYellow
        numberLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func layout() {
        addSubview(categoryLabel)
        addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
    
    func configureWith(category: String, number: String) {
        categoryLabel.text = category
        numberLabel.text = number
    }
}
