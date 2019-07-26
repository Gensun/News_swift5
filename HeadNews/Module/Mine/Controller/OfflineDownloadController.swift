//
//  OfflineDownloadController.swift
//  HeadNews
//
//  Created by Cheng Sun on 4/11/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

class OfflineDownloadController: UITableViewController {

    var sections = [HomeNewsTitle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        navigationItem.title = "离线下载"
        tableView.EF_registerCell(cell: OffLineTableViewCell.self)
        tableView.rowHeight = 44
        tableView.sectionHeaderHeight = 44
        tableView.theme_separatorColor = "colors.separatorViewColor"
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        tableView.separatorStyle = .none
        
//        sections = NewTitleTable().selectAll()
        NetworkTool.loadHomeNewsTitleData { (item) in
            self.sections = item
            self.tableView .reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections.count
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.EF_dequeueReusableCell(indexPath: indexPath) as OffLineTableViewCell

        // Configure the cell...
        let homeNew = sections[indexPath.row]
        cell.titleLabel.text = homeNew.name
        cell.rightImageView.theme_image = homeNew.selected ? "images.air_download_option_press" : "images.air_download_option"
        return cell
    }
 
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.frame = CGRect(x: 20, y: 0, width: screenWidth, height: 44)
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        let label = UILabel(frame: view.frame)
        label.text = "我的频道"
        let sep = UIView(frame: CGRect(x: 0, y: 43, width: screenWidth, height: 1))
        sep.theme_backgroundColor = "colors.separatorViewColor"
        view.addSubview(sep)
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var newsTitle = sections[indexPath.row]
        newsTitle.selected = !newsTitle.selected
        let cell = tableView.cellForRow(at: indexPath) as! OffLineTableViewCell
        cell.rightImageView.theme_image = newsTitle.selected ? "images.air_download_option_press" : "images.air_download_option"
        sections[indexPath.row] = newsTitle
        tableView .reloadRows(at: [indexPath], with: .automatic)
    }
}
