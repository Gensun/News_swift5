//
//  VolcanoTableViewCell.swift
//  HeadNews
//
//  Created by Cheng Sun on 7/22/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

public let notAnimateTag = 666

class VolcanoTableViewCell: UICollectionViewCell, RegisterCellFromNib {
    var smallVideo = NewsModel() {
        didSet {
            stopLoading()
            closeButton.isHidden = false
            titleLabel.attributedText = smallVideo.raw_data.attrbutedText
            if let largeImage = smallVideo.raw_data.large_image_list.first {
                if let url = URL(string: largeImage.urlString) {
                    imageView.kf.setImage(with: url)
                }
            } else if let firstImage = smallVideo.raw_data.first_frame_image_list.first {
                if let url = URL(string: firstImage.urlString) {
                   imageView.kf.setImage(with: url)
                }
            }
            diggCountLabel.text = smallVideo.raw_data.action.diggCount + "赞"
            playCountButton.setTitle(smallVideo.raw_data.action.playCount + "次播放", for: .normal)
        }
    }

    lazy var overlayLayer : CALayer = {
        var layer = CALayer()
        var imageFrame = self.imageView.bounds
        imageFrame.size.width = UIApplication.shared.keyWindow?.bounds.width ?? self.imageView.bounds.width
        layer.frame = imageFrame
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        return layer
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        // Theme
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleLabel.theme_textColor = "colors.moreLoginTextColor"
        playCountButton.theme_setTitleColor("colors.moreLoginTextColor", forState: .normal)
        diggCountLabel.theme_textColor = "colors.moreLoginTextColor"
        playCountButton.theme_setImage("images.ugc_video_list_play_32x32_", forState: .normal)
        closeButton.theme_setImage("images.ImgPic_close_24x24_", forState: .normal)
        
        //Add color layer
//        imageView.layer.sublayers = nil
//        imageView.layer.addSublayer(overlayLayer)
//        overlayLayer.backgroundColor = UIColor.blue.cgColor
    }

    /// 预览图
    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.tag = notAnimateTag
//            imageView.layer.cornerRadius = 6
//            imageView.clipsToBounds = true

        }
    }
    /// 标题
    @IBOutlet var titleLabel: UILabel!
    /// 赞
    @IBOutlet var diggCountLabel: UILabel!
    /// 播放次数
    @IBOutlet var playCountButton: UIButton!
    /// 关闭按钮
    @IBOutlet var closeButton: UIButton!{
        didSet {
            closeButton.tag = notAnimateTag
        }
    }

    @IBAction func closeButton(_ sender: UIButton) {
    }

    private var isLoading = false
  
    override func prepareForReuse() {
        super.prepareForReuse()
        defaultState()
    }

    private func defaultState() {
        titleLabel.text = ""
        diggCountLabel.text = ""
        playCountButton.setTitle("", for: .normal)
        imageView.image = nil
        
        if closeButton != nil {
            closeButton.isHidden = true
        }
    }

    func startLoading() {
        guard !isLoading else {
            return
        }

        isLoading = true
        defaultState()
        showSkeleton(view: contentView, animated: true, withLighColors: false)
    }

    func stopLoading() {
        guard isLoading else {
            return
        }

        isLoading = false
        self.removeSkeleton(view: self.contentView)
    }
}
