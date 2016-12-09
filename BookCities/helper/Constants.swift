//
//  Constants.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/22/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    // MARK: BookCity
    struct BookCity {
        static let ApiScheme = "http"
        static let ApiHost = "54.191.201.248"
        static let ApiPath = "/bookmap/app/api"
    }

    // MARK: Methods
    struct Methods {
        static let Countries = "/countries"
        static let States = "/states"
        static let Cities = "/cities"
        static let Stores = "/stores"
        static let Bookscategories = "/bookscategories"
    }
    
    struct JSONCityResponseKey {
        static let Country_id = "country_id"
        static let Id = "id"
        static let Name = "name"
        static let State_id = "state_id"
    }
    
    struct JSONStoreResponseKey {
        static let Address = "address"
        static let BookCategoryIds = "books_category_ids"
        static let Id = "id"
        static let IsMuseumshops = "is_museumshops"
        static let IsNewBooks = "is_new_books"
        static let IsUsedBooks = "is_used_books"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let Name = "name"
        static let Website = "website"
        static let Address_2 = "address_2"
        static let Country = "country"
        static let State = "state"
        static let City = "city"
        static let Zipcode = "zipcode"
        static let WorkingHours = "working_hours"
        static let IsFavorate = "isFavorate"
    }
    
    struct Alert {
        static let Title = "No internet connection"
        static let Message = "Please check your internet connectivity. "
    }
    
    struct Entity {
        static let City = "City"
        static let Store = "Store"
        static let Category = "Categories"
    }
    struct Font {
        static let Size = 18
        static let TypeHelvetica = "Helvetica"
    }
    struct image {
        static let Back = "back"
        static let BackBtnBlue = "backBtnBlue"
        static let BackBtnGreen = "backBtnGreen"
        static let BackBtnRed = "backBtnRed"
        static let BlueCircle = "blueCircle"
        static let BluePin = "bluePin"
        static let BlueRedCircle = "blueRedCircle"
        static let BlueRedPin = "blueRedPin"
        static let Cross = "cross"
        static let GreenBlueCircle = "greenBlueCircle"
        static let GreenBluePin = "greenBluePin"
        static let GreenCircle = "greenCircle"
        static let GreenPin = "greenPin"
        static let Info = "info"
        static let Logo = "logo"
        static let RedCircle = "redCircle"
        static let RedGreenCircle = "redGreenCircle"
        static let RedGreenPin = "redGreenPin"
        static let RedPin = "redPin"
        static let SelectedTriagle = "selectedTriagle"
        static let Share = "share"
        static let Triangle = "triangle"
    }
}
