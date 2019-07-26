//
//  UserDetailViewController.swift
//  HeadNews
//
//  Created by Cheng Sun on 4/2/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserDetailViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UserDetailTableView!
    @IBOutlet weak var bottomview: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomViewBottom: NSLayoutConstraint!

    var userId: Int = 0
    var userDetail = UserDetail()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        selectedAction()
    }
    
    /// 懒加载 头部
    private lazy var headerView = UserDetailView.loadViewFromNib()
    /// 懒加载 底部
    private lazy var myBottomView: UserDetailBottomView = {
        let myBottomView = UserDetailBottomView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        myBottomView.delegate = self
        return myBottomView
    }()
    /// 懒加载 导航栏
    private lazy var navigationBar = UserDetailNavigationBar.loadViewFromNib()

    private lazy var topTabScrollView = TopTabScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_clear"), for: .default)
    }
}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        view.addSubview(topTabScrollView)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.EF_dequeueReusableCell(indexPath: indexPath) as UserDetailCell
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let navigationBarHeight: CGFloat = isIPhoneX ? -88.0 : -64.0
        
        if offsetY < navigationBarHeight {
            let totalOffset = kUserDetailHeaderBGImageViewHeight + abs(offsetY)
            let f = totalOffset / kUserDetailHeaderBGImageViewHeight
            headerView.backgroundImageView.frame = CGRect(x: -screenWidth * (f - 1) * 0.5, y: offsetY, width: screenWidth * f, height: totalOffset)
            navigationBar.navigationBar.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        } else {
            var alpha: CGFloat = (offsetY + 44) / 58
            alpha = min(alpha, 1.0)
            navigationBar.navigationBar.backgroundColor = UIColor(white: 1.0, alpha: alpha)
            if alpha == 1.0 {
                navigationController?.navigationBar.barStyle = .default
                navigationBar.returnButton.theme_setImage("images.personal_home_back_black_24x24_", forState: .normal)
                navigationBar.moreButton.theme_setImage("images.new_more_titlebar_24x24_", forState: .normal)
            } else {
                navigationController?.navigationBar.barStyle = .black
                navigationBar.returnButton.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
                navigationBar.moreButton.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
            }
            // 14 + 15 + 14
            var alpha1: CGFloat = offsetY / 57
            if offsetY >= 43 {
                alpha1 = min(alpha1, 1.0)
                navigationBar.nameLabel.isHidden = false
                navigationBar.concernButton.isHidden = false
                navigationBar.nameLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alpha1)
                navigationBar.concernButton.alpha = alpha1
            } else {
                alpha1 = min(0.0, alpha1)
                navigationBar.nameLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alpha1)
                navigationBar.concernButton.alpha = alpha1
            }
        }
    }
    
}

// MARK: - 点击事件
extension UserDetailViewController: UserDetailBottomViewDelegate {
    
