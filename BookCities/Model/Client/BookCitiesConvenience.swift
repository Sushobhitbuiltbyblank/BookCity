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
        getMethodCall(mutableMethod, parameters: [String:AnyObject](), completionHandlerForGET: {
        (response,error) in
            let res = response as! NSDictionary
            let array = res.object(forKey:"stores")! as! NSArray
            let response = JSONStore.storeFromResults(array as! [[String : AnyObject]],storeImageDir:res.object(forKey:"store_image_dir")! as! String)
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
    
    func getCountries(_ parameters:[String:AnyObject], _ completionHandlerForCounties: @escaping (_ response : Array<JSONCountry>? ,_ error : Error?) -> Void) -> Void {
        let mutableMethod: String = Constants.Methods.Countries
        getMethod(mutableMethod, parameters: parameters, completionHandlerForGET: {
            (response,error) in
            let response = JSONCountry.countryFromResults(response as! [[String : AnyObject]])
            completionHandlerForCounties(response as Array<JSONCountry>?,error)
        })
    }
    
    func getCountry(_ countryId:String,_ completionHandlerForCountry: @escaping (_ response : Array<JSONCountry>? ,_ error : Error?) -> Void) -> Void {
        let mutableMethod: String = Constants.Methods.Countries+countryId
        getMethodCall(mutableMethod, parameters: [String:AnyObject](), completionHandlerForGET: {
            (response,error) in
            let res = response as! NSDictionary
            let array = res.object(forKey:"countries")! as! NSArray
            let response = JSONCountry.countryFromResults(array as! [[String : AnyObject]])
            completionHandlerForCountry(response as Array<JSONCountry>?,error)
        })
    }
    
    func getState(_ completionHandlerForState: @escaping (_ response : Array<JSONState>? ,_ error : Error?) -> Void) -> Void {
        let mutableMethod: String = Constants.Methods.States
        getMethod(mutableMethod, parameters: [String:AnyObject](), completionHandlerForGET: {
            (response,error) in
            let response = JSONState.stateFromResults(response as! [[String : AnyObject]])
            completionHandlerForState(response as Array<JSONState>?,error)
        })
    }
    
//    func getState(id:String ,_ completionHandlerForState: @escaping (_ response : Array<JSONState>? ,_ error : Error?) -> Void) -> Void {
//        let mutableMethod: String = Constants.Methods.States
//        getMethod(mutableMethod, parameters: [String:AnyObject](), completionHandlerForGET: {
//            (response,error) in
//            let response = JSONState.stateFromResults(response as! [[String : AnyObject]])
//            completionHandlerForState(response as Array<JSONState>?,error)
//        })
//    }
    
    func getCityOrigin(_ parameters:[String:AnyObject],id:String, completionHandlerForCityOrigin: @escaping (_ response:Dictionary<String, Any>?,_ error:Error?)->Void) -> Void {
        let mutableMethod: String = Constants.Methods.Cities+"/"+id
        getMethodCall(mutableMethod, parameters: parameters as [String : AnyObject], completionHandlerForGET:
            {
                (response,error) in
                completionHandlerForCityOrigin(response as! Dictionary<String, Any>?,error)
        })

    }
    
    func getStores(_ parameteres:[String:AnyObject], _ completionHandlerForStores: @escaping (_ response : Array<JSONStore>? ,_ error : Error?) -> Void) -> Void {
        let mutableMethod: String = Constants.Methods.Stores
        getMethodCall(mutableMethod, parameters: parameteres, completionHandlerForGET: {
            (response,error) in
            let res = response as! NSDictionary
            let array = res.object(forKey:"stores")! as! NSArray
            let response = JSONStore.storeFromResults(array as! [[String : AnyObject]],storeImageDir:res.object(forKey:"store_image_dir")! as! String)
            completionHandlerForStores(response as Array<JSONStore>?,error)
        })
    }
    
    func getStore(_ id:String, _ completionHandlerForStore: @escaping (_ response:Array<JSONStore>?, _ error:Error?)->Void)->Void {
        let mutableMethod: String = Constants.Methods.Stores+"/\(id)"
        getMethodCall(mutableMethod, parameters: [String:AnyObject](), completionHandlerForGET: {
            (response,error) in
            let res = response as! NSDictionary
            let array = res.object(forKey:"stores")! as! NSArray
            let response = JSONStore.storeFromResults(array as! [[String : AnyObject]],storeImageDir:res.object(forKey:"store_image_dir")! as! String)
            completionHandlerForStore(response as Array<JSONStore>?,error)
        })
    }
    
    func getInfoData(_ parameters:[String:AnyObject], _ completionHandlerForInfo: @escaping (_ response:String? ,_ error:Error?) -> Void) -> Void {
        let mutableMethod = Constants.Methods.Appsettings
        getMethodCall(mutableMethod, parameters: parameters, completionHandlerForGET: { (response,error) in
            let res = response as! NSDictionary
            let data = res.value(forKey: "appsettings")
            let response = (data as AnyObject).value(forKey:"info_text") as! String
            completionHandlerForInfo(response,error)
        })
    }
    
    func sendToken(_ parameter:[String:AnyObject], completionHandlerForLogin: @escaping (_ response:NSDictionary?,_ error:Error?) -> Void)
    {
        let mutableMethod:String = Constants.Methods.RegToken
        postMethod(mutableMethod,parameters: parameter) {
            (response, error) in
            print(response ?? "no response")
            if error == nil {
                completionHandlerForLogin(response as NSDictionary?,error)
            }
            else{
                completionHandlerForLogin(nil,error)
            }
        }
    }

}
