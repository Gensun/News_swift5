//
//  UserDetailCell.swift
//  HeadNews
//
//  Created by Cheng Sun on 4/13/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

class UserDetailCell: UITableViewCell, RegisterCellFromNib {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
