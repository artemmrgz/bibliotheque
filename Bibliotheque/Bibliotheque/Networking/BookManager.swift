//
//  BookManager.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 17/05/2023.
//

import UIKit

protocol BookManageable {
    func fetchBooks(containing searchText: String, completion: @escaping (Result<Books, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case serverError
    case decodingError
}

struct Book: Codable {
    let artistName: String
    let trackName: String
    let genres: [String]
    let description: String
    let releaseDate: String
    let artworkUrl100: String?
    let averageUserRating: Float?
    
    var displayableGenres: String {
        return genres.joined(separator: ", ")
    }
    
    var displayableReleaseDate: String {
        return releaseDate.components(separatedBy: "T")[0]
    }
    
    var displayableRating: String? {
        guard let userRating = averageUserRating else { return nil}
        return String(describing: userRating)
    }
}

struct Books: Codable {
    let resultCount: Int
    let results: [Book]
}

struct BookManager: BookManageable {
    let url = "https://itunes.apple.com/search?media=ebook&term="
    
    func fetchBooks(containing searchText: String, completion: @escaping (Result<Books, NetworkError>) -> Void) {
        
        guard let url = URL(string: url + searchText) else
        { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let books = try JSONDecoder().decode(Books.self, from: data)
                    completion(.success(books))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
