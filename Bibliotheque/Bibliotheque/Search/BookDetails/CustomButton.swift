//
//  CustomButton.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 19/04/2023.
//

import UIKit

class CustomButton: UIButton {
    
    let defaultTitle: String
    let selectedTitle: String
    var isSelectedState = false

    init(defaultTitle: String, selectedTitle: String) {
        self.defaultTitle = defaultTitle
        self.selectedTitle = selectedTitle
        
        super.init(frame: .zero)
        
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        setDefaultStyle()
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.7
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = 8
    }
    
    func setDefaultStyle() {
        backgroundColor = Resources.Color.textNavy
        setTitle(defaultTitle, for: .normal)
        setTitleColor(Resources.Color.accentYellow, for: .normal)
    }
    
    func setSelectedStyle() {
        backgroundColor = UIColor.gray
        setTitle(selectedTitle, for: .normal)
        setTitleColor(Resources.Color.textNavy, for: .normal)
    }
}
