//
//  GamesFavorite+CoreDataProperties.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 24/02/23.
//
//

import Foundation
import CoreData


extension GamesFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GamesFavorite> {
        return NSFetchRequest<GamesFavorite>(entityName: "GamesFavorite")
    }

    @NSManaged public var gameId: Int16
    @NSManaged public var name: String?
    @NSManaged public var released: String?
    @NSManaged public var rating: Double
    @NSManaged public var playtime: Int16
    @NSManaged public var desc: String?
    @NSManaged public var background_image: String?
    @NSManaged public var developers: String?

}

extension GamesFavorite : Identifiable {

}
