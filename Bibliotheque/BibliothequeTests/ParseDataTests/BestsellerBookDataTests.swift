//
//  BestsellerBookDataTests.swift
//  BibliothequeTests
//
//  Created by Artem Marhaza on 17/05/2023.
//

import XCTest
@testable import Bibliotheque

final class BestsellerBookDataTests: XCTestCase {

    func testCanParse() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "BestsellerBooks", ofType: "json") else {
            fatalError("JSON not found")
        }
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert JSON to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let booksData = try! JSONDecoder().decode(BestsellerBooks.self, from: jsonData)
        
        XCTAssertEqual(booksData.results.books.count, 15)
        
        let firstBook = booksData.results.books[0]
        
        XCTAssertEqual(firstBook.title, "THE 23RD MIDNIGHT")
        XCTAssertEqual(firstBook.author, "James Patterson and Maxine Paetro")
        XCTAssertEqual(firstBook.rank, 1)
        XCTAssertEqual(firstBook.rankLastWeek, 0)
        XCTAssertEqual(firstBook.description, "The 23rd book in the Women’s Murder Club series. Lindsay Boxer tracks a copycat killer.")
        XCTAssertNotNil(firstBook.imageUrl)
    }
}
