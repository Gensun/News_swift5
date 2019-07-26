//
//  SmallVideoPlayerCustomView.swift
//  HeadNews
//
//  Created by Cheng Sun on 7/24/19.
//  Copyright © 2019 EF. All rights reserved.
//

import BMPlayer

class SmallVideoPlayerCustomView: BMPlayerControlView {
    override func customizeUIComponents() {
        BMPlayerConf.topBarShowInCase = .none
        playButton.removeFromSuperview()
        currentTimeLabel.removeFromSuperview()
        totalTimeLabel.removeFromSuperview()
        timeSlider.removeFromSuperview()
        fullscreenButton.removeFromSuperview()
        progressView.removeFromSuperview()
    }
}
