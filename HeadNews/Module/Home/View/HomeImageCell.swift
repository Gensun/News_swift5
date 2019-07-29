//
//  HomeImageCell.swift
//  HeadNews
//
//  Created by Cheng Sun on 7/29/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

class HomeImageCell: UICollectionViewCell, RegisterCellFromNib {
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
    }
    
    var image = ImageList() {
        didSet {
            imageView.kf.setImage(with: URL(string: image.urlString)!)
        }
    }
}
