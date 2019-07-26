//
//  SmallVideoViewController.swift
//  HeadNews
//
//  Created by Cheng Sun on 7/24/19.
//  Copyright © 2019 EF. All rights reserved.
//
import UIKit
import BMPlayer

class SmallVideoViewController: UIViewController {
    @IBOutlet var titleButton: UIButton!
    /// 顶部约束
    @IBOutlet weak var close: UIButton!
    @IBOutlet var titleTop: NSLayoutConstraint!
    @IBOutlet var bottomViewBottom: NSLayoutConstraint!
    /// 评论按钮
    @IBOutlet var commentButton: UIButton!
    /// 点赞按钮
    @IBOutlet var diggButton: UIButton!
    /// 分享按钮
    @IBOutlet var shareButton: UIButton!
    /// 显示背景图片的 collectionView
    @IBOutlet var collectionView: UICollectionView!
    /// 播放器
    private lazy var player = BMPlayer(customControlView: SmallVideoPlayerCustomView())

    /// 小视频数组
    var smallVideos = [NewsModel]()
    /// 原始 索引
    var originalIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    func setupUI() {
        collectionView.collectionViewLayout = SmallVideoLayout()
        collectionView.EF_registerCell(cell: SmallVideoCell.self)
        diggButton.setImage(UIImage(named: "hts_vp_like_24x24_"), for: .normal)
        diggButton.setImage(UIImage(named: "hts_vp_like_press_24x24_"), for: .selected)
        bottomViewBottom.constant = isIPhoneX ? 34 : 0
        titleTop.constant = isIPhoneX ? 40 : 0
        view.layoutIfNeeded()
        let smallVideo = smallVideos[originalIndex]
        switch smallVideo.raw_data.group_source {
        case .huoshan:
            titleButton.theme_setImage("images.huoshan_logo_new_100x28_", forState: .normal)
        case .douyin:
            titleButton.theme_setImage("images.douyin_logo_new_100x28_", forState: .normal)
        }
        commentButton.setTitle(smallVideo.raw_data.action.commentCount, for: .normal)
        diggButton.setTitle(smallVideo.raw_data.action.diggCount, for: .normal)
        collectionView.scrollToItem(at: IndexPath(item: originalIndex, section: 0), at: .centeredHorizontally, animated: false)
        // 设置播放器
        setupPlayer(currentIndex: originalIndex)
        close.bringSubviewToFront(self.view)
    }

    /// 设置播放器
    private func setupPlayer(currentIndex: Int) {
        // 当前的视频
        let smallVide = smallVideos[currentIndex]
        if let videoURLString = smallVide.raw_data.video.play_addr.url_list.first {
            let dataTask = URLSession.shared.dataTask(with: URL(string: videoURLString)!, completionHandler: { _, response, _ in
                // 主线程添加播放器
                DispatchQueue.main.async {
                    // 获取当前的 cell
                    guard let cell = self.collectionView.cellForItem(at: IndexPath(item: currentIndex, section: 0)) as? SmallVideoCell else { return }
                    if self.player.isPlaying { self.player.pause() }
                    // 先把 bgImageView 的子视图移除，再添加
                    for subview in cell.bgImageView.subviews { subview.removeFromSuperview() }
                    cell.bgImageView.addSubview(self.player)
                    self.player.snp.makeConstraints({ $0.edges.equalTo(cell.bgImageView) })
                    let asset = BMPlayerResource(url: URL(string: response!.url!.absoluteString)!)
                    self.player.setVideo(resource: asset)
                }
            })
            dataTask.resume()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SmallVideoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smallVideos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.EF_dequeueReusableCell(indexPath: indexPath) as SmallVideoCell
        cell.smallVideo = smallVideos[indexPath.item]
        // 头像按钮名按钮点击
        cell.didSelectAvatarOrNameButton = {
//            let postCommentView = PostCommentView.loadViewFromNib()
//            postCommentView.placeholderLabel.text = "优质评论将会被优先展示"
//            postCommentView.isEmojiButtonSelected = false
//            UIApplication.shared.keyWindow?.backgroundColor = .white
//            UIApplication.shared.keyWindow?.addSubview(postCommentView)
        }
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / scrollView.width + 0.5)
        // 根据当前索引设置播放器
        setupPlayer(currentIndex: currentIndex)
    }
}

// MARK: - 点击事件

extension SmallVideoViewController {
    /// 关闭按钮点击
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }

    /// 标题按钮点击
    @IBAction func titleButtonClicked(_ sender: UIButton) {
    }

    /// 更多按钮点击
    @IBAction func moreButtonClicked(_ sender: UIButton) {
    }

    /// 写评论按钮点击
    @IBAction func writeButtonClicked(_ sender: UIButton) {
    }

    /// 评论按钮点击
    @IBAction func commentButtonClicked(_ sender: UIButton) {
    }

    /// 点赞按钮点击
    @IBAction func diggButtonClicked(_ sender: UIButton) {
    }

    /// 分享按钮点击
    @IBAction func shareButtonClicked(_ sender: UIButton) {
    }
}
