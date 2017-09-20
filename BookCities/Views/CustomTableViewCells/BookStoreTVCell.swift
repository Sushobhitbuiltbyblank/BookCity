//
//  BookStoreTVCell.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/9/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class BookStoreTVCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var favBookStoreImageV: UIImageView!
    @IBOutlet weak var bookstoreTypeImageV: UIImageView!
    @IBOutlet weak var marginC: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        }
        else{
            self.backgroundColor = UIColor.white
        }
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
        upperBoarder.frame = CGRect(x: 0, y: self.frame.height-1, width: self.frame.width, height: 1.0)
        self.layer.addSublayer(upperBoarder)
    }
    
    func addLowerBorder(width:CGFloat)
    {
        let upperBoarder = CALayer()
        upperBoarder.backgroundColor = UIColor.black.cgColor
        upperBoarder.frame = CGRect(x: 0, y: self.frame.height-1, width: self.frame.width, height: width)
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
