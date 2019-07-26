//
//  UIDeviceExtensions.swift
//  HeadNews
//
//  Created by Cheng Sun on 3/29/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

extension UIDevice {
    var isIphoneXorGreater: Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        
        return UIDevice.current.userInterfaceIdiom != .pad && (UIApplication .shared.keyWindow?.safeAreaInsets.top ?? 0 > CGFloat(20))
    }
    
    
    var isIphone5: Bool {
        return UIScreen.main.bounds.size.height == CGFloat(568)
    }
    
}
