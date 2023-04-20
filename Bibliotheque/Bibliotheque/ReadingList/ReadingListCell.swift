//
//  ReadingListCell.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 19/04/2023.
//

import UIKit

class ReadingListCell: CustomCell {
    
    var deleteTapped: () -> () = { }
    override static var reuseID: String {
        return "ReadingListCell"
    }
    
    let removeButton = CustomButton(defaultTitle: "X", selectedTitle: "Add")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        cellView.addSubview(removeButton)
        removeButton.layer.cornerRadius = 20
        removeButton.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            
            
            removeButton.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            removeButton.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            removeButton.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -16),
            removeButton.heightAnchor.constraint(equalToConstant: 40),
            removeButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func removeButtonTapped() {
        deleteTapped()
    }
}

