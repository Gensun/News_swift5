//
//  MyTheme.swift
//  HeadNews
//
//  Created by Cheng Sun on 4/1/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit
import SwiftTheme

enum MyTheme: Int {
    case day = 0
    case night
    
    static var current = MyTheme.day
    static var before = MyTheme.day
    
    static func switchTo(_ theme: MyTheme) {

        switch theme {
        case .day:
            ThemeManager.setTheme(plistName: "default_theme", path:.mainBundle)
        default:
            ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
    
    /// 选择了夜间主题
    static func switchNight(_ isToNight: Bool) {
        switchTo(isToNight ? .night : .day)
    }
    
    /// 判断当前是否是夜间主题
    static func isNight() -> Bool {
        return current == .night
    }
}

struct MyThemeStyle {
    static func setUpNavigationBarStyle(_ viewController: UIViewController,_ isNight: Bool) {
        if isNight { // 设置夜间主题
            viewController.navigationController?.navigationBar.barStyle = .black
            viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_white_night"), for: .default)
            viewController.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.grayColor113()]
        } else {     // 设置日间主题
            viewController.navigationController?.navigationBar.barStyle = .default
            viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_white"), for: .default)
        }
    }
}
