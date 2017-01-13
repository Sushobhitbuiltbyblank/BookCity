//
//  headerViewCell.swift
//  BookCities
//
//  Created by Sushobhit_BuiltByBlank on 12/20/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class headerViewCell: UITableViewCell {

    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var mainLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func addBorder()
    {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        
    }
    
    func addUpperBorder()
    {
        let upperBoarder = CALayer()
        upperBoarder.backgroundColor = UIColor.black.cgColor
        upperBoarder.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1.0)
        self.layer.addSublayer(upperBoarder)
    }
    
    func addLowerBorder()
    {
        let upperBoarder = CALayer()
        upperBoarder.backgroundColor = UIColor.black.cgColor
        upperBoarder.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 1.0)
        self.layer.addSublayer(upperBoarder)
    }
    
    func addLeftBorder()
    {
        let upperBoarder = CALayer()
        upperBoarder.backgroundColor = UIColor.black.cgColor
        upperBoarder.frame = CGRect(x: 0, y: 0, width: 1.0, height: self.frame.height)
        self.layer.addSublayer(upperBoarder)
    }
    
    func addRightBorder()
    {
        let upperBoarder = CALayer()
        upperBoarder.backgroundColor = UIColor.black.cgColor
        upperBoarder.frame = CGRect(x: self.frame.width-1, y: 0, width: 1.0, height: self.frame.height)
        self.layer.addSublayer(upperBoarder)
    }

    
}
