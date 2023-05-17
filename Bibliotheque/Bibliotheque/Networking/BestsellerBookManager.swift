//
//  BestsellerBookManager.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 13/04/2023.
//

import UIKit

protocol BestsellerBookManageable {
    func fetchBooks(for category: BestsellerCategory, completion: @escaping (Result<[BestsellerBook], NetworkError>) -> Void)
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
    case fiction
    case nonFiction
}

struct BestsellerBookManager: BestsellerBookManageable {
    
    let baseUrl = "https://api.nytimes.com/svc/books/v3/lists/current/"
    let apiKey = "OJ34pf2PBwtltgxctAeZea6zqYSAqnsw"
    
    
    private func buildQueryUrl(_ baseUrl: URL, queryParams: [String: String]) -> URL? {
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
        
        var queryItems = [URLQueryItem]()
        for item in queryParams {
            queryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        
        components?.queryItems = queryItems
        return components?.url
    }
    
    func fetchBooks(for category: BestsellerCategory, completion: @escaping (Result<[BestsellerBook], NetworkError>) -> Void) {
        
        let urlString: String!
        
        switch category {
        case .fiction:
            urlString = baseUrl + "combined-print-and-e-book-fiction.json"
        case .nonFiction:
            urlString = baseUrl + "combined-print-and-e-book-nonfiction.json"
        }
        
        guard let baseUrl = URL(string: urlString),
              let queryUrl = buildQueryUrl(baseUrl, queryParams: ["api-key": apiKey]) else { return }
        
        URLSession.shared.dataTask(with: queryUrl) { data, response, error in
            
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
