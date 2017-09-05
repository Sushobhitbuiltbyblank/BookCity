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
    var store_image_dir:String?
    let image1:String?
    let image2:String?
    let image3:String?
    let image4:String?
    var phone:String?
    let by_appointment:String?
    
    let mon_from_hr:String?
    let tue_from_hr:String?
    let wed_from_hr:String?
    let thurs_from_hr:String?
    let fri_from_hr:String?
    let sat_from_hr:String?
    let sun_from_hr:String?
    
    let mon_from_mins:String?
    let tue_from_mins:String?
    let wed_from_mins:String?
    let thurs_from_mins:String?
    let fri_from_mins:String?
    let sat_from_mins:String?
    let sun_from_mins:String?
    
    let mon_to_hr:String?
    let tue_to_hr:String?
    let wed_to_hr:String?
    let thurs_to_hr:String?
    let fri_to_hr:String?
    let sat_to_hr:String?
    let sun_to_hr:String?
    
    let mon_to_mins:String?
    let tue_to_mins:String?
    let wed_to_mins:String?
    let thurs_to_mins:String?
    let fri_to_mins:String?
    let sat_to_mins:String?
    let sun_to_mins:String?
    
    let mon_by_appointment:String?
    let tue_by_appointment:String?
    let wed_by_appointment:String?
    let thurs_by_appointment:String?
    let fri_by_appointment:String?
    let sat_by_appointment:String?
    let sun_by_appointment:String?
    
    let mon_lunch_from_hr:String?
    let mon_lunch_from_mins:String?
    let mon_lunch_to_hr:String?
    let mon_lunch_to_mins:String?
    let tue_lunch_from_hr:String?
    let tue_lunch_from_mins:String?
    let tue_lunch_to_hr:String?
    let tue_lunch_to_mins:String?
    let wed_lunch_from_hr:String?
    let wed_lunch_from_mins:String?
    let wed_lunch_to_hr:String?
    let wed_lunch_to_mins:String?
    let thurs_lunch_from_hr:String?
    let thurs_lunch_from_mins:String?
    let thurs_lunch_to_hr:String?
    let thurs_lunch_to_mins:String?
    let fri_lunch_from_hr:String?
    let fri_lunch_from_mins:String?
    let fri_lunch_to_hr:String?
    let fri_lunch_to_mins:String?
    let sat_lunch_from_hr:String?
    let sat_lunch_from_mins:String?
    let sat_lunch_to_hr:String?
    let sat_lunch_to_mins:String?
    let sun_lunch_from_hr:String?
    let sun_lunch_from_mins:String?
    let sun_lunch_to_hr:String?
    let sun_lunch_to_mins:String?
    
    let descriptions:String?
    var cityName:String?
    
    let on_holiday:String?
    let holiday_from:String?
    let holiday_to:String?
    let holiday_message:String?
    
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
        if let favorate = dictionary[Constants.JSONStoreResponseKey.IsFavorate] as? Bool
        {
            self.isFavorate = favorate
        }
        else{
            self.isFavorate = false
        }
        if let cityNm = dictionary[Constants.CDStoreKey.CityName]  as? String{
            self.cityName = cityNm
        }
        else{
            self.cityName = ""
        }
        self.image1 = dictionary[Constants.JSONStoreResponseKey.Image1] as? String
        self.image2 = dictionary[Constants.JSONStoreResponseKey.Image2] as? String
        self.image3 = dictionary[Constants.JSONStoreResponseKey.Image3] as? String
        self.image4 = dictionary[Constants.JSONStoreResponseKey.Image4] as? String
        self.phone = dictionary[Constants.JSONStoreResponseKey.phone] as? String
        self.descriptions = dictionary[Constants.JSONStoreResponseKey.descriptions] as? String
        self.mon_from_hr = dictionary[Constants.JSONStoreResponseKey.mon_from_hr] as? String
        self.mon_to_hr = dictionary[Constants.JSONStoreResponseKey.mon_to_hr] as? String
        self.mon_from_mins = dictionary[Constants.JSONStoreResponseKey.mon_from_mins] as? String
        self.mon_to_mins = dictionary[Constants.JSONStoreResponseKey.mon_to_mins] as? String
        self.tue_from_hr = dictionary[Constants.JSONStoreResponseKey.tue_from_hr] as? String
        self.tue_to_hr = dictionary[Constants.JSONStoreResponseKey.tue_to_hr] as? String
        self.tue_to_mins = dictionary[Constants.JSONStoreResponseKey.tue_from_mins] as? String
        self.tue_from_mins = dictionary[Constants.JSONStoreResponseKey.tue_to_mins] as? String
        self.wed_from_hr = dictionary[Constants.JSONStoreResponseKey.wed_from_hr] as? String
        self.wed_to_hr = dictionary[Constants.JSONStoreResponseKey.wed_to_hr] as? String
        self.wed_from_mins = dictionary[Constants.JSONStoreResponseKey.wed_from_mins] as? String
        self.wed_to_mins = dictionary[Constants.JSONStoreResponseKey.wed_to_mins] as? String
        self.thurs_from_hr = dictionary[Constants.JSONStoreResponseKey.thurs_from_hr] as? String
        self.thurs_to_hr = dictionary[Constants.JSONStoreResponseKey.thurs_to_hr] as? String
        self.thurs_from_mins = dictionary[Constants.JSONStoreResponseKey.thurs_from_mins] as? String
        self.thurs_to_mins = dictionary[Constants.JSONStoreResponseKey.thurs_to_mins] as? String
        self.fri_from_hr = dictionary[Constants.JSONStoreResponseKey.fri_from_hr] as? String
        self.fri_to_hr = dictionary[Constants.JSONStoreResponseKey.fri_to_hr] as? String
        self.fri_from_mins = dictionary[Constants.JSONStoreResponseKey.fri_from_mins] as? String
        self.fri_to_mins = dictionary[Constants.JSONStoreResponseKey.fri_to_mins] as? String
        self.sat_from_hr = dictionary[Constants.JSONStoreResponseKey.sat_from_hr] as? String
        self.sat_to_hr = dictionary[Constants.JSONStoreResponseKey.sat_to_hr] as? String
        self.sat_from_mins = dictionary[Constants.JSONStoreResponseKey.sat_from_mins] as? String
        self.sat_to_mins = dictionary[Constants.JSONStoreResponseKey.sat_to_mins] as? String
        self.sun_from_hr = dictionary[Constants.JSONStoreResponseKey.sun_from_hr] as? String
        self.sun_to_hr = dictionary[Constants.JSONStoreResponseKey.sun_to_hr] as? String
        self.sun_from_mins = dictionary[Constants.JSONStoreResponseKey.sun_from_mins] as? String
        self.sun_to_mins = dictionary[Constants.JSONStoreResponseKey.sun_to_mins] as? String
        self.store_image_dir = ""
        self.by_appointment = dictionary[Constants.JSONStoreResponseKey.by_appointment] as? String
        self.mon_by_appointment = dictionary[Constants.JSONStoreResponseKey.mon_by_appointment] as? String
        self.tue_by_appointment = dictionary[Constants.JSONStoreResponseKey.tue_by_appointment] as? String
        self.wed_by_appointment = dictionary[Constants.JSONStoreResponseKey.wed_by_appointment] as? String
        self.thurs_by_appointment = dictionary[Constants.JSONStoreResponseKey.thurs_by_appointment] as? String
        self.fri_by_appointment = dictionary[Constants.JSONStoreResponseKey.fri_by_appointment] as? String
        self.sat_by_appointment = dictionary[Constants.JSONStoreResponseKey.sat_by_appointment] as? String
        self.sun_by_appointment = dictionary[Constants.JSONStoreResponseKey.sun_by_appointment] as? String
        self.on_holiday = dictionary[Constants.JSONStoreResponseKey.on_holiday] as? String
        self.holiday_from = dictionary[Constants.JSONStoreResponseKey.holiday_from] as? String
        self.holiday_to = dictionary[Constants.JSONStoreResponseKey.holiday_to] as? String
        self.holiday_message = dictionary[Constants.JSONStoreResponseKey.holiday_message] as? String
        self.mon_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.mon_lunch_from_hr] as? String
        self.mon_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.mon_lunch_from_mins] as? String
        self.mon_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.mon_lunch_to_hr] as? String
        self.mon_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.mon_lunch_to_mins] as? String
        self.tue_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.tue_lunch_from_hr] as? String
        self.tue_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.tue_lunch_from_mins] as? String
        self.tue_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.tue_lunch_to_hr] as? String
        self.tue_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.tue_lunch_to_mins] as? String
        self.wed_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.wed_lunch_from_hr] as? String
        self.wed_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.wed_lunch_from_mins] as? String
        self.wed_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.wed_lunch_to_hr] as? String
        self.wed_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.wed_lunch_to_mins] as? String
        self.thurs_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.thurs_lunch_from_hr] as? String
        self.thurs_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.thurs_lunch_from_mins] as? String
        self.thurs_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.thurs_lunch_to_hr] as? String
        self.thurs_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.thurs_lunch_to_mins] as? String
        self.sat_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.sat_lunch_from_hr] as? String
        self.sat_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.sat_lunch_from_mins] as? String
        self.sat_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.sat_lunch_to_hr] as? String
        self.sat_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.sat_lunch_to_mins] as? String
        self.fri_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.fri_lunch_from_hr] as? String
        self.fri_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.fri_lunch_from_mins] as? String
        self.fri_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.fri_lunch_to_hr] as? String
        self.fri_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.fri_lunch_to_mins] as? String
        self.sun_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.sun_lunch_from_hr] as? String
        self.sun_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.sun_lunch_from_mins] as? String
        self.sun_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.sun_lunch_to_hr] as? String
        self.sun_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.sun_lunch_to_mins] as? String
    }
    
    init(dictionary: [String:AnyObject],storeImageDir:String) {
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
        if let favorate = dictionary[Constants.JSONStoreResponseKey.IsFavorate] as? Bool
        {
            self.isFavorate = favorate
        }
        else{
            self.isFavorate = false
        }
        if let cityNm = dictionary[Constants.CDStoreKey.CityName]  as? String{
            self.cityName = cityNm
        }
        else{
            self.cityName = ""
        }
        self.store_image_dir = storeImageDir
        self.image1 = storeImageDir+(dictionary[Constants.JSONStoreResponseKey.Image1] as? String)!
        self.image2 = storeImageDir+(dictionary[Constants.JSONStoreResponseKey.Image2] as? String)!
        self.image3 = storeImageDir+(dictionary[Constants.JSONStoreResponseKey.Image3] as? String)!
        self.image4 = storeImageDir+(dictionary[Constants.JSONStoreResponseKey.Image4] as? String)!
        self.phone = dictionary[Constants.JSONStoreResponseKey.phone] as? String
        self.descriptions = dictionary[Constants.JSONStoreResponseKey.descriptions] as? String
        self.mon_from_hr = dictionary[Constants.JSONStoreResponseKey.mon_from_hr] as? String
        self.mon_to_hr = dictionary[Constants.JSONStoreResponseKey.mon_to_hr] as? String
        self.mon_from_mins = dictionary[Constants.JSONStoreResponseKey.mon_from_mins] as? String
        self.mon_to_mins = dictionary[Constants.JSONStoreResponseKey.mon_to_mins] as? String
        self.tue_from_hr = dictionary[Constants.JSONStoreResponseKey.tue_from_hr] as? String
        self.tue_to_hr = dictionary[Constants.JSONStoreResponseKey.tue_to_hr] as? String
        self.tue_to_mins = dictionary[Constants.JSONStoreResponseKey.tue_from_mins] as? String
        self.tue_from_mins = dictionary[Constants.JSONStoreResponseKey.tue_to_mins] as? String
        self.wed_from_hr = dictionary[Constants.JSONStoreResponseKey.wed_from_hr] as? String
        self.wed_to_hr = dictionary[Constants.JSONStoreResponseKey.wed_to_hr] as? String
        self.wed_from_mins = dictionary[Constants.JSONStoreResponseKey.wed_from_mins] as? String
        self.wed_to_mins = dictionary[Constants.JSONStoreResponseKey.wed_to_mins] as? String
        self.thurs_from_hr = dictionary[Constants.JSONStoreResponseKey.thurs_from_hr] as? String
        self.thurs_to_hr = dictionary[Constants.JSONStoreResponseKey.thurs_to_hr] as? String
        self.thurs_from_mins = dictionary[Constants.JSONStoreResponseKey.thurs_from_mins] as? String
        self.thurs_to_mins = dictionary[Constants.JSONStoreResponseKey.thurs_to_mins] as? String
        self.fri_from_hr = dictionary[Constants.JSONStoreResponseKey.fri_from_hr] as? String
        self.fri_to_hr = dictionary[Constants.JSONStoreResponseKey.fri_to_hr] as? String
        self.fri_from_mins = dictionary[Constants.JSONStoreResponseKey.fri_from_mins] as? String
        self.fri_to_mins = dictionary[Constants.JSONStoreResponseKey.fri_to_mins] as? String
        self.sat_from_hr = dictionary[Constants.JSONStoreResponseKey.sat_from_hr] as? String
        self.sat_to_hr = dictionary[Constants.JSONStoreResponseKey.sat_to_hr] as? String
        self.sat_from_mins = dictionary[Constants.JSONStoreResponseKey.sat_from_mins] as? String
        self.sat_to_mins = dictionary[Constants.JSONStoreResponseKey.sat_to_mins] as? String
        self.sun_from_hr = dictionary[Constants.JSONStoreResponseKey.sun_from_hr] as? String
        self.sun_to_hr = dictionary[Constants.JSONStoreResponseKey.sun_to_hr] as? String
        self.sun_from_mins = dictionary[Constants.JSONStoreResponseKey.sun_from_mins] as? String
        self.sun_to_mins = dictionary[Constants.JSONStoreResponseKey.sun_to_mins] as? String
        self.by_appointment = dictionary[Constants.JSONStoreResponseKey.by_appointment] as? String
        self.mon_by_appointment = dictionary[Constants.JSONStoreResponseKey.mon_by_appointment] as? String
        self.tue_by_appointment = dictionary[Constants.JSONStoreResponseKey.tue_by_appointment] as? String
        self.wed_by_appointment = dictionary[Constants.JSONStoreResponseKey.wed_by_appointment] as? String
        self.thurs_by_appointment = dictionary[Constants.JSONStoreResponseKey.thurs_by_appointment] as? String
        self.fri_by_appointment = dictionary[Constants.JSONStoreResponseKey.fri_by_appointment] as? String
        self.sat_by_appointment = dictionary[Constants.JSONStoreResponseKey.sat_by_appointment] as? String
        self.sun_by_appointment = dictionary[Constants.JSONStoreResponseKey.sun_by_appointment] as? String
        self.on_holiday = dictionary[Constants.JSONStoreResponseKey.on_holiday] as? String
        self.holiday_from = dictionary[Constants.JSONStoreResponseKey.holiday_from] as? String
        self.holiday_to = dictionary[Constants.JSONStoreResponseKey.holiday_to] as? String
        self.holiday_message = dictionary[Constants.JSONStoreResponseKey.holiday_message] as? String
        self.mon_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.mon_lunch_from_hr] as? String
        self.mon_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.mon_lunch_from_mins] as? String
        self.mon_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.mon_lunch_to_hr] as? String
        self.mon_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.mon_lunch_to_mins] as? String
        self.tue_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.tue_lunch_from_hr] as? String
        self.tue_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.tue_lunch_from_mins] as? String
        self.tue_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.tue_lunch_to_hr] as? String
        self.tue_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.tue_lunch_to_mins] as? String
        self.wed_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.wed_lunch_from_hr] as? String
        self.wed_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.wed_lunch_from_mins] as? String
        self.wed_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.wed_lunch_to_hr] as? String
        self.wed_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.wed_lunch_to_mins] as? String
        self.thurs_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.thurs_lunch_from_hr] as? String
        self.thurs_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.thurs_lunch_from_mins] as? String
        self.thurs_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.thurs_lunch_to_hr] as? String
        self.thurs_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.thurs_lunch_to_mins] as? String
        self.sat_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.sat_lunch_from_hr] as? String
        self.sat_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.sat_lunch_from_mins] as? String
        self.sat_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.sat_lunch_to_hr] as? String
        self.sat_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.sat_lunch_to_mins] as? String
        self.fri_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.fri_lunch_from_hr] as? String
        self.fri_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.fri_lunch_from_mins] as? String
        self.fri_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.fri_lunch_to_hr] as? String
        self.fri_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.fri_lunch_to_mins] as? String
        self.sun_lunch_from_hr = dictionary[Constants.JSONStoreResponseKey.sun_lunch_from_hr] as? String
        self.sun_lunch_from_mins = dictionary[Constants.JSONStoreResponseKey.sun_lunch_from_mins] as? String
        self.sun_lunch_to_hr = dictionary[Constants.JSONStoreResponseKey.sun_lunch_to_hr] as? String
        self.sun_lunch_to_mins = dictionary[Constants.JSONStoreResponseKey.sun_lunch_to_mins] as? String
    }

    
    static func storeFromResults(_ results: [[String:AnyObject]],storeImageDir:String) -> [JSONStore] {
        var stores = [JSONStore]()
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            stores.append(JSONStore(dictionary: result, storeImageDir: storeImageDir))
        }
        return stores
    }

    static func storeFromCoreData(_ results: [Store]) -> [JSONStore] {
        
        var stores = [JSONStore]()
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            var dictionary = [String:AnyObject]()
            dictionary[Constants.JSONStoreResponseKey.Address] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Address) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.Id] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Id) as AnyObject?
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
            dictionary[Constants.JSONStoreResponseKey.Image1] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Image1)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.Image2] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Image2)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.Image3] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Image3)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.Image4] = result.value(forKeyPath: Constants.JSONStoreResponseKey.Image4)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.phone] = result.value(forKeyPath: Constants.JSONStoreResponseKey.phone)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.descriptions] = result.value(forKeyPath: Constants.JSONStoreResponseKey.descriptions)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.mon_from_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.mon_from_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.mon_from_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.mon_from_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.mon_to_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.mon_to_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.mon_to_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.mon_to_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.tue_from_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.tue_from_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.tue_from_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.tue_from_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.tue_to_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.tue_to_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.tue_to_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.tue_to_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.wed_from_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.wed_from_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.wed_from_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.wed_from_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.wed_to_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.wed_to_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.wed_to_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.wed_to_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.thurs_to_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.thurs_to_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.thurs_to_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.thurs_to_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.thurs_from_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.thurs_from_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.thurs_from_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.thurs_from_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.fri_to_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.fri_to_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.fri_to_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.fri_to_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.fri_from_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.fri_from_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.fri_from_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.fri_from_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sat_from_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.sat_from_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sat_from_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.sat_from_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sat_to_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.sat_to_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sat_to_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.sat_to_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sun_from_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.sun_from_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sun_from_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.sun_from_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sun_to_hr] = result.value(forKeyPath: Constants.JSONStoreResponseKey.sun_to_hr)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sun_to_mins] = result.value(forKeyPath: Constants.JSONStoreResponseKey.sun_to_mins)as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.IsFavorate] = result.value(forKeyPath: Constants.JSONStoreResponseKey.IsFavorate)as AnyObject?
            dictionary[Constants.CDStoreKey.CityName] = result.value(forKeyPath: Constants.CDStoreKey.CityName) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.by_appointment] = result.value(forKey: Constants.JSONStoreResponseKey.by_appointment) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.mon_by_appointment] = result.value(forKey: Constants.JSONStoreResponseKey.mon_by_appointment) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.tue_by_appointment] = result.value(forKey: Constants.JSONStoreResponseKey.tue_by_appointment) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.wed_by_appointment] = result.value(forKey: Constants.JSONStoreResponseKey.wed_by_appointment) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.thurs_by_appointment] = result.value(forKey: Constants.JSONStoreResponseKey.thurs_by_appointment) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.fri_by_appointment] = result.value(forKey: Constants.JSONStoreResponseKey.fri_by_appointment) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sat_by_appointment] = result.value(forKey: Constants.JSONStoreResponseKey.sat_by_appointment) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sun_by_appointment] = result.value(forKey: Constants.JSONStoreResponseKey.sun_by_appointment) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.on_holiday] = result.value(forKey: Constants.JSONStoreResponseKey.on_holiday) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.holiday_from] = result.value(forKey: Constants.JSONStoreResponseKey.holiday_from) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.holiday_to] = result.value(forKey: Constants.JSONStoreResponseKey.holiday_to) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.holiday_message] = result.value(forKey: Constants.JSONStoreResponseKey.holiday_message) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.mon_lunch_from_hr] = result.value(forKey: Constants.JSONStoreResponseKey.mon_lunch_from_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.mon_lunch_from_mins] = result.value(forKey: Constants.JSONStoreResponseKey.mon_lunch_from_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.mon_lunch_to_hr] = result.value(forKey: Constants.JSONStoreResponseKey.mon_lunch_to_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.mon_lunch_to_mins] = result.value(forKey: Constants.JSONStoreResponseKey.mon_lunch_to_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.tue_lunch_from_hr] = result.value(forKey: Constants.JSONStoreResponseKey.tue_lunch_from_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.tue_lunch_from_mins] = result.value(forKey: Constants.JSONStoreResponseKey.tue_lunch_from_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.tue_lunch_to_hr] = result.value(forKey: Constants.JSONStoreResponseKey.tue_lunch_to_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.tue_lunch_to_mins] = result.value(forKey: Constants.JSONStoreResponseKey.tue_lunch_to_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.wed_lunch_from_hr] = result.value(forKey: Constants.JSONStoreResponseKey.wed_lunch_from_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.wed_lunch_from_mins] = result.value(forKey: Constants.JSONStoreResponseKey.wed_lunch_from_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.wed_lunch_to_hr] = result.value(forKey: Constants.JSONStoreResponseKey.wed_lunch_to_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.wed_lunch_to_mins] = result.value(forKey: Constants.JSONStoreResponseKey.wed_lunch_to_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.thurs_lunch_from_hr] = result.value(forKey: Constants.JSONStoreResponseKey.thurs_lunch_from_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.thurs_lunch_from_mins] = result.value(forKey: Constants.JSONStoreResponseKey.thurs_lunch_from_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.thurs_lunch_to_hr] = result.value(forKey: Constants.JSONStoreResponseKey.thurs_lunch_to_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.thurs_lunch_to_mins] = result.value(forKey: Constants.JSONStoreResponseKey.thurs_lunch_to_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sat_lunch_from_hr] = result.value(forKey: Constants.JSONStoreResponseKey.sat_lunch_from_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sat_lunch_from_mins] = result.value(forKey: Constants.JSONStoreResponseKey.sat_lunch_from_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sat_lunch_to_hr] = result.value(forKey: Constants.JSONStoreResponseKey.sat_lunch_to_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sat_lunch_to_mins] = result.value(forKey: Constants.JSONStoreResponseKey.sat_lunch_to_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.fri_lunch_from_hr] = result.value(forKey: Constants.JSONStoreResponseKey.fri_lunch_from_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.fri_lunch_from_mins] = result.value(forKey: Constants.JSONStoreResponseKey.fri_lunch_from_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.fri_lunch_to_hr] = result.value(forKey: Constants.JSONStoreResponseKey.fri_lunch_to_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.fri_lunch_to_mins] = result.value(forKey: Constants.JSONStoreResponseKey.fri_lunch_to_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sun_lunch_from_hr] = result.value(forKey: Constants.JSONStoreResponseKey.sun_lunch_from_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sun_lunch_from_mins] = result.value(forKey: Constants.JSONStoreResponseKey.sun_lunch_from_mins) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sun_lunch_to_hr] = result.value(forKey: Constants.JSONStoreResponseKey.sun_lunch_to_hr) as AnyObject?
            dictionary[Constants.JSONStoreResponseKey.sun_lunch_to_mins] = result.value(forKey: Constants.JSONStoreResponseKey.sun_lunch_to_mins) as AnyObject?
            stores.append(JSONStore(dictionary: dictionary))
        }
        return stores
    }
    
    static func getStoreFromCDRecord(_ store:Store)->JSONStore{
        
        var dictionary = [String:AnyObject]()
        dictionary[Constants.JSONStoreResponseKey.Address] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Address) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.Id] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Id) as AnyObject?
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
        dictionary[Constants.JSONStoreResponseKey.Image1] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Image1)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.Image2] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Image2)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.Image3] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Image3)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.Image4] = store.value(forKeyPath: Constants.JSONStoreResponseKey.Image4)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.phone] = store.value(forKeyPath: Constants.JSONStoreResponseKey.phone)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.descriptions] = store.value(forKeyPath: Constants.JSONStoreResponseKey.descriptions)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.mon_from_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.mon_from_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.mon_from_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.mon_from_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.mon_to_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.mon_to_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.mon_to_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.mon_to_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.tue_from_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.tue_from_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.tue_from_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.tue_from_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.tue_to_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.tue_to_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.tue_to_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.tue_to_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.wed_from_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.wed_from_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.wed_from_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.wed_from_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.wed_to_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.wed_to_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.wed_to_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.wed_to_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.thurs_to_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.thurs_to_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.thurs_to_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.thurs_to_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.thurs_from_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.thurs_from_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.thurs_from_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.thurs_from_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.fri_to_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.fri_to_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.fri_to_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.fri_to_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.fri_from_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.fri_from_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.fri_from_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.fri_from_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sat_from_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.sat_from_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sat_from_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.sat_from_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sat_to_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.sat_to_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sat_to_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.sat_to_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sun_from_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.sun_from_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sun_from_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.sun_from_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sun_to_hr] = store.value(forKeyPath: Constants.JSONStoreResponseKey.sun_to_hr)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sun_to_mins] = store.value(forKeyPath: Constants.JSONStoreResponseKey.sun_to_mins)as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.IsFavorate] = store.value(forKeyPath: Constants.JSONStoreResponseKey.IsFavorate)as AnyObject?
        dictionary[Constants.CDStoreKey.CityName] = store.value(forKeyPath: Constants.CDStoreKey.CityName) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.by_appointment] = store.value(forKey: Constants.JSONStoreResponseKey.by_appointment) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.mon_by_appointment] = store.value(forKey: Constants.JSONStoreResponseKey.mon_by_appointment) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.tue_by_appointment] = store.value(forKey: Constants.JSONStoreResponseKey.tue_by_appointment) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.wed_by_appointment] = store.value(forKey: Constants.JSONStoreResponseKey.wed_by_appointment) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.thurs_by_appointment] = store.value(forKey: Constants.JSONStoreResponseKey.thurs_by_appointment) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.fri_by_appointment] = store.value(forKey: Constants.JSONStoreResponseKey.fri_by_appointment) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sat_by_appointment] = store.value(forKey: Constants.JSONStoreResponseKey.sat_by_appointment) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sun_by_appointment] = store.value(forKey: Constants.JSONStoreResponseKey.sun_by_appointment) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.on_holiday] = store.value(forKey: Constants.JSONStoreResponseKey.on_holiday) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.holiday_from] = store.value(forKey: Constants.JSONStoreResponseKey.holiday_from) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.holiday_to] = store.value(forKey: Constants.JSONStoreResponseKey.holiday_to) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.holiday_message] = store.value(forKey: Constants.JSONStoreResponseKey.holiday_message) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.mon_lunch_from_hr] = store.value(forKey: Constants.JSONStoreResponseKey.mon_lunch_from_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.mon_lunch_from_mins] = store.value(forKey: Constants.JSONStoreResponseKey.mon_lunch_from_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.mon_lunch_to_hr] = store.value(forKey: Constants.JSONStoreResponseKey.mon_lunch_to_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.mon_lunch_to_mins] = store.value(forKey: Constants.JSONStoreResponseKey.mon_lunch_to_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.tue_lunch_from_hr] = store.value(forKey: Constants.JSONStoreResponseKey.tue_lunch_from_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.tue_lunch_from_mins] = store.value(forKey: Constants.JSONStoreResponseKey.tue_lunch_from_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.tue_lunch_to_hr] = store.value(forKey: Constants.JSONStoreResponseKey.tue_lunch_to_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.tue_lunch_to_mins] = store.value(forKey: Constants.JSONStoreResponseKey.tue_lunch_to_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.wed_lunch_from_hr] = store.value(forKey: Constants.JSONStoreResponseKey.wed_lunch_from_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.wed_lunch_from_mins] = store.value(forKey: Constants.JSONStoreResponseKey.wed_lunch_from_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.wed_lunch_to_hr] = store.value(forKey: Constants.JSONStoreResponseKey.wed_lunch_to_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.wed_lunch_to_mins] = store.value(forKey: Constants.JSONStoreResponseKey.wed_lunch_to_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.thurs_lunch_from_hr] = store.value(forKey: Constants.JSONStoreResponseKey.thurs_lunch_from_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.thurs_lunch_from_mins] = store.value(forKey: Constants.JSONStoreResponseKey.thurs_lunch_from_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.thurs_lunch_to_hr] = store.value(forKey: Constants.JSONStoreResponseKey.thurs_lunch_to_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.thurs_lunch_to_mins] = store.value(forKey: Constants.JSONStoreResponseKey.thurs_lunch_to_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sat_lunch_from_hr] = store.value(forKey: Constants.JSONStoreResponseKey.sat_lunch_from_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sat_lunch_from_mins] = store.value(forKey: Constants.JSONStoreResponseKey.sat_lunch_from_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sat_lunch_to_hr] = store.value(forKey: Constants.JSONStoreResponseKey.sat_lunch_to_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sat_lunch_to_mins] = store.value(forKey: Constants.JSONStoreResponseKey.sat_lunch_to_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.fri_lunch_from_hr] = store.value(forKey: Constants.JSONStoreResponseKey.fri_lunch_from_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.fri_lunch_from_mins] = store.value(forKey: Constants.JSONStoreResponseKey.fri_lunch_from_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.fri_lunch_to_hr] = store.value(forKey: Constants.JSONStoreResponseKey.fri_lunch_to_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.fri_lunch_to_mins] = store.value(forKey: Constants.JSONStoreResponseKey.fri_lunch_to_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sun_lunch_from_hr] = store.value(forKey: Constants.JSONStoreResponseKey.sun_lunch_from_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sun_lunch_from_mins] = store.value(forKey: Constants.JSONStoreResponseKey.sun_lunch_from_mins) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sun_lunch_to_hr] = store.value(forKey: Constants.JSONStoreResponseKey.sun_lunch_to_hr) as AnyObject?
        dictionary[Constants.JSONStoreResponseKey.sun_lunch_to_mins] = store.value(forKey: Constants.JSONStoreResponseKey.sun_lunch_to_mins) as AnyObject?
        return JSONStore(dictionary:dictionary)

    }

}
