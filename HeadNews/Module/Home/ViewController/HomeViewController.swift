//
//  HomeViewController.swift
//  HeadNews
//
//  Created by Cheng Sun on 3/29/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit
import SGPagingView
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    /// 标题和内容
    private var pageTitleView: SGPageTitleView?
    private var pageContentView: SGPageContentCollectionView?
    private lazy var navigationBar = HomeNavigationView.loadViewFromNib()
    private lazy var disposeBag = DisposeBag()
    
    /// 添加频道按钮
    private lazy var addChannelButton: UIButton = {
        let addChannelButton = UIButton(frame: CGRect(x: screenWidth - newsTitleHeight, y: 0, width: newsTitleHeight, height: newsTitleHeight))
        addChannelButton.theme_setImage("images.add_channel_titlbar_thin_new_16x16_", forState: .normal)
        let separatorView = UIView(frame: CGRect(x: 0, y: newsTitleHeight - 1, width: newsTitleHeight, height: 1))
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        addChannelButton.addSubview(separatorView)
        return addChannelButton
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.theme_backgroundColor = "colors.windowColor"
        // 设置状态栏属性
        navigationController?.navigationBar.barStyle = .black
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background" + (UserDefaults.standard.bool(forKey: isNight) ? "_night" : "")), for: .default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        setupUI()
        clickAction()
    }
    
    /// 设置 UI
    private func setupUI() {
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        // 设置自定义导航栏
        navigationItem.titleView = navigationBar
        // 添加频道
        view.addSubview(addChannelButton)
        // 首页顶部新闻标题的数据
        NetworkTool.loadHomeNewsTitleData {
            // 向数据库中插入数据
            NewTitleTable().insert($0)
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = .black
            configuration.titleSelectedColor = .globalRedColor()
            configuration.indicatorColor = .clear
            // 标题名称的数组
            self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 0, width: screenWidth - newsTitleHeight, height: newsTitleHeight), delegate: self, titleNames: $0.compactMap({ $0.name }), configure: configuration)
            self.pageTitleView!.backgroundColor = .clear
            
            self.view.addSubview(self.pageTitleView!)
            // 设置子控制器
            _ = $0.compactMap({ (newsTitle) -> () in
                switch newsTitle.category {
                case .video:            // 视频
                    let videoTableVC = VideoTableViewController()
                    videoTableVC.newsTitle = newsTitle
                    videoTableVC.setupRefresh(with: .video)
                    self.addChild(videoTableVC)
                case .essayJoke:        // 段子
                    let essayJokeVC = HomeJokeViewController()
                    essayJokeVC.isJoke = true
                    essayJokeVC.setupRefresh(with: .essayJoke)
                    self.addChild(essayJokeVC)
                case .imagePPMM:        // 街拍
                    let imagePPMMVC = HomeJokeViewController()
                    imagePPMMVC.isJoke = false
                    imagePPMMVC.setupRefresh(with: .imagePPMM)
                    self.addChild(imagePPMMVC)
                case .imageFunny:        // 趣图
                    let imagePPMMVC = HomeJokeViewController()
                    imagePPMMVC.isJoke = false
                    imagePPMMVC.setupRefresh(with: .imageFunny)
                    self.addChild(imagePPMMVC)
                case .photos:           // 图片,组图
                    let homeImageVC = HomeImageViewController()
                    homeImageVC.setupRefresh(with: .photos)
                    self.addChild(homeImageVC)
                case .jinritemai:       // 特卖
                    let temaiVC = TeMaiViewController()
                    temaiVC.url = "https://m.maila88.com/mailaIndex?mailaAppKey=GDW5NMaKQNz81jtW2Yuw2P"
                    self.addChild(temaiVC)
                default :
                    let homeTableVC = HomeRecommendController()
                    homeTableVC.setupRefresh(with: newsTitle.category)
                    self.addChild(homeTableVC)
                }
            })
            // 内容视图
            self.pageContentView = SGPageContentCollectionView(frame: CGRect(x: 0, y: newsTitleHeight, width: screenWidth, height: self.view.height - newsTitleHeight), parentVC: self, childVCs: self.children)
            self.pageContentView!.delegatePageContentCollectionView = self as SGPageContentCollectionViewDelegate
            self.view.addSubview(self.pageContentView!)
        }
    }
    
    private func clickAction() {
        navigationBar.didSelectSearchButton = {
            
        }
        navigationBar.didSelectAvatarButton = {
            
        }
        navigationBar.didSelectCameraButton = {
            
        }
        addChannelButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext:  { [weak self] in
                guard  let `self` = self else { return }
//                let homeAddCategoryVC = HomeAddCategoryController.loadStoryboard()
//                homeAddCategoryVC.modalSize = (width: .full, height: .custom(size: Float(screenHeight - (isIPhoneX ? 44 : 20))))
//                self?.present(homeAddCategoryVC, animated: true, completion: nil)
            }).disposed(by: disposeBag)
}
}


// MARK: - SGPageTitleViewDelegate
extension HomeViewController: SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate {
    /// 联动 pageContent 的方法
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentView?.setPageContentCollectionViewCurrentIndex(selectedIndex)
    }
    
    /// 联动 SGPageTitleView 的方法
    func pageContentCollectionView(_ pageContentCollectionView: SGPageContentCollectionView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
