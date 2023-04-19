//
//  NetworkService.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 13/04/2023.
//

import UIKit

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
}

struct Books: Codable {
    let resultCount: Int
    let results: [Book]
}

class NetworkService {
    func fetchBooks(containing searchText: String, completion: @escaping (Result<Books, NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchText)&media=ebook") else
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
