//
//  SQLiteManager.swift
//  HeadNews
//
//  Created by Cheng Sun on 4/11/19.
//  Copyright © 2019 EF. All rights reserved.
//

import Foundation
import SQLite


struct SQLiteManager {
    var database: Connection!
    
    init() {
        do {
            let path = NSHomeDirectory() + "/Documents/news.sqlite3"
            database = try Connection(path)
        } catch { print(error) }
    }
}

struct NewTitleTable {
    /// 数据库管理者
    private let sqlManager = SQLiteManager()
    /// 新闻标题 表
    private let new_title = Table("new_title")
    /// 表字段
    let id = Expression<Int64>("id")
    let category = Expression<String>("category")
    let tip_new = Expression<Int64>("tip_new")
    let default_add = Expression<Int64>("default_add")
    let web_url = Expression<String>("web_url")
    let concern_id = Expression<String>("concern_id")
    let icon_url = Expression<String>("icon_url")
    let flags = Expression<Int64>("flags")
    let type = Expression<Int64>("type")
    let name = Expression<String>("name")
    let selected = Expression<Bool>("selected")
    
    init() {
        try! sqlManager.database.run(new_title.create(ifNotExists: true, block: { t in
            t.column(id, primaryKey: true)
            t.column(category)
            t.column(tip_new)
            t.column(default_add)
            t.column(web_url)
            t.column(concern_id)
            t.column(icon_url)
            t.column(flags)
            t.column(type)
            t.column(name)
            t.column(selected)
        }))
    }
    
    func insert(_ titles: [HomeNewsTitle]) { _ = titles.map{ insert($0) }}
    
    /// 插入一条数据
    func insert(_ title: HomeNewsTitle) {
        /// 如果数据库中该条数据数据不存在，就插入
        if !exist(title) {
            let insert = new_title.insert(category <- title.category.rawValue, tip_new <- Int64(title.tip_new), default_add <- Int64(title.default_add), concern_id <- title.concern_id, web_url <- title.web_url, icon_url <- title.icon_url, flags <- Int64(title.flags), type <- Int64(title.type), name <- title.name, selected <- title.selected)
            /// 插入数据
            try! sqlManager.database.run(insert)
        }
    }
    
    /// 判断数据库中某一条数据是否存在
    func exist(_ title: HomeNewsTitle) -> Bool {
        // 取出该新闻分类标题的数据
        let title = new_title.filter(category == title.category.rawValue)
        // 判断该条数据是否存在，没有直接的方法
        // 可以根据 count 是否是 0 来判断是否存在这条数据，0 表示没有该条数据，1 表示存在该条数据
        let count = try! sqlManager.database.scalar(title.count)
        return count != 0
    }


    /// 查询所有数据
    func selectAll() -> [HomeNewsTitle] {
        var allTitles = [HomeNewsTitle]()
        // 遍历表中数据
        for title in try! sqlManager.database.prepare(new_title) {
            // 取出表中数据，并初始化为一个结构体模型
            let newsTitle = HomeNewsTitle(category: NewsTitleCategory(rawValue: title[category])!, tip_new: Int(title[tip_new]), default_add: Int(title[default_add]), web_url: title[web_url], concern_id: title[concern_id], icon_url: title[icon_url], flags: Int(title[flags]), type: Int(title[type]), name: title[name], selected: title[selected])
            // 添加到数组中
            allTitles.append(newsTitle)
        }
        return allTitles
    }
    
    /// 更新数据
    func update(_ newsTitle: HomeNewsTitle) {
        let title = new_title.filter(category == newsTitle.category.rawValue)
        try! sqlManager.database.run(title.update(selected <- newsTitle.selected))
    }
}
