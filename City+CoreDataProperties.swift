//
//  City+CoreDataProperties.swift
//  
//
//  Created by Sushobhit_BuiltByBlank on 12/2/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City");
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var state_id: String?
    @NSManaged public var country_id: String?
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension City {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: Store)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: Store)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}
