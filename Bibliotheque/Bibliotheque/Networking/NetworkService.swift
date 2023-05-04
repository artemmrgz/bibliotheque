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

struct BestsellerBook: Codable {
    let title: String
    let author: String
    let description: String
    let rank: Int
    let rankLastWeek: Int
    let weeksOnList: Int
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case description
        case rank
        case rankLastWeek = "rank_last_week"
        case weeksOnList = "weeks_on_list"
        case imageUrl = "book_image"
    }
}

struct BestsellerBooks: Codable {
    struct Results: Codable {
        let books: [BestsellerBook]
    }

    let results: Results
}

enum BestsellerCategory {
    static let fiction = "combined-print-and-e-book-fiction"
    static let nonFiction = "combined-print-and-e-book-nonfiction"
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
    
    func fetchBestsellers(for category: String, completion: @escaping (Result<[BestsellerBook], NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/current/\(category).json?api-key=OJ34pf2PBwtltgxctAeZea6zqYSAqnsw") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let books = try JSONDecoder().decode(BestsellerBooks.self, from: data)
                    completion(.success(books.results.books))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
