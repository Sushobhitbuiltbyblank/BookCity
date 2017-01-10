//
//  BorderButton.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/8/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class BorderButton: UIButton {
    
    // MARK: Initialization
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func addBorder(width:CGFloat)
    {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = width
        
    }
    
    func addUpperBorder(width:CGFloat)
    {
        let upperBoarder = CALayer()
        upperBoarder.backgroundColor = UIColor.black.cgColor
        upperBoarder.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
        self.layer.addSublayer(upperBoarder)
    }
    
    func addLowerBorder(width:CGFloat)
    {
        let upperBoarder = CALayer()
        upperBoarder.backgroundColor = UIColor.black.cgColor
        upperBoarder.frame = CGRect(x: 0, y: self.frame.height-1, width: self.frame.width, height: width)
        self.layer.addSublayer(upperBoarder)
    }
    
    func addLeftBorder(width:CGFloat)
    {
        let upperBoarder = CALayer()
        upperBoarder.backgroundColor = UIColor.black.cgColor
        upperBoarder.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
        self.layer.addSublayer(upperBoarder)
    }
    
    func addRightBorder(width:CGFloat)
    {
        let upperBoarder = CALayer()
        upperBoarder.backgroundColor = UIColor.black.cgColor
        upperBoarder.frame = CGRect(x: self.frame.width-1, y: 0, width: width, height: self.frame.height)
        self.layer.addSublayer(upperBoarder)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
