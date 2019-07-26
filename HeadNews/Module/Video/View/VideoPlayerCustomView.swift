//
//  VideoPlayerCustomView.swift
//  HeadNews
//
//  Created by Cheng Sun on 7/25/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit
import BMPlayer

class VideoPlayerCustomView: BMPlayerControlView {
    override func customizeUIComponents() {
        BMPlayerConf.topBarShowInCase = .none
    }
}
