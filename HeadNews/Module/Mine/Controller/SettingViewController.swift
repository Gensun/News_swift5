
//
//  SettingViewController.swift
//  HeadNews
//
//  Created by Cheng Sun on 4/2/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {

    var sections = [[SettingModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
//        let path: String = Bundle.main.path(forResource: "settingPlist", ofType: "plist")!
//        let plsitArray = NSArray(contentsOfFile: path) as! [Any]
//
//        for dicts in plsitArray {
//            let array = dicts as! [[String: Any]]
//            var row = [SettingModel]()
//            for dict in array {
//                let setting = SettingModel.deserialize(from: dict as Dictionary)
//                row.append(setting!)
//            }
//            sections.append(row)
//        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.EF_dequeueReusableCell(indexPath: indexPath) as SettingCell //as  派生->基类 向上。 as! as? 向下
        cell.settingDto = sections[indexPath.section][indexPath.row]
        // Configure the cell...

        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: cell.calculateDiskCashSize()
            case 2: cell.selectionStyle = .none
            default: break
            }
        }
         return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: cell.setupAlertController(cell.alertTitles[indexPath.row])
            case 1: cell.setupAlertController(cell.alertTitles[indexPath.row])
            case 3: cell.setupAlertController(cell.alertTitles[indexPath.row - 1])
            case 4: cell.setupAlertController(cell.alertTitles[indexPath.row - 1])
            default:
                break
            }
        case 1:
            if indexPath.row == 0 {
                // 离线下载
                let offLineDownLoad =  OfflineDownloadController.init()
                self.navigationController?.pushViewController(offLineDownLoad, animated: true)
            }
        default : break
        }
    }
}

extension SettingViewController {
    
    func setUpUI() {
        
        let path: String = Bundle.main.path(forResource: "settingPlist", ofType: "plist")!
        let cellPlist = NSArray(contentsOfFile: path) as! [Any]
        sections = cellPlist.compactMap({ section in
            (section as! [Any]).compactMap({ SettingModel.deserialize(from: $0 as? [String: Any]) })
        })
     
//        sections = cellplist.compactMap { (section) in
//            (section as! [Any]).compactMap({ (item) in
//                SettingModel.deserialize(from: item as? [String: Any])
//            })
//        }
        
        self.tableView.EF_registerCell(cell: SettingCell.self)
        self.tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 10
        tableView.rowHeight = 44
    }
}
