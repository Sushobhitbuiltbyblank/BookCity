//
//  CustomeNavBar.swift
//  BookCities
//
//  Created by Sushobhit_BuiltByBlank on 1/11/17.
//  Copyright © 2017 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class CustomeNavBar: UINavigationBar {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 80)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
