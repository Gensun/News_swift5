//
//  HomeJokeViewController.swift
//  HeadNews
//
//  Created by Cheng Sun on 7/29/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit

class HomeJokeViewController: HomeTableViewController {

    var isJoke = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.EF_registerCell(cell: HomeJokeCell.self)
    }
}


extension HomeJokeViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let aNews = news[indexPath.row]
        return isJoke ? aNews.jokeCellHeight : aNews.girlCellHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.EF_dequeueReusableCell(indexPath: indexPath) as HomeJokeCell
        cell.isJoke = isJoke
        cell.joke = news[indexPath.row]
        return cell
    }
}
