//
//  Country+CoreDataProperties.swift
//  
//
//  Created by Sushobhit_BuiltByBlank on 12/12/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country");
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var sortname: String?

}
