//
//  SearchViewControllerTests.swift
//  BibliothequeTests
//
//  Created by Artem Marhaza on 17/05/2023.
//

import Foundation
import XCTest
import SPAlert
@testable import Bibliotheque

class SearchViewControllerTests: XCTestCase {
    var vc: TestableSearchViewController!
    var mockBookManager: MockBookManager!
    var mockBestsellerBookManager: MockBestsellerBookManager!
    
    class TestableSearchViewController: SearchViewController {
        var alertTitle: String!
        var alertMessage: String?
        
        override func displaySPAlert(title: String, message: String? = nil, preset: SPAlertIconPreset, haptic: SPAlertHaptic, completion: (() -> Void)? = nil) {
            self.alertTitle = title
            self.alertMessage = message
        }
    }
    
    class MockBookManager: BookManageable {
        var books: Books?
        var error: NetworkError?
        
        private func createBooks(amount: Int) -> [Book] {
            var books = [Book]()
            
            for i in 1...amount {
                let book = Book(artistName: "artistName\(i)", trackName: "trackName\(i)", genres: ["genre\(i)"], description: "description\(i)", releaseDate: "releaseDate\(i)", artworkUrl100: "artworkUrl100\(i)", averageUserRating: Float(i))
                books.append(book)
            }
            
            return books
        }
        
        func fetchBooks(containing searchText: String, completion: @escaping (Result<Bibliotheque.Books, Bibliotheque.NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            books = Books(resultCount: 2, results: createBooks(amount: 2))
            completion(.success(books!))
        }
    }
    
    class MockBestsellerBookManager: BestsellerBookManageable {
        var books: [BestsellerBook]?
        var error: NetworkError?
        
        private func createBestsellerBooks(amount: Int) -> [BestsellerBook] {
            var books = [BestsellerBook]()
            
            for i in 1...amount {
                let book = BestsellerBook(title: "title\(i)", author: "author\(i)", description: "description\(i)", rank: i, rankLastWeek: i, weeksOnList: i, imageUrl: "imageUrl\(i)")
                books.append(book)
            }
            
            return books
        }
        
        func fetchBooks(for category: Bibliotheque.BestsellerCategory, completion: @escaping (Result<[Bibliotheque.BestsellerBook], Bibliotheque.NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            books = createBestsellerBooks(amount: 2)
            completion(.success(books!))
        }
    }
    
    override func setUp() {
        super.setUp()
        
        vc = TestableSearchViewController()
        mockBookManager = MockBookManager()
        mockBestsellerBookManager = MockBestsellerBookManager()
        vc.bookManager = mockBookManager
        vc.bestsellerBookManager = mockBestsellerBookManager
    }
    
    func testTitleandMessageForServerError() {
        let (title, message) = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual(title, "Server Error")
        XCTAssertEqual(message, "Please make sure you are connected to the internet")
    }
    
    func testTitleandMessageForDecodingError() {
        let (title, message) = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual(title, "Network Error")
        XCTAssertEqual(message, "We could not process your request. Please try again")
    }
    
    func testAlertForServerErrorWhenFetchingBooks() {
        mockBookManager.error = .serverError
        vc.forceFetchBooks()
        XCTAssertEqual(vc.alertTitle, "Server Error")
        XCTAssertEqual(vc.alertMessage, "Please make sure you are connected to the internet")
    }
    
    func testAlertForDecodingErrorWhenFetchingBooks() {
        mockBookManager.error = .decodingError
        vc.forceFetchBooks()
        XCTAssertEqual(vc.alertTitle, "Network Error")
        XCTAssertEqual(vc.alertMessage, "We could not process your request. Please try again")
    }
    
    func testAlertForServerErrorWhenFetchingBestsellerBooks() {
        mockBestsellerBookManager.error = .serverError
        vc.forceFetchBestsellerBooks()
        XCTAssertEqual(vc.alertTitle, "Server Error")
        XCTAssertEqual(vc.alertMessage, "Please make sure you are connected to the internet")
    }
    
    func testAlertForDecodingErrorWhenFetchingBestsellerBooks() {
        mockBestsellerBookManager.error = .decodingError
        vc.forceFetchBestsellerBooks()
        XCTAssertEqual(vc.alertTitle, "Network Error")
        XCTAssertEqual(vc.alertMessage, "We could not process your request. Please try again")
    }
    
    override func tearDown() {
        super.tearDown()
        
        vc = nil
        mockBookManager = nil
        mockBestsellerBookManager = nil
    }
}
