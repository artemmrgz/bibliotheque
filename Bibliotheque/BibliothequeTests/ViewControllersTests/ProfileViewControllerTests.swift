//
//  ProfileViewControllerTests.swift
//  BibliothequeTests
//
//  Created by Artem Marhaza on 20/05/2023.
//

import XCTest
@testable import Bibliotheque

final class ProfileViewControllerTests: XCTestCase {
    var vc: ProfileViewController!
    var mockSavedBookManager: MockSavedBookManager!
    
    struct MockSavedBookManager: SavedBookManageable {
        
        let savedBooks = 5
        let readBooks = 2
        
        private func generateBooks(amount: Int) -> [BookEntity] {
            var books = [BookEntity]()
            
            for _ in 0..<amount {
                books.append(BookEntity())
            }
            return books
        }
        
        func saveBook(book: Bibliotheque.Book, imageData: Data?) -> Bibliotheque.BookEntity? {
            return nil
        }
        
        func fetchBooks(isRead: Bool) -> [Bibliotheque.BookEntity]? {
            if isRead {
                return generateBooks(amount: readBooks)
            }
            return generateBooks(amount: savedBooks)
        }
        
        func fetchBook(withName name: String) -> Bibliotheque.BookEntity? {
            return nil
        }
        
        func updateBook(book: Bibliotheque.BookEntity) {
        }
        
        func deleteBook(withName name: String) {
        }
    }
    

    override func setUp() {
        vc = ProfileViewController()
        mockSavedBookManager = MockSavedBookManager()
        vc.savedBookManager = mockSavedBookManager
    }

    override func tearDown() {
        vc = nil
    }
    
    func testGetSavedTotal() throws {
        let actual = vc.forceGetSavedTotal()!
        let expected = String(describing: mockSavedBookManager.savedBooks)
        
        XCTAssertEqual(actual, expected)
    }
    
    func testGetReadTotal() throws {
        let actual = vc.forceGetReadTotal()!
        let expected = String(describing: mockSavedBookManager.readBooks)
        
        XCTAssertEqual(actual, expected)
    }

    func testConfigureStatisticsViews() throws {
        vc.viewWillAppear(true)
        
        let actualSaved = vc.savedBooks.numberLabel.text
        let actualRead = vc.readBooks.numberLabel.text
        
        let expectedSaved = String(describing: mockSavedBookManager.savedBooks)
        let expectedRead = String(describing: mockSavedBookManager.readBooks)
        
        XCTAssertEqual(actualSaved, expectedSaved)
        XCTAssertEqual(actualRead, expectedRead)
    }
}
