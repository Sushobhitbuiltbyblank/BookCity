//
//  StorePushModel.swift
//  BookCities
//
//  Created by Sushobhit_BuiltByBlank on 6/21/17.
//  Copyright © 2017 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class StorePushModel: NSObject {

    var storeId:String?
    var storeName:String?
    
    init(_ id:String,_ name:String) {
        self.storeId = id
        self.storeName = name
    }
}
