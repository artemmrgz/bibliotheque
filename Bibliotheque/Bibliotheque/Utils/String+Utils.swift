//
//  String+Utils.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 18/04/2023.
//

import UIKit

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }
}
