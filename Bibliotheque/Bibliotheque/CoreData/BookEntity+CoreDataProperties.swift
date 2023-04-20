//
//  BookEntity+CoreDataProperties.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 20/04/2023.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var artistName: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var averageUserRating: String?
    @NSManaged public var bookDescription: String?
    @NSManaged public var genres: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var trackName: String?

}

extension BookEntity : Identifiable {

}
