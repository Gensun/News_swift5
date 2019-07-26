//
//  SmallVideoLayout.swift
//  HeadNews
//
//  Created by Cheng Sun on 7/24/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

class SmallVideoLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: collectionView?.width ?? 0.0, height: collectionView?.height ?? 0.0)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
    }
}
