//
//  HomeRecommendController.swift
//  HeadNews
//
//  Created by Cheng Sun on 7/29/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

class HomeRecommendController: HomeTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        // 注册推荐的 cell
        tableView.EF_registerCell(cell: HomeUserCell.self)
        tableView.EF_registerCell(cell: TheyAlsoUseCell.self)
        tableView.EF_registerCell(cell: HomeCell.self)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let aNews = news[indexPath.row]
        switch aNews.cell_type {
        case .user:
            return aNews.contentH
        case .relatedConcern:
            return 290
        case .none:
            return aNews.cellHeight
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aNews = news[indexPath.row]
        switch aNews.cell_type {
        case .user:             // 用户
            let cell = tableView.EF_dequeueReusableCell(indexPath: indexPath) as HomeUserCell
            cell.aNews = aNews
            return cell
        case .relatedConcern:   // 相关关注
            let cell = tableView.EF_dequeueReusableCell(indexPath: indexPath) as TheyAlsoUseCell
            cell.theyUse = aNews.raw_data
            return cell
        case .none:
            let cell = tableView.EF_dequeueReusableCell(indexPath: indexPath) as HomeCell
            cell.aNews = aNews
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var aNews = news[indexPath.row]
//        if indexPath.row == 0 { // 默认设置点击第一个 cell 跳转到图片详情界面
//            let newsDetailImageVC = NewsDetailImageController.loadStoryboard()
//            newsDetailImageVC.isSelectedFirstCell = true
//            aNews.item_id = 6450240420034118157
//            aNews.group_id = 6450237670911852814
//            newsDetailImageVC.aNews = aNews
//            present(newsDetailImageVC, animated: false, completion: nil)
//        } else if (aNews.source == "悟空问答") { // 悟空问答
//            let wendaVC = WendaViewController()
//            wendaVC.qid = aNews.item_id
//            wendaVC.enterForm = .clickHeadline
//            navigationController?.pushViewController(wendaVC, animated: true)
//        } else if aNews.has_video {
//            // 跳转到视频详情控制器
//            let videoDetailVC = VideoDetailViewController()
//            videoDetailVC.video = aNews
//            navigationController?.pushViewController(videoDetailVC, animated: true)
//        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
