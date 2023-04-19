//
//  UnderlineView.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 19/04/2023.
//

import UIKit

class UnderlineView: UIView {
    let underline = UIView()
    let color: UIColor
    
    init(color: UIColor) {
        self.color = color
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = color
    }
    
    private func layout() {
        addSubview(underline)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 16),
            
            underline.heightAnchor.constraint(equalToConstant: 4),
            underline.widthAnchor.constraint(equalToConstant: 60),
            underline.centerXAnchor.constraint(equalTo: centerXAnchor),
            underline.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
