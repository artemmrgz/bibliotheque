//
//  BookDataTests.swift
//  BibliothequeTests
//
//  Created by Artem Marhaza on 17/05/2023.
//

import XCTest
@testable import Bibliotheque

final class BookDataTests: XCTestCase {

    func testCanParseBooks() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "Books", ofType: "json") else {
            fatalError("JSON not found")
        }
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert JSON to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let booksData = try! JSONDecoder().decode(Books.self, from: jsonData)
        
        XCTAssertEqual(booksData.resultCount, 2)
        XCTAssertEqual(booksData.results.count, 2)
        
        let firstBook = booksData.results[0]
        let secondBook = booksData.results[1]
        
        XCTAssertEqual(firstBook.artistName, "Brandon Sanderson")
        XCTAssertEqual(firstBook.trackName, "Tress of the Emerald Sea")
        XCTAssertEqual(firstBook.genres, ["Epic", "Books", "Sci-Fi & Fantasy", "Fantasy", "Fiction & Literature"])
        XCTAssertEqual(firstBook.releaseDate, "2023-01-10T08:00:00Z")
        XCTAssertEqual(firstBook.averageUserRating, 4.5)
        XCTAssertNotNil(firstBook.description)
        
        XCTAssertEqual(secondBook.artistName, "Brandon Sanderson")
        XCTAssertEqual(secondBook.trackName, "Mistborn")
        XCTAssertEqual(secondBook.genres, ["Epic", "Books", "Sci-Fi & Fantasy", "Fantasy"])
        XCTAssertEqual(secondBook.releaseDate, "2010-04-01T07:00:00Z")
        XCTAssertEqual(secondBook.averageUserRating, 4.5)
        XCTAssertNotNil(secondBook.description)
    }
    
    func testCanParseWithEmptyRatingAndArtworkUrl() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "BooksWithEmptyFields", ofType: "json") else {
            fatalError("JSON not found")
        }
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert JSON to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let books = try! JSONDecoder().decode(Books.self, from: jsonData)
        
        XCTAssertEqual(books.results.count, 1)
        
        let book = books.results[0]
        
        XCTAssertNil(book.artworkUrl100)
        XCTAssertNil(book.averageUserRating)
    }
}
