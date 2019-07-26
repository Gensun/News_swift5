//
//  MyTabBar.swift
//  HeadNews
//
//  Created by Cheng Sun on 3/29/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(centerBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // lazy load
   private lazy var centerBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
        btn.sizeToFit()
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = frame.width
        let height = frame.height
        
        // center btn set center tabBar
        centerBtn.center = CGPoint(x: width / 2, y: height / 2 - (UIDevice.current.isIphoneXorGreater ? 30 : 10))
        //other btn frame
        let buttonW: CGFloat = width * 0.2
        let buttonH: CGFloat = 44
        let buttonY: CGFloat = 0
        
        var index = 0
        
        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!) { continue }
            let buttonX = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            index += 1
        }
    }
}
