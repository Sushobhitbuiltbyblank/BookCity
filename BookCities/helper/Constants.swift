//
//  Constants" "swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/22/16" "
//  Copyright © 2016 Built by Blank India Pvt" " Ltd" " All rights reserved" "
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
        static let Appsettings = "/appsettings"
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
        static let StoreImageDir = "store_image_dir"
        static let Image1 = "image1"
        static let Image2 = "image2"
        static let Image3 = "image3"
        static let Image4 = "image4"
        static let phone = "phone"
        
        static let mon_from_hr = "mon_from_hr"
        static let tue_from_hr = "tue_from_hr"
        static let wed_from_hr = "wed_from_hr"
        static let thurs_from_hr = "thurs_from_hr"
        static let fri_from_hr = "fri_from_hr"
        static let sat_from_hr = "sat_from_hr"
        static let sun_from_hr = "sun_from_hr"

        static let mon_from_mins = "mon_from_mins"
        static let tue_from_mins = "tue_from_mins"
        static let wed_from_mins = "wed_from_mins"
        static let thurs_from_mins = "thurs_from_mins"
        static let fri_from_mins = "fri_from_mins"
        static let sat_from_mins = "sat_from_mins"
        static let sun_from_mins = "sun_from_mins"
        
        static let mon_to_hr = "mon_to_hr"
        static let tue_to_hr = "tue_to_hr"
        static let wed_to_hr = "wed_to_hr"
        static let thurs_to_hr = "thurs_to_hr"
        static let fri_to_hr = "fri_to_hr"
        static let sat_to_hr = "sat_to_hr"
        static let sun_to_hr = "sun_to_hr"
        
        static let mon_to_mins = "mon_to_mins"
        static let tue_to_mins = "tue_to_mins"
        static let wed_to_mins = "wed_to_mins"
        static let thurs_to_mins = "thurs_to_mins"
        static let fri_to_mins = "fri_to_mins"
        static let sat_to_mins = "sat_to_mins"
        static let sun_to_mins = "sun_to_mins"
        static let descriptions = "descriptions"
    }
    
    struct JSONCountryResponseKey {
        static let Id = "id"
        static let Name = "name"
        static let SortName = "sortname"
        static let Country_code = "country_code"
    }
    
    struct JSONStateResponseKey {
        static let Id = "id"
        static let Name = "name"
        static let Country_id = "country_id"
    }
    struct Alert {
        static let Title = "No internet connection"
        static let TitleNofavStore = "No favourite Stores yet"
        static let Message = "Please check your internet connectivity. "
        static let MessageNoFavStore = "Please first set favourite store."
    }
    
    struct Entity {
        static let City = "City"
        static let Store = "Store"
        static let Category = "Categories"
        static let Country = "Country"
        static let State = "State"
    }
    struct Font {
        static let Size = 22
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
        static let ImagePath = "http://54.191.201.248/bookmap/uploads/store_images/"
    }
    struct CDStoreKey {
        static let CityName = "cityName"
    }
    struct BlackLines {
        static let height = 1.0
        static let width = 1.0
    }
}
