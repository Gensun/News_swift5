//
//  TheyAlsoUseCell.swift
//  HeadNews
//
//  Created by Cheng Sun on 7/29/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

class TheyAlsoUseCell: UITableViewCell, RegisterCellFromNib {
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!

    var theyUse = SmallVideo() {
        didSet {
            leftLabel.text = theyUse.title
            rightButton.setTitle(theyUse.show_more, for: .normal)
            userCards = theyUse.user_cards
            collectionView.reloadData()
        }
    }
    
    var userCards = [UserCard]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        bottomView.theme_backgroundColor = "colors.separatorViewColor"
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 170, height: 215)
        collectionView.collectionViewLayout = layout
        collectionView.EF_registerCell(cell: TheyUseCollectionCell.self)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TheyAlsoUseCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.EF_dequeueReusableCell(indexPath: indexPath) as TheyUseCollectionCell
        cell.userCard = userCards[indexPath.item]
        return cell
    }
}