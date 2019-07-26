//
//  NetworkTool.swift
//  HeadNews
//
//  Created by Cheng Sun on 4/1/19.
//  Copyright © 2019 EF. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

protocol NetworkToolProtocol {
    // MARK: - --------------------------------- 首页 home  ---------------------------------

    // MARK: 首页顶部新闻标题的数据

    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> Void)

    // MARK: 点击首页加号按钮，获取频道推荐数据

//    static func loadHomeCategoryRecommend(completionHandler:@escaping (_ titles: [HomeNewsTitle]) -> ())

    // MARK: 首页顶部导航栏搜索推荐标题内容

    static func loadHomeSearchSuggestInfo(_ completionHandler: @escaping (_ searchSuggest: String) -> Void)

    // MARK: 获取首页、视频、小视频的新闻列表数据

    static func loadApiNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, _ completionHandler: @escaping (_ maxBehotTime: TimeInterval, _ news: [NewsModel]) -> Void)

    // MARK: 获取首页、视频、小视频的新闻列表数据,加载更多

    static func loadMoreApiNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [NewsModel]) -> Void)

    // MARK: 获取一般新闻详情数据

//    static func loadCommenNewsDetail(articleURL: String, completionHandler:@escaping (_ htmlString: String, _ images: [NewsDetailImage], _ abstracts: [String])->())

    // MARK: 获取图片新闻详情数据

//    static func loadNewsDetail(articleURL: String, completionHandler:@escaping (_ images: [NewsDetailImage], _ abstracts: [String])->())

    // MARK: - --------------------------------- 视频 video  ---------------------------------

    // MARK: 视频顶部新闻标题的数据

    static func loadVideoApiCategoies(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> Void)

    // MARK: 解析头条的视频真实播放地址

    static func parseVideoRealURL(video_id: String, completionHandler: @escaping (_ realVideo: RealVideo) -> ())

    // MARK: 视频详情数据

//    static func loadArticleInformation(from: String, itemId: Int, groupId: Int, completionHandler: @escaping (_ videoDetail: VideoDetail) -> ())

    // MARK: - --------------------------------- 我的 mine  ---------------------------------

    // MARK: 我的界面 cell 的数据

    static func loadMyCellData(CompletionHandler: @escaping (_ sections: [[MyCellModel]]) -> Void)

    // MARK: 我的关注数据

    static func loadMyConcern(CompletionHandler: @escaping (_ concern: [MyConcern]) -> Void)

    // MARK: 获取用户详情数据

    static func loadUserDetail(userId: Int, completionHandler: @escaping (_ userDetail: UserDetail) -> Void)

    // MARK: 已关注用户，取消关注

    static func loadRelationUnfollow(userId: Int, completionHandler: @escaping (_ user: ConcernUser) -> Void)

    // MARK: 点击关注按钮，关注用户

    static func loadRelationFollow(userId: Int, completionHandler: @escaping (_ user: ConcernUser) -> Void)

    // MARK: 点击了关注按钮，就会出现相关推荐数据

//    static func loadRelationUserRecommend(userId: Int, completionHandler: @escaping (_ concerns: [UserCard]) -> ())

    // MARK: 获取用户详情的动态列表数据

    static func loadUserDetailDongtaiList(userId: Int, maxCursor: Int, completionHandler: @escaping (_ cursor: Int, _ dongtais: [UserDetailDongtai]) -> Void)

    // MARK: 获取用户详情的文章列表数据

//    static func loadUserDetailArticleList(userId: Int, completionHandler: @escaping (_ dongtais: [UserDetailDongtai]) -> ())

    // MARK: 获取用户详情的问答列表数据

//    static func loadUserDetailWendaList(userId: Int, cursor: String, completionHandler: @escaping (_ cursor: String,_ wendas: [UserDetailWenda]) -> ())

    // MARK: 获取用户详情的动态详细内容 **暂未使用本方法**

//    static func loadUserDetailDongTaiDetailContent(threadId: String, completionHandler: @escaping (_ detailContent: UserDetailDongtai) -> ())

    // MARK: 获取用户详情的动态转发或引用内容 **暂未使用本方法**

