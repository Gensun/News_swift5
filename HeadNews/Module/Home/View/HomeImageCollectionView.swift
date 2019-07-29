//
//  HomeImageCollectionView.swift
//  HeadNews
//
//  Created by Cheng Sun on 7/29/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

class HomeImageCollectionView: UICollectionView , NibLoadable {

    var images = [ImageList]() {
        didSet {
            reloadData()
        }
    }
    
    var didSelect:((_ selectedIndex: Int) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewLayout = HomeImageCollectionViewFlowLayout()
        EF_registerCell(cell: HomeImageCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.EF_dequeueReusableCell(indexPath: indexPath) as HomeImageCell
        cell.image = images[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: image3Width, height: image3Width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?(indexPath.item)
    }

}

class HomeImageCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
    }
}