    /// 按钮点击
    private func selectedAction() {
        // 返回按钮点击
        navigationBar.returnButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in // 需要加 [weak self] 防止循环引用
                self!.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        // 更多按钮点击
        navigationBar.moreButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { () in // 需要加 [weak self] 防止循环引用
                
            })
            .disposed(by: disposeBag)
        // 点击了关注按钮
        headerView.didSelectConcernButton = { [weak self] in
            self!.tableView.tableHeaderView = self!.headerView
        }
        // 当前的 topTab 类型
        topTabScrollView.currentTopTab = { [weak self] (topTab, index) in
//            let cell = self!.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UserDetailCell
//            let dongtaiVC = self!.childViewControllers[index] as! DongtaiTableViewController
//            dongtaiVC.currentTopTabType = topTab.type
//            // 偏移
//            cell.scrollView.setContentOffset(CGPoint(x: CGFloat(index) * screenWidth, y: 0), animated: true)
        }
    }
    
    // bottomView 底部按钮的点击
    func bottomView(clicked button: UIButton, bottomTab: BottomTab) {
//        let bottomPushVC = UserDetailBottomPushController()
//        bottomPushVC.navigationItem.title = "网页浏览"
//        if bottomTab.children.count == 0 { // 直接跳转到下一控制器
//            bottomPushVC.url = bottomTab.value
//            navigationController?.pushViewController(bottomPushVC, animated: true)
//        } else { // 弹出 子视图
//            // 创建 Storyboard
//            let sb = UIStoryboard(name: "\(UserDetailBottomPopController.self)", bundle: nil)
//            // 创建 UserDetailBottomPopController
//            let popoverVC = sb.instantiateViewController(withIdentifier: "\(UserDetailBottomPopController.self)") as! UserDetailBottomPopController
//            popoverVC.children = bottomTab.children
//            popoverVC.modalPresentationStyle = .custom
//            popoverVC.didSelectedChild = { [weak self] in
//                bottomPushVC.url = $0.value
//                self!.navigationController?.pushViewController(bottomPushVC, animated: true)
//            }
//            let popoverAnimator = PopoverAnimator()
//            // 转化 frame
//            let rect = myBottomView.convert(button.frame, to: view)
//            let popWidth = (screenWidth - CGFloat(userDetail.bottom_tab.count + 1) * 20) / CGFloat(userDetail.bottom_tab.count)
//            let popX = CGFloat(button.tag) * (popWidth + 20) + 20
//            let popHeight = CGFloat(bottomTab.children.count) * 40 + 25
//            popoverAnimator.presetnFrame = CGRect(x: popX, y: rect.origin.y - popHeight, width: popWidth, height: popHeight)
//            popoverVC.transitioningDelegate = popoverAnimator
//            present(popoverVC, animated: true, completion: nil)
//        }
    }
}

extension UserDetailViewController {
    /// 设置 UI
    private func setupUI() {
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        navigationController?.navigationBar.barStyle = .black
        navigationItem.titleView = navigationBar
        tableView.EF_registerCell(cell: UserDetailCell.self)
        tableView.tableFooterView = UIView()
        /// 获取用户详情数据  张雪峰 53271122458 马未都 51025535398
        //        userId = 8   // 这里可以注释掉，那么就会是不同的 userId 了
        NetworkTool.loadUserDetail(userId: userId) { (userDetail) in
            // 获取用户详情的动态列表数据
            NetworkTool.loadUserDetailDongtaiList(userId: self.userId, maxCursor: 0, completionHandler: { (cursor, dongtais) in
                if userDetail.bottom_tab.count != 0 {
                    // 底部 view 的高度
                    self.bottomViewHeight.constant = isIPhoneX ? 78 : 44
                    self.view.layoutIfNeeded()
                    self.myBottomView.bottomTabs = userDetail.bottom_tab
                    self.bottomview.addSubview(self.myBottomView)
                }
                self.userDetail = userDetail
                self.headerView.userDetail = userDetail
                self.navigationBar.userDetail = userDetail
                self.topTabScrollView.topTabs = userDetail.top_tab
                self.tableView.tableHeaderView = self.headerView
                let navigationBarHeight: CGFloat = isIPhoneX ? 88.0 : 64.0
                let rowHeight = screenHeight - navigationBarHeight - self.tableView.sectionHeaderHeight - self.bottomViewHeight.constant
                self.tableView.rowHeight = rowHeight
                // 一定要先 reload 一次，否则不能刷新数据，也不能设置行高
                self.tableView.reloadData()
                if userDetail.top_tab.count == 0 { return }
                let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UserDetailCell
                // 遍历
                for (index, topTab) in userDetail.top_tab.enumerated() {
//                    let dongtaiVC = DongtaiTableViewController()
//                    self.addChildViewController(dongtaiVC)
//                    if index == 0 { dongtaiVC.currentTopTabType = topTab.type }
//                    dongtaiVC.userId = userDetail.user_id
//                    dongtaiVC.tableView.frame = CGRect(x: CGFloat(index) * screenWidth, y: 0, width: screenWidth, height: rowHeight)
//                    cell.scrollView.addSubview(dongtaiVC.tableView)
//                    if index == userDetail.top_tab.count - 1 {
//                        cell.scrollView.contentSize = CGSize(width: CGFloat(userDetail.top_tab.count) * screenWidth, height: cell.scrollView.height)
//                    }
                }
            })
        }
    }
}
