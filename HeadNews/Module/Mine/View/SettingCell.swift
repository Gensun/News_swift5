
//
//  SettingCell.swift
//  HeadNews
//
//  Created by Cheng Sun on 4/9/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit
import Kingfisher

//------------------
struct AlertInfo: Equatable{
    let titleInfo: String
    let defaultInfo: [String]
}

let cache = AlertInfo(titleInfo: "非 WiFi 网络播放提醒", defaultInfo: ["取消","每次提醒","提醒一次"])
let wifi = AlertInfo(titleInfo: "非 WiFi 网络流量", defaultInfo: ["取消","最小效果(下载大图)","较省流量(智能下图)","极省流量(智能下图)"])
let fontSize = AlertInfo(titleInfo: "设置字体大小", defaultInfo: ["取消","小","中","大","特大"])
let clear = AlertInfo(titleInfo: "确定清除所有缓存？问答草稿、离线下载及图片均会被清除", defaultInfo: ["取消","确定"])

func ==(lhs: AlertInfo, rhs: AlertInfo) -> Bool {
    return lhs.titleInfo == rhs.titleInfo && lhs.defaultInfo == rhs.defaultInfo
}
//------------------

class SettingCell: UITableViewCell, RegisterCellFromNib {

    @IBOutlet weak var subtitleLabelHeight: NSLayoutConstraint!
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 副标题
    @IBOutlet weak var subtitleLabel: UILabel!
    /// 右边标题
    @IBOutlet weak var rightTitleLabel: UILabel!
    
    @IBOutlet weak var arrowImageView: UIImageView!
    
    @IBOutlet weak var switchView: UISwitch!
    
    @IBOutlet weak var bottomLine: UIView!

    
    let alertTitles: [AlertInfo] = [
        clear,
        fontSize,
        wifi,
        cache
    ]
    
    var settingDto = SettingModel() {
        didSet {
            titleLabel.text = settingDto.title
            subtitleLabel.text = settingDto.subtitle
            rightTitleLabel.text = settingDto.rightTitle
            arrowImageView.isHidden = settingDto.isHiddenRightArraw
            switchView.isHidden = settingDto.isHiddenSwitch
            if !settingDto.isHiddenSubtitle {
                subtitleLabelHeight.constant = 20
                layoutIfNeeded()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        bottomLine.theme_backgroundColor = "colors.separatorViewColor"
        titleLabel.theme_textColor = "colors.black"
        rightTitleLabel.theme_textColor = "colors.cellRightTextColor"
        arrowImageView.theme_image = "images.cellRightArrow"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension SettingCell {
    
    // 获取缓存大小数据
    func calculateDiskCashSize() {
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (item) in
            // btye to mb
            let sizeM = Double(item) / 1024.0 / 1024.0
            self.rightTitleLabel.text = String(format: "%.2fM", sizeM)
        }
    }
    
    func setupAlertController(_ info: AlertInfo) {
        
        let alertViewController = UIAlertController(title: info.titleInfo, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: info.defaultInfo.first, style: .default, handler: nil)
        alertViewController.addAction(cancelAction)
        
         for i in 1..<info.defaultInfo.count {
            let everyAction = UIAlertAction(title: info.defaultInfo[i], style: .default) { (_) in
                if info == clear {
                    let cache = KingfisherManager.shared.cache
                    cache.clearDiskCache()
                    cache.clearMemoryCache()
                    cache.cleanExpiredDiskCache()
                    self.rightTitleLabel.text = "0.00M"
                }else{
                    self.rightTitleLabel.text = info.defaultInfo[i]
                }
            }
            alertViewController.addAction(everyAction)
         }
        UIApplication.shared.keyWindow?.rootViewController?.present(alertViewController, animated: true, completion: nil)
    }
}
