//
//  SavedBookManagerTests.swift
//  BibliothequeTests
//
//  Created by Artem Marhaza on 19/05/2023.
//

import XCTest
import CoreData
@testable import Bibliotheque

final class SavedBookManagerTests: XCTestCase {
    var savedBookManager: SavedBookManager!
    var coreDataStack: CoreDataTestStack!
    
    struct CoreDataTestStack {
        let persistentContainer: NSPersistentContainer
        let context: NSManagedObjectContext
        
        init() {
            persistentContainer = NSPersistentContainer(name: "Bibliotheque")
            let desctiption = persistentContainer.persistentStoreDescriptions.first
            desctiption?.type = NSInMemoryStoreType
            
            persistentContainer.loadPersistentStores { storeDescription, error in
                if let error = error {
                    fatalError("Loading of store failed \(error)")
                }
            }
            context = persistentContainer.viewContext
        }
    }
    
    let book = Book(artistName: "Frank Herbert", trackName: "Dune", genres: ["Classics", "Fantasy", "Epic"], description: "Test Description", releaseDate: "1975-09-01", artworkUrl100: "http://testurl.com", averageUserRating: 4.5)
    
    func assertEqual(actualBook: BookEntity, expectedBook: Book) {
        XCTAssertEqual(actualBook.artistName, expectedBook.artistName)
        XCTAssertEqual(actualBook.trackName, expectedBook.trackName)
        XCTAssertEqual(actualBook.genres, expectedBook.displayableGenres)
        XCTAssertEqual(actualBook.bookDescription, expectedBook.description)
        XCTAssertEqual(actualBook.releaseDate, expectedBook.displayableReleaseDate)
        XCTAssertEqual(actualBook.averageUserRating, expectedBook.displayableRating)
    }

    override func setUp() {
        super.setUp()
        
        coreDataStack = CoreDataTestStack()
        savedBookManager = SavedBookManager(context: coreDataStack.context)
    }

    func testSaveBook() throws {
        let actualBook = savedBookManager.saveBook(book: book, imageData: nil)!
        
        assertEqual(actualBook: actualBook, expectedBook: book)
        XCTAssertFalse(actualBook.isRead)
    }
    
    func testUpdateBook() throws {
        let savedBook = savedBookManager.saveBook(book: book, imageData: nil)!
        
        savedBook.isRead = true
        savedBookManager.updateBook(book: savedBook)
        
        XCTAssertTrue(savedBook.isRead)
    }
    
    func testFetchBook() throws {
        let expectedBook = savedBookManager.saveBook(book: book, imageData: nil)
        
        let actualBook = savedBookManager.fetchBook(withName: book.trackName)
        
        XCTAssertEqual(actualBook, expectedBook)
    }
    
    func testFetchNotReadBooks() throws {
        let anotherBook = Book(artistName: "Brandon Sanderson", trackName: "Mistborn", genres: ["Sci-Fi & Fantasy", "Epic"], description: "Test Description", releaseDate: "2010-04-01", artworkUrl100: "http://testurl.com", averageUserRating: 4.5)
        
        let books = [savedBookManager.saveBook(book: book, imageData: nil)!,
                     savedBookManager.saveBook(book: anotherBook, imageData: nil)!]
        
        let savedBooks = savedBookManager.fetchBooks()!
        
        let actualBooks = savedBooks.sorted { $0.trackName! > $1.trackName! }
        let expectedBooks = books.sorted { $0.trackName! > $1.trackName! }
        
        XCTAssertEqual(actualBooks, expectedBooks)
        XCTAssertFalse(expectedBooks[0].isRead)
        XCTAssertFalse(expectedBooks[1].isRead)

    }
    
    func testFetchReadBooks() throws {
        let anotherBook = Book(artistName: "Brandon Sanderson", trackName: "Mistborn", genres: ["Sci-Fi & Fantasy", "Epic"], description: "Test Description", releaseDate: "2010-04-01", artworkUrl100: "http://testurl.com", averageUserRating: 4.5)
        
        let _ = savedBookManager.saveBook(book: book, imageData: nil)
        
        let readBook = savedBookManager.saveBook(book: anotherBook, imageData: nil)!
        readBook.isRead = true
        savedBookManager.updateBook(book: readBook)
        
        let actualBooks = savedBookManager.fetchBooks(isRead: true)!
        
        XCTAssertEqual(actualBooks.count, 1)
        assertEqual(actualBook: actualBooks[0], expectedBook: anotherBook)
        XCTAssertTrue(actualBooks[0].isRead)
    }
    
    func testDeleteBook() throws {
        let _ = savedBookManager.saveBook(book: book, imageData: nil)
        
        savedBookManager.deleteBook(withName: book.trackName)
        
        let notReadBooks = savedBookManager.fetchBooks()!
        let readBooks = savedBookManager.fetchBooks(isRead: true)!
        
        XCTAssertEqual(notReadBooks.count, 0)
        XCTAssertEqual(readBooks.count, 0)
    }
}
