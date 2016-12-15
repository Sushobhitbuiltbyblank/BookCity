//
//  State+CoreDataProperties.swift
//  
//
//  Created by Sushobhit_BuiltByBlank on 12/13/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension State {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<State> {
        return NSFetchRequest<State>(entityName: "State");
    }

    @NSManaged public var country_id: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
