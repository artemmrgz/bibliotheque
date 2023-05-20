//
//  DocumentsManager.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 06/05/2023.
//

import UIKit

struct DocumentsManager {
    private let fileName = "profilePicture.png"
    private var profilePicPath: URL {
        getDocumentsDirectory().appending(path: fileName) }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveProfilePicture(_ profilePic: Data) {
        
        do {
            try profilePic.write(to: profilePicPath)
        } catch {
            print(error)
        }
    }
    
    func getProfilePicture() -> Data? {
        return try? Data(contentsOf: profilePicPath)
    }
}