//    static func loadUserDetailDongTaiDetailCommentOrQuote(commentId: Int, completionHandler: @escaping (_ detailComment: UserDetailDongtai) -> ())

    // MARK: 获取用户详情一般的详情的评论数据

//    static func loadUserDetailNormalDongtaiComents(groupId: Int, offset: Int, count: Int, completionHandler: @escaping (_ comments: [DongtaiComment]) -> ())

    // MARK: 获取用户详情其他类型的详情的评论数据

//    static func loadUserDetailQuoteDongtaiComents(id: Int, offset: Int, completionHandler: @escaping (_ comments: [DongtaiComment]) -> ())

    // MARK: 获取动态详情的用户点赞列表数据

//    static func loadDongtaiDetailUserDiggList(id: Int, offset: Int, completionHandler: @escaping (_ comments: [DongtaiUserDigg]) -> ())

    // MARK: 获取问答的列表数据（提出了问题）

//    static func loadProposeQuestionBrow(qid: Int, enterForm: WendaEnterFrom, completionHandler: @escaping (_ wenda: Wenda) -> ())

    // MARK: 获取问答的列表数据（提出了问题），加载更多

//    static func loadMoreProposeQuestionBrow(qid: Int, offset: Int, enterForm: WendaEnterFrom, completionHandler: @escaping (_ wenda: Wenda) -> ())

    // MARK: - --------------------------------- 小视频  ---------------------------------

    // MARK: 小视频导航栏标题的数据

    static func loadSmallVideoCategories(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> Void)

    // MARK: - --------------------------------- 新年活动 ---------------------------------

    // MARK: 获取新年活动数据

//    static func loadNewYearActivities(completionHandler: @escaping (_ newYear: NewYear) -> ())

    // MARK: 增加抽卡次数

//    static func loadFestivalActivityTasks(completionHandler: @escaping (_ tasks: [NewYearTask]) -> ())
}

extension NetworkToolProtocol {
    static func loadUserDetail(userId: Int, completionHandler: @escaping (_ userDetail: UserDetail) -> Void) {
        let url = BASE_URL + "/user/profile/homepage/v4/?user_id=\(userId)&device_id=\(device_id)&iid=\(iid)"

        AF.request(url).responseJSON { DataResponse in
            let value = DataResponse.value
            let json = JSON(value as Any)

            guard json["message"] == "success" else {
                return
            }
            completionHandler(UserDetail.deserialize(from: json["data"].dictionaryObject)!)
        }
    }

    /// 获取用户详情的动态列表数据
    /// - parameter userId: 用户id
    /// - parameter maxCursor: 刷新时间
    /// - parameter completionHandler: 返回动态数据
    /// - parameter dongtais:  动态数据的数组
    static func loadUserDetailDongtaiList(userId: Int, maxCursor: Int, completionHandler: @escaping (_ cursor: Int, _ dongtais: [UserDetailDongtai]) -> Void) {
        let url = BASE_URL + "/dongtai/list/v15/?"
        let params = ["user_id": userId,
                      "max_cursor": maxCursor,
                      "device_id": device_id,
                      "iid": iid]

        AF.request(url, parameters: params).responseJSON { response in
            // 网络错误的提示信息
            let value = response.value
            let json = JSON(value as Any)

            guard json["message"] == "success" else {
                completionHandler(maxCursor, [])
                return
            }
            if let data = json["data"].dictionary {
                let max_cursor = data["max_cursor"]!.int
                if let datas = data["data"]!.arrayObject {
                    completionHandler(max_cursor!, datas.compactMap({
                        UserDetailDongtai.deserialize(from: $0 as? Dictionary)
                    }))
                }
            }
        }
    }

