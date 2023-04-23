//
//  CoreDataManager.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 20/04/2023.
//

import UIKit
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Bibliotheque")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        return container
    }()
    
    func saveBook(book: Book, imageData: Data?) -> BookEntity? {
        let context = persistentContainer.viewContext
        
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
    
    func fetchBooks() -> [BookEntity]? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = BookEntity.fetchRequest()
        
        do {
            let books = try context.fetch(fetchRequest)
            return books
        } catch let fetchError {
            print("Failed to fetch books: \(fetchError)")
        }
        
        return nil
    }
    
    func fetchBook(withName name: String) -> BookEntity? {
        let context = persistentContainer.viewContext
        
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
    
    func deleteBook(withName name: String) {
        let context = persistentContainer.viewContext
        
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
