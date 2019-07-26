//
//  MyTabBarViewController.swift
//  HeadNews
//
//  Created by Cheng Sun on 3/29/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

class MyTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // setup navi vc
        setChildenViewController()
        
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = UIColor.init(red: 245 / 255.0, green: 90 / 255.0, blue: 93 / 255.0, alpha: 1.0)

        tabBar.isTranslucent = true
        setValue(MyTabBar(), forKey: "tabBar")
    }
    
// MARK - set childen VC
    func setChildenViewController() {
        initChildenViewContoller(HomeViewController(), title: "Home", image: "home_tabbar_32x32_", selectedImage: "home_tabbar_press_32x32_")
        initChildenViewContoller(VideoViewController(), title: "Video", image: "video_tabbar_32x32_", selectedImage: "video_tabbar_press_32x32_")
        initChildenViewContoller(VolcanoViewController(), title: "Volcano", image: "huoshan_tabbar_32x32_", selectedImage: "huoshan_tabbar_press_32x32_")
        initChildenViewContoller(MineViewController(), title: "Mine", image: "mine_tabbar_32x32_", selectedImage: "mine_tabbar_press_32x32_")
    }
    
// MARK - init childen VC
    func initChildenViewContoller(_ childenVC: UIViewController , title: String , image: String , selectedImage: String) {

        childenVC.title = title
        childenVC.tabBarItem.image = UIImage(named: image)
        childenVC.tabBarItem.selectedImage = UIImage(named: selectedImage)
        
        let navi = MyNavigationViewController.init(rootViewController: childenVC)
        addChild(navi)
    }
}