    static func loadHomeNewsTitleData(completionHandler: @escaping ([HomeNewsTitle]) -> Void) {
        let url = BASE_URL + "/article/category/get_subscribed/v1/?device_id=\(device_id)&iid=\(iid)"

        AF.request(url).response { DataResponse in

            let result = DataResponse.value
            let json = JSON(result as Any)

            guard json["message"] == "success" else { return }
            if let dataDict = json["data"].dictionary {
                if let datas = dataDict["data"]?.arrayObject {
                    var titles = [HomeNewsTitle]()
                    titles.append(HomeNewsTitle.deserialize(from: "{\"category\": \"\", \"name\": \"推荐\"}")!)
                    titles += datas.compactMap({
                        HomeNewsTitle.deserialize(from: $0 as? NSDictionary)
                    })
                    completionHandler(titles)
                }
            }
        }
    }

    /// my interface cell`s data
    ///
    /// - Parameter CompletionHandler: response cell data
    static func loadMyCellData(CompletionHandler: @escaping (_ sections: [[MyCellModel]]) -> Void) {
        let url = BASE_URL + "/user/tab/tabs/?"
        let params = ["device_id": device_id,
                      "iid": iid]

        AF.request(url, method: .get, parameters: params, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil).responseJSON { DataResponse in

            guard let result = DataResponse.value else { return }
            let json = JSON(result)

            guard json["message"] == "success" else { return }
            var mySections = [[MyCellModel]]()
            mySections.append([MyCellModel.deserialize(from: "{\"text\":\"我的关注\",\"grey_text\":\"\"}")!])
            if let data = json["data"].dictionary {
                if let sections = data["sections"]?.arrayObject {
                    mySections += sections.compactMap({ item in
                        (item as! [Any]).compactMap({ MyCellModel.deserialize(from: $0 as? Dictionary) })
                    })
                    CompletionHandler(mySections)
                }
            }
        }
    }

    /// get concern data
    ///
    /// - Parameter CompletionHandler: my concern data
    static func loadMyConcern(CompletionHandler: @escaping (_ concern: [MyConcern]) -> Void) {
        let url = BASE_URL + "/concern/v2/follow/my_follow/?device_id=\(device_id)"

        AF.request(url).response { DataResponse in
            guard let result = DataResponse.value else { return }
            let json = JSON(result as Any)

            guard json["message"] == "success" else { return }
            if let datas = json["data"].arrayObject {
                CompletionHandler(datas.compactMap({ MyConcern.deserialize(from: $0 as? Dictionary) }))
            }
        }
    }

    static func loadSmallVideoCategories(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> Void) {
        let url = BASE_URL + "/video_api/get_category/v1/?device_id=\(device_id)&iid=\(iid)"
        AF.request(url).responseJSON { response in
            guard let result = response.value else { return }
            let json = JSON(result as Any)

            guard json["message"] == "success" else { return }
            if let datas = json["data"].arrayObject {
                var titles = [HomeNewsTitle]()
                titles.append(HomeNewsTitle.deserialize(from: "{\"category\": \"hotsoon_video\", \"name\": \"推荐\"}")!)
                titles += datas.compactMap({ HomeNewsTitle.deserialize(from: $0 as? Dictionary) })
                completionHandler(titles)
            }
        }
    }

