//
//  EFVolcanoNavigationBar.swift
//  HeadNews
//
//  Created by Cheng Sun on 5/31/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit
import SGPagingView

class EFVolcanoNavigationBar: UIView {

    typealias pageTitleViewSelectedClosure = (_ index: Int) -> ()
    var pageTitleViewSelected: ((_ index: Int) -> ())?
    var pageTitleView: SGPageTitleView?

    var titleNames = [String]() {
        didSet {
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = .black
            configuration.titleSelectedColor = .globalRedColor()
            configuration.indicatorColor = .clear
            pageTitleView = SGPageTitleView(frame: CGRect(x: -10, y: 0, width: screenWidth, height: 44), delegate: self, titleNames: titleNames, configure: configuration)
            pageTitleView!.backgroundColor = .clear
            addSubview(pageTitleView!)
        }
    }
    
    /// 固有的大小
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }

    /// 重写 frame
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        }
    }
}

extension EFVolcanoNavigationBar: SGPageTitleViewDelegate {
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        pageTitleViewSelected?(selectedIndex)
    }
}
