//
//  JSONCity.swift
//  BookCities
//
//  Created by Sushobhit_BuiltByBlank on 11/28/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class JSONCity: NSObject {

    var country_id: String!
    var id:String!
    var name:String?
    var state_id:String!
    
    // construct a JSONCity from a dictionary
    init(dictionary: [String:AnyObject]) {
        country_id = dictionary[Constants.JSONCityResponseKey.Country_id] as! String
        id = dictionary[Constants.JSONCityResponseKey.Id] as! String
        name = dictionary[Constants.JSONCityResponseKey.Name] as? String
        state_id = dictionary[Constants.JSONCityResponseKey.State_id] as! String
    }
    
    static func cityFromResults(_ results: [[String:AnyObject]]) -> [JSONCity] {
        var cities = [JSONCity]()
        
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            cities.append(JSONCity(dictionary: result))
        }
        return cities
    }
    
    static func cityFromCoreData(_ results: [City])->[JSONCity] {
        var cities = [JSONCity]()
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
             var dictionary = [String:AnyObject]()
            dictionary[Constants.JSONCityResponseKey.Name] = result.value(forKeyPath: Constants.JSONCityResponseKey.Name) as AnyObject?
            dictionary[Constants.JSONCityResponseKey.Id] = result.value(forKeyPath: Constants.JSONCityResponseKey.Id) as AnyObject?
            dictionary[Constants.JSONCityResponseKey.Country_id] = result.value(forKeyPath: Constants.JSONCityResponseKey.Country_id) as AnyObject?
            dictionary[Constants.JSONCityResponseKey.State_id] = result.value(forKeyPath: Constants.JSONCityResponseKey.State_id) as AnyObject?
            cities.append(JSONCity(dictionary:dictionary))
        }
        return cities
    }
}

