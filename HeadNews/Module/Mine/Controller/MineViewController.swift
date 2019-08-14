//
//  MineViewController.swift
//  HeadNews
//
//  Created by Cheng Sun on 3/29/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MineViewController: UITableViewController {
    private let disposeBag = DisposeBag()

    var sections = [[MyCellModel]]()
    var concerns = [MyConcern]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"

        tableView.EF_registerCell(cell: MyFisrtSectionCell.self)
        tableView.EF_registerCell(cell: MyOtherCell.self)
        
        NetworkTool.loadMyCellData {
            self.sections = $0
            self.tableView.reloadData()
            
            // action: closure 里面需要显示的self
            NetworkTool.loadMyConcern(CompletionHandler: { (item) in
                self.concerns = item
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            })
        }
        
        headerView.moreLoginButton.rx.tap.subscribe(onNext: { [self] in
            let moreLoginVC = MoreLoginViewController.loadStoryboard()
//            let storyboard = UIStoryboard(name: String(describing: MoreLoginViewController.self), bundle: nil)
//            let moreLoginVC = storyboard.instantiateViewController(withIdentifier: String(describing: MoreLoginViewController.self)) as! MoreLoginViewController
            moreLoginVC.modalSize = (width: .full, height: .custom(size: Float(screenHeight - (isIPhoneX ? 44 : 20))))
            self.present(moreLoginVC, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    
    private lazy var headerView = NoLoginHeaderView.loadViewFromNib()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension MineViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.EF_dequeueReusableCell(indexPath: indexPath) as MyFisrtSectionCell
            cell.myCellModel = sections[indexPath.section][indexPath.row]
            cell.collectionView.isHidden = (concerns.count == 0 || concerns.count == 1)
            if concerns.count == 1 { cell.myConcern = concerns[0] }
            if concerns.count > 1 { cell.myConcerns = concerns }
            
            cell.myConcernSelected = { [self] in
                let userDetail = UserDetailViewController()
                userDetail.userId = $0.userid
                self.navigationController?.pushViewController(userDetail, animated: true)
            }
            return cell
        }

        let cell = tableView.EF_dequeueReusableCell(indexPath: indexPath) as MyOtherCell
        let rowDto = sections[indexPath.section][indexPath.row]
        cell.leftLabel.text = rowDto.text
        cell.rightLabel.text = rowDto.grey_text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 114
        }
        return 45
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 3 && indexPath.row == 1 {
            let setVc = SettingViewController()
            setVc.navigationItem.title = "设置"
            navigationController?.pushViewController(setVc, animated: true)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
//        print(offsetY)
        if offsetY < 0 {
            let totalOffset = kMyHeaderViewHeight + abs(offsetY)
            let f = totalOffset / kMyHeaderViewHeight
//            print("f = ",f)
//            print(-screenWidth * (f - 1) * 0.5)
            headerView.bgImageView.frame = CGRect(x: -screenWidth * (f - 1) * 0.5, y: offsetY, width: screenWidth * f, height: totalOffset)
        }
    }
}
