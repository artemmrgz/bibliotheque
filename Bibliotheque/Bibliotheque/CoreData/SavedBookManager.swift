//
//  SavedBookManager.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 20/04/2023.
//

import UIKit
import CoreData

protocol SavedBookManageable {
    func saveBook(book: Book, imageData: Data?) -> BookEntity?
    func fetchBooks(isRead: Bool) -> [BookEntity]?
    func fetchBook(withName name: String) -> BookEntity?
    func updateBook(book: BookEntity)
    func deleteBook(withName name: String)
}

struct SavedBookManager: SavedBookManageable {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }
    
    func saveBook(book: Book, imageData: Data?) -> BookEntity? {
        
        let bookEntity = NSEntityDescription.insertNewObject(forEntityName: "BookEntity", into: context) as! BookEntity
        
        bookEntity.artistName = book.artistName
        bookEntity.trackName = book.trackName
        bookEntity.genres = book.displayableGenres
        bookEntity.bookDescription = book.description
        bookEntity.releaseDate = book.displayableReleaseDate
        bookEntity.averageUserRating = book.displayableRating
        bookEntity.imageData = imageData
        
        do {
            try context.save()
            return bookEntity
        } catch let createError {
            print("Failed to create: \(createError)")
        }
        
        return nil
    }
    
    func fetchBooks(isRead: Bool = false) -> [BookEntity]? {
        
        let fetchRequest = BookEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isRead = %d", isRead)
        
        do {
            let books = try context.fetch(fetchRequest)
            return books
        } catch let fetchError {
            print("Failed to fetch books: \(fetchError)")
        }
        
        return nil
    }
    
    func fetchBook(withName name: String) -> BookEntity? {
        
        let fetchRequest = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "trackName == %@", name)
        
        do {
            let books = try context.fetch(fetchRequest)
            return books.first
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }
        
        return nil
    }
    
    func updateBook(book: BookEntity) {
        
        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
    }
    
    func deleteBook(withName name: String) {
        
        let book = fetchBook(withName: name)
        if let book = book {
            context.delete(book)
        }
        
        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
    }
}
