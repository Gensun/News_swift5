//
//  VolcanoViewController.swift
//  HeadNews
//
//  Created by Cheng Sun on 4/2/19.
//  Copyright © 2019 EF. All rights reserved.
//

import SGPagingView
import UIKit

class VolcanoViewController: UIViewController {
    var pageContentView: SGPageContentCollectionView?

    private lazy var navigationBar = EFVolcanoNavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension VolcanoViewController {
    private func setupUI() {
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        navigationItem.titleView = navigationBar
        // 判断是否是夜间
        MyThemeStyle.setUpNavigationBarStyle(self, UserDefaults.standard.bool(forKey: isNight))
        // 添加通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClicked), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
        // 小视频导航栏标题的数据
        NetworkTool.loadSmallVideoCategories {
            self.navigationBar.titleNames = $0.compactMap({ $0.name })
            // set children viewcontroller
            _ = $0.compactMap({ (newTitle) -> Void in
                let categoryVC = VolcanoChildViewController()
                categoryVC.newsTitle = newTitle
                self.addChild(categoryVC)
            })
            self.pageContentView = SGPageContentCollectionView(frame: self.view.bounds, parentVC: self, childVCs: self.children)
            self.pageContentView!.delegatePageContentCollectionView = self as SGPageContentCollectionViewDelegate
            self.view.addSubview(self.pageContentView!)
        }

        navigationBar.pageTitleViewSelected = { [weak self] in
            guard let `self` = self else { return }
            self.pageContentView?.setPageContentCollectionViewCurrentIndex($0)
        }
    }

    /// 接收到了按钮点击的通知
    @objc func receiveDayOrNightButtonClicked(notification: Notification) {
        // 判断是否是夜间
        MyThemeStyle.setUpNavigationBarStyle(self, UserDefaults.standard.bool(forKey: isNight))
    }
}

// MARK: - SGPageContentViewDelegate

extension VolcanoViewController: SGPageContentCollectionViewDelegate {
    /// 联动 SGPageTitleView 的方法
    func pageContentCollectionView(_ pageContentCollectionView: SGPageContentCollectionView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        navigationBar.pageTitleView!.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
