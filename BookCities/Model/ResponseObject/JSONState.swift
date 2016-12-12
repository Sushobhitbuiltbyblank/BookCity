//
//  JSONState.swift
//  BookCities
//
//  Created by Sushobhit_BuiltByBlank on 12/12/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class JSONState: NSObject {
    
    var id:String!
    var name:String?
    var country_id:String!
    
    // construct a JSONstates from a dictionary
    init(dictionary: [String:AnyObject]) {
        id = dictionary[Constants.JSONStateResponseKey.Id] as! String
        name = dictionary[Constants.JSONStateResponseKey.Name] as? String
        country_id = dictionary[Constants.JSONStateResponseKey.Country_id] as! String
    }
    
    static func stateFromResults(_ results: [[String:AnyObject]]) -> [JSONState] {
        var states = [JSONState]()
        
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            states.append(JSONState(dictionary: result))
        }
        return states
    }
    
    static func stateFromCoreData(_ results: [State])->[JSONState] {
        var states = [JSONState]()
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            var dictionary = [String:AnyObject]()
            dictionary[Constants.JSONStateResponseKey.Name] = result.value(forKeyPath: Constants.JSONStateResponseKey.Name) as AnyObject?
            dictionary[Constants.JSONStateResponseKey.Id] = result.value(forKeyPath: Constants.JSONStateResponseKey.Id) as AnyObject?
            dictionary[Constants.JSONStateResponseKey.Country_id] = result.value(forKeyPath: Constants.JSONStateResponseKey.Country_id) as AnyObject?
            states.append(JSONState(dictionary:dictionary))
        }
        return states
    }
    
    static func stateFromCDRecord(_ state:State)-> JSONState
    {
        var dictionary = [String:AnyObject]()
        dictionary[Constants.JSONStateResponseKey.Name] = state.value(forKeyPath: Constants.JSONStateResponseKey.Name) as AnyObject?
        dictionary[Constants.JSONStateResponseKey.Id] = state.value(forKeyPath: Constants.JSONStateResponseKey.Id) as AnyObject?
        dictionary[Constants.JSONStateResponseKey.Country_id] = state.value(forKeyPath: Constants.JSONStateResponseKey.Country_id) as AnyObject?
        return JSONState(dictionary:dictionary)
    }

}
