//
//  ReadingListCell.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 19/04/2023.
//

import UIKit

class ReadingListCell: CustomCell {

    override static var reuseID: String {
        return "ReadingListCell"
    }
    
    let removeButton = CustomButton(defaultTitle: "Remove", selectedTitle: "Add")
    
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
        
        NSLayoutConstraint.activate([
            
            
            removeButton.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            removeButton.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
            removeButton.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -16),
            removeButton.heightAnchor.constraint(equalToConstant: 30),
            removeButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    @objc func removeButtonTapped(sender: UIButton) {
        
    }
}

