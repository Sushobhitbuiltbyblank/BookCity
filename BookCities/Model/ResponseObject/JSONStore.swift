//
//  JSONStore.swift
//  BookCities
//
//  Created by Sushobhit_BuiltByBlank on 11/29/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class JSONStore: NSObject {
    let address:String?
    let books_category_ids:String?
    let id:String?
    let is_museumshops:String?
    let is_new_books:String?
    let is_used_books:String?
    let latitude:String?
    let longitude:String?
    let name:String?
    let website:String?
    let address_2:String?
    let country:String?
    let state:String?
    let city:String?
    let working_hours:String?
    let zipcode:String?
    var isFavorate:Bool?
    init(dictionary: [String:AnyObject]) {
        self.address = dictionary[Constants.JSONStoreResponseKey.Address] as? String
        self.books_category_ids = dictionary[Constants.JSONStoreResponseKey.BookCategoryIds] as? String
        self.id = dictionary[Constants.JSONStoreResponseKey.Id] as? String
        self.is_museumshops = dictionary[Constants.JSONStoreResponseKey.IsMuseumshops] as? String
        self.is_new_books = dictionary[Constants.JSONStoreResponseKey.IsNewBooks] as? String
        self.is_used_books = dictionary[Constants.JSONStoreResponseKey.IsUsedBooks] as? String
        self.latitude = dictionary[Constants.JSONStoreResponseKey.Latitude] as? String
        self.longitude = dictionary[Constants.JSONStoreResponseKey.Longitude] as? String
        self.name = dictionary[Constants.JSONStoreResponseKey.Name] as? String
        self.website = dictionary[Constants.JSONStoreResponseKey.Website] as? String
        self.address_2 = dictionary[Constants.JSONStoreResponseKey.Address_2] as? String
        self.working_hours = dictionary[Constants.JSONStoreResponseKey.WorkingHours] as? String
        self.city = dictionary[Constants.JSONStoreResponseKey.City] as? String
        self.state = dictionary[Constants.JSONStoreResponseKey.State] as? String
        self.country = dictionary[Constants.JSONStoreResponseKey.Country] as? String
        self.zipcode = dictionary[Constants.JSONStoreResponseKey.Zipcode] as? String
        self.isFavorate = false
    }
    
    static func storeFromResults(_ results: [[String:AnyObject]]) -> [JSONStore] {
        
        var stores = [JSONStore]()
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            stores.append(JSONStore(dictionary: result))
        }
        return stores
    }

    static func storeFromCoreData(_ results: [Store]) -> [JSONStore] {
        
        var stores = [JSONStore]()
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            var dictionary = [String:AnyObject]()
            dictionary[Constants.JSONStoreResponseKey.Address] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Address) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.BookCategoryIds] = result.value(forKeyPath: Constants.JSONStoreResponseKey.BookCategoryIds)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.IsMuseumshops] = result.value(forKeyPath: Constants.JSONStoreResponseKey.IsMuseumshops)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.IsNewBooks] = result.value(forKeyPath: Constants.JSONStoreResponseKey.IsNewBooks)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.IsUsedBooks] = result.value(forKeyPath: Constants.JSONStoreResponseKey.IsUsedBooks)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.Latitude] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Latitude)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.Longitude] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Longitude)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.Name] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Name)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.Website] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Website)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.Address_2] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Address_2)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.WorkingHours] = result.value(forKeyPath: Constants.JSONStoreResponseKey.WorkingHours)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.City] = result.value(forKeyPath: Constants.JSONStoreResponseKey.City)as AnyObject?
             dictionary[Constants.JSONStoreResponseKey.State] = result.value(forKeyPath: Constants.JSONStoreResponseKey.State)as AnyObject?
             dictionary[Constants.JSONStoreResponseKey.Country] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Country)as AnyObject?
             dictionary[Constants.JSONStoreResponseKey.Zipcode] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Zipcode)as AnyObject?
            stores.append(JSONStore(dictionary: dictionary))
        }
        return stores
    }
    
    static func getStoreFromCDRecord(_ store:Store)->JSONStore{
        
        var dictionary = [String:AnyObject]()
        dictionary[Constants.JSONStoreResponseKey.Address] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Address) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.BookCategoryIds] = store.value(forKeyPath: Constants.JSONStoreResponseKey.BookCategoryIds)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.IsMuseumshops] = store.value(forKeyPath: Constants.JSONStoreResponseKey.IsMuseumshops)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.IsNewBooks] = store.value(forKeyPath: Constants.JSONStoreResponseKey.IsNewBooks)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.IsUsedBooks] = store.value(forKeyPath: Constants.JSONStoreResponseKey.IsUsedBooks)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.Latitude] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Latitude)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.Longitude] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Longitude)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.Name] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Name)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.Website] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Website)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.Address_2] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Address_2)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.WorkingHours] = store.value(forKeyPath: Constants.JSONStoreResponseKey.WorkingHours)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.City] = store.value(forKeyPath: Constants.JSONStoreResponseKey.City)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.State] = store.value(forKeyPath: Constants.JSONStoreResponseKey.State)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.Country] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Country)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.Zipcode] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Zipcode)as AnyObject?
        return JSONStore(dictionary:dictionary)

    }

}