    static func loadApiNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, _ completionHandler: @escaping (_ maxBehotTime: TimeInterval, _ news: [NewsModel]) -> Void) {
        // 下拉刷新的时间
        let pullTime: TimeInterval = Date().timeIntervalSince1970
        let url = BASE_URL + "/api/news/feed/v75/?"
        let params = ["device_id": device_id,
                      "count": 20,
                      "list_count": 15,
                      "category": category.rawValue,
                      "min_behot_time": pullTime,
                      "strict": 0,
                      "detail": 1,
                      "refresh_reason": 1,
                      "tt_from": ttFrom,
                      "iid": iid] as [String: Any]

        AF.request(url, parameters: params).responseJSON { response in

            guard let result = response.value else { return }

            let json = JSON(result as Any)
            guard json["message"] == "success" else { return }
            guard let datas = json["data"].array else { return }
            completionHandler(pullTime, datas.compactMap({ NewsModel.deserialize(from: $0["content"].string) }))
        }
    }

    static func loadMoreApiNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [NewsModel]) -> Void) {
        let url = BASE_URL + "/api/news/feed/v75/?"
        let params = ["device_id": device_id,
                      "count": 20,
                      "list_count": listCount,
                      "category": category.rawValue,
                      "max_behot_time": maxBehotTime,
                      "strict": 0,
                      "detail": 1,
                      "refresh_reason": 1,
                      "tt_from": ttFrom,
                      "iid": iid] as [String: Any]

        AF.request(url, parameters: params).responseJSON { response in

            guard let result = response.value else { return }

            let json = JSON(result as Any)
            guard json["message"] == "success" else { return }
            guard let datas = json["data"].array else { return }
            completionHandler(datas.compactMap({ NewsModel.deserialize(from: $0["content"].string) }))
        }
    }

    static func loadRelationUnfollow(userId: Int, completionHandler: @escaping (_ user: ConcernUser) -> Void) {
        let url = BASE_URL + "/2/relation/unfollow/?"
        let params = ["user_id": userId,
                      "device_id": device_id,
                      "iid": iid]

        AF.request(url, parameters: params).responseJSON { response in
            guard let result = response.value else { return }

            let json = JSON(result as Any)
            guard json["message"] == "success" else { return }
            guard let datas = json["data"].dictionary else { return }
            completionHandler(ConcernUser.deserialize(from: datas["user"]?.dictionaryObject)!)
        }
    }

    static func loadRelationFollow(userId: Int, completionHandler: @escaping (_ user: ConcernUser) -> Void) {
        let url = BASE_URL + "/2/relation/follow/v2/?"
        let params = ["user_id": userId,
                      "device_id": device_id,
                      "iid": iid]
        AF.request(url, parameters: params).responseJSON { response in
            guard let result = response.value else { return }

            let json = JSON(result as Any)
            guard json["message"] == "success" else { return }
            completionHandler(ConcernUser.deserialize(from: json["data"]["user"].dictionaryObject)!)
        }
    }

    static func loadHomeSearchSuggestInfo(_ completionHandler: @escaping (_ searchSuggest: String) -> Void) {
        let url = BASE_URL + "/search/suggest/homepage_suggest/?"
        let params = ["device_id": device_id,
                      "iid": iid]

        AF.request(url, parameters: params).responseJSON { response in
            guard let value = response.value else { return }

            let json = JSON(value)
            guard json["message"] == "success" else { return }
            if let data = json["data"].dictionary,
                let homepageSearch = data["homepage_search_suggest"]?.string  {
                completionHandler(homepageSearch)
            }
        }
    }

    static func loadVideoApiCategoies(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> Void) {
        let url = BASE_URL + "/video_api/get_category/v1/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        AF.request(url, parameters: params).responseJSON { response in
            guard let result = response.value else { return }

            let json = JSON(result as Any)
            guard json["message"] == "success" else { return }
            if let datas = json["data"].arrayObject {
                var titles = [HomeNewsTitle]()
                titles.append(HomeNewsTitle.deserialize(from: "{\"category\": \"video\", \"name\": \"推荐\"}")!)
                titles += datas.compactMap({ HomeNewsTitle.deserialize(from: $0 as? Dictionary) })
                completionHandler(titles)
            }
        }
    }
    
    static func parseVideoRealURL(video_id: String, completionHandler: @escaping (_ realVideo: RealVideo) -> ())
    {
        let r = arc4random() // 随机数
        
        let url: NSString = "/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(r)" as NSString
        let data: NSData = url.data(using: String.Encoding.utf8.rawValue)! as NSData
        // 使用 crc32 校验
        var crc32: UInt64 = UInt64(data.getCRC32())
        // crc32 可能为负数，要保证其为正数
        if crc32 < 0 { crc32 += 0x100000000 }
        // 拼接 url
        let realURL = "http://i.snssdk.com/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(r)&s=\(crc32)"
        AF.request(realURL).responseJSON { (response) in
            if let value = response.value ,
                let videoData = JSON(value)["data"].dictionaryObject {
                completionHandler((RealVideo.deserialize(from: videoData))!)
            }
        }
    }
}

struct NetworkTool: NetworkToolProtocol {}
