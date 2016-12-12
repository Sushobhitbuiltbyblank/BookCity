//
//  JSONCountry.swift
//  Bookcountries
//
//  Created by Sushobhit_BuiltByBlank on 12/12/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class JSONCountry: NSObject {
    var id:String!
    var name:String?
    var sortname:String!
    
    // construct a JSONCountry from a dictionary
    init(dictionary: [String:AnyObject]) {
        id = dictionary[Constants.JSONCountryResponseKey.Id] as! String
        name = dictionary[Constants.JSONCountryResponseKey.Name] as? String
        sortname = dictionary[Constants.JSONCountryResponseKey.SortName] as! String
    }
    
    static func countryFromResults(_ results: [[String:AnyObject]]) -> [JSONCountry] {
        var countries = [JSONCountry]()
        
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            countries.append(JSONCountry(dictionary: result))
        }
        return countries
    }
    
    static func countryFromCoreData(_ results: [Country])->[JSONCountry] {
        var countries = [JSONCountry]()
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            var dictionary = [String:AnyObject]()
            dictionary[Constants.JSONCountryResponseKey.Name] = result.value(forKeyPath: Constants.JSONCountryResponseKey.Name) as AnyObject?
            dictionary[Constants.JSONCountryResponseKey.Id] = result.value(forKeyPath: Constants.JSONCountryResponseKey.Id) as AnyObject?
            dictionary[Constants.JSONCountryResponseKey.SortName] = result.value(forKeyPath: Constants.JSONCountryResponseKey.SortName) as AnyObject?
            countries.append(JSONCountry(dictionary:dictionary))
        }
        return countries
    }
    
    static func countryForCDRecord(_ country:Country) -> JSONCountry {
        var dictionary = [String:AnyObject]()
        dictionary[Constants.JSONCountryResponseKey.Name] = country.value(forKeyPath: Constants.JSONCountryResponseKey.Name) as AnyObject?
        dictionary[Constants.JSONCountryResponseKey.Id] = country.value(forKeyPath: Constants.JSONCountryResponseKey.Id) as AnyObject?
        dictionary[Constants.JSONCountryResponseKey.SortName] = country.value(forKeyPath: Constants.JSONCountryResponseKey.SortName) as AnyObject?
        return JSONCountry(dictionary:dictionary)

    }

}
