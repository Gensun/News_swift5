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
    }

    /// 预览图
    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.tag = notAnimateTag
        }
    }

    /// 标题
    @IBOutlet var titleLabel: UILabel!
    /// 赞
    @IBOutlet var diggCountLabel: UILabel!
    /// 播放次数
    @IBOutlet var playCountButton: UIButton! {
        didSet {
            playCountButton.tag = notAnimateTag
        }
    }

    /// 关闭按钮
    @IBOutlet var closeButton: UIButton! {
        didSet {
            closeButton.tag = notAnimateTag
        }
    }

    @IBAction func closeButton(_ sender: UIButton) {
    }

    private var isLoading = false

    override func prepareForReuse() {
        defaultState()
        super.prepareForReuse()
    }

    private func defaultState() {
        titleLabel.text = ""
        diggCountLabel.text = ""
        playCountButton.setTitle("", for: .normal)
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
        removeSkeleton(view: contentView)
    }
}
