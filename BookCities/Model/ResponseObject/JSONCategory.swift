//
//  JSONCategory.swift
//  BookCities
//
//  Created by Sushobhit_BuiltByBlank on 11/30/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class JSONCategory: NSObject {
    let name:String?
    let id: String?
    
    init(dictionary : [String: AnyObject]) {
        self.name = dictionary["name"] as! String?
        self.id = dictionary["id"] as! String?
    }
    
    static func categoryFromResults(_ results: [[String:AnyObject]]) -> [JSONCategory] {
        var category = [JSONCategory]()
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            category.append(JSONCategory(dictionary: result))
        }
        return category

        
    }
}
