//
//  UIImageView+Networking.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 13/04/2023.
//

import UIKit

extension UIImageView {
    func downloaded(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
