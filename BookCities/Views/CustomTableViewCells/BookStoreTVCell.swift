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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.black.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
