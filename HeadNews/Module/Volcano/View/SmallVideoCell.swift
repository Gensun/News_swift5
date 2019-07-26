//
//  SmallVideoCell.swift
//  HeadNews
//
//  Created by Cheng Sun on 7/24/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit
import IBAnimatable

class SmallVideoCell: UICollectionViewCell , RegisterCellFromNib {
    var didSelectAvatarOrNameButton: (() -> ())?
    /// 头像按钮
    @IBOutlet weak var avatarButton: AnimatableButton!
    @IBOutlet weak var vImageView: UIImageView!
    /// 用户名按钮
    @IBOutlet weak var nameButton: AnimatableButton!
    /// 关注按钮
    @IBOutlet weak var concernButton: AnimatableButton!
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var scrollLabel: UILabel!
    
    @IBOutlet weak var bgImageView: UIImageView!

    var smallVideo = NewsModel() {
        didSet {
            bgImageView.image = nil
            nameButton.setTitle(smallVideo.raw_data.user.info.name, for: .normal)
            avatarButton.kf.setImage(with: URL(string: smallVideo.raw_data.user.info.avatar_url), for: .normal)
            vImageView.isHidden = !smallVideo.raw_data.user.info.user_verified
            concernButton.isSelected = smallVideo.raw_data.user.relation.is_following
            titleLabel.attributedText = smallVideo.raw_data.attrbutedText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /// 头像按钮或用户名按钮点击
    @IBAction func avatarButtonClicked(_ sender: AnimatableButton) {
        didSelectAvatarOrNameButton?()
    }

    /// 关注按钮点击
    @IBAction func concernButtonClicked(_ sender: UIButton) {
        if sender.isSelected { // 已经关注，点击则取消关注
            // 已关注用户，取消关注
            NetworkTool.loadRelationUnfollow(userId: smallVideo.raw_data.user.info.user_id, completionHandler: { (_) in
                sender.isSelected = !sender.isSelected
                sender.theme_backgroundColor = "colors.globalRedColor"
            })
        } else { // 未关注，点击则关注这个用户
            // 点击关注按钮，关注用户
            NetworkTool.loadRelationFollow(userId: smallVideo.raw_data.user.info.user_id, completionHandler: { (_) in
                sender.isSelected = !sender.isSelected
                sender.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
            })
        }
    }

}
