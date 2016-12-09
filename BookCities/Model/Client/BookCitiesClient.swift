//
//  BookCitiesClient.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/23/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit
import Alamofire
// MARK: - BookCitiesClient NSObject
class BookCitiesClient: NSObject {

    // MARK: Properties
    
    // shared session
    var session = URLSession.shared
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: GET
    func getMethod(_ method:String,parameters:[String:AnyObject], completionHandlerForGET: @escaping (_ response : Any?, _ error :Error?) -> Void)
    {
        let url = BookCitiesURLFromParameters(parameters as [String : AnyObject], withPathExtension: method)
        Alamofire.request(String(describing: url)).responseJSON { response in switch response.result {
        case .success(let JSON):
            let response = JSON as! NSDictionary
            let array = response.object(forKey: method.substring(from: method.index(after: method.startIndex)))! as! NSArray
            completionHandlerForGET(array,nil)
        case .failure(let error):
            print("Request failed with error: \(error)")
            }
        }
 
    }
    // MARK: Helpers
    

    // given raw JSON, return a usable Foundation object
    fileprivate func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: Any!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult as AnyObject?, nil)
    }
    
    // create a URL from parameters
    fileprivate func BookCitiesURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.BookCity.ApiScheme
        components.host = Constants.BookCity.ApiHost
        components.path = Constants.BookCity.ApiPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url! as URL
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> BookCitiesClient {
        struct Singleton {
            static var sharedInstance = BookCitiesClient()
        }
        return Singleton.sharedInstance
    }
    
   
}
