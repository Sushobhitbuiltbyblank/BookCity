//
//  Categories+CoreDataProperties.swift
//  
//
//  Created by Sushobhit_BuiltByBlank on 12/2/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Categories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories");
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
