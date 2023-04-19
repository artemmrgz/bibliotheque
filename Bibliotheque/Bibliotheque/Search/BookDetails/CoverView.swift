//
//  CoverView.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 17/04/2023.
//

import UIKit

class CoverView: UIView {
    
    let imageView = UIImageView()
    
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    var coverUrl: String? {
        didSet {
            guard let coverUrl = coverUrl else { return }
            imageView.downloaded(from: coverUrl)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    private func layout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 7.0
        imageView.layer.shadowOpacity = 0.5
        addSubview(imageView)
        
        widthConstraint = imageView.widthAnchor.constraint(equalToConstant: 200)
        heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 200)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            widthConstraint!,
            heightConstraint!
        ])
    }
}

extension CoverView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        guard let widthConstraint = widthConstraint,
              let heightConstraint = heightConstraint else { return }
        
        let newSize = 200 - y
        widthConstraint.constant = newSize > 0 ? newSize : 0
        heightConstraint.constant = newSize > 0 ? newSize : 0
        
        let normilizedAlpha = y / 100
        alpha = 1.0 - normilizedAlpha
        
        isHidden = y > 100
    }
}
