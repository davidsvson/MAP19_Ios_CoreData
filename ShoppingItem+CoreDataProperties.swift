//
//  ShoppingItem+CoreDataProperties.swift
//  CoreDataLesson
//
//  Created by David Svensson on 2020-01-29.
//  Copyright © 2020 David Svensson. All rights reserved.
//
//

import Foundation
import CoreData


extension ShoppingItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingItem> {
        return NSFetchRequest<ShoppingItem>(entityName: "ShoppingItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var done: Bool

}
