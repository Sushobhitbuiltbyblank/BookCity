//
//  BookCitiesConvenience.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/23/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import Foundation

extension BookCitiesClient
{
    // MARK: GET Convenience Methods
    func getCities(_ parameters:[String:AnyObject],completionHandlerForCities:@escaping (_ response : [JSONCity]?, _ error :Error?) -> Void) {
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let mutableMethod: String = Constants.Methods.Cities
        getMethod(mutableMethod, parameters: parameters, completionHandlerForGET:
            { 
                (response,error) in
                let response = JSONCity.cityFromResults(response as! [[String : AnyObject]])
                completionHandlerForCities(response,error)
        })
    }
    
    func getStores(_ completionHandlerForStores: @escaping (_ response : Array<JSONStore>? ,_ error : Error?) -> Void) -> Void {
        let mutableMethod: String = Constants.Methods.Stores
        getMethod(mutableMethod, parameters: [String:AnyObject](), completionHandlerForGET: {
        (response,error) in
            let response = JSONStore.storeFromResults(response as! [[String : AnyObject]])
            completionHandlerForStores(response as Array<JSONStore>?,error)
        })
    }
    
    func getCategories(_ completionHandlerForCategories: @escaping (_ response : Array<JSONCategory>? ,_ error : Error?) -> Void) -> Void {
        let mutableMethod: String = Constants.Methods.Bookscategories
        getMethod(mutableMethod, parameters: [String : AnyObject](), completionHandlerForGET:{
            (response, error) in
            let response = JSONCategory.categoryFromResults(response as! [[String : AnyObject]])
            completionHandlerForCategories(response as Array<JSONCategory>?,error)
        })
    }
}
