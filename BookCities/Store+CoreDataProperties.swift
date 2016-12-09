//
//  Store+CoreDataProperties.swift
//  
//
//  Created by Sushobhit_BuiltByBlank on 12/2/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store");
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var is_new_books: String?
    @NSManaged public var is_used_books: String?
    @NSManaged public var is_museumshops: String?
    @NSManaged public var books_category_ids: String?
    @NSManaged public var working_hours: String?
    @NSManaged public var address: String?
    @NSManaged public var address_2: String?
    @NSManaged public var country: String?
    @NSManaged public var state: String?
    @NSManaged public var city: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var website: String?
    @NSManaged public var relationship: City?

}
