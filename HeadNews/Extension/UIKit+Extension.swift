//
//  UIKit+Extension.swift
//  HeadNews
//
//  Created by Cheng Sun on 4/1/19.
//  Copyright © 2019 EF. All rights reserved.
//

import CoreText
import UIKit

protocol RegisterCellFromNib {}

extension RegisterCellFromNib {
    static var identifier: String {
        return "\(self)"
    }

    static var nib: UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}

extension UITableView {
    /// 注册 cell 的方法
    func EF_registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellFromNib {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        } else {
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }

    /// 从缓存池池出队已经存在的 cell
    func EF_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    /// 注册 cell 的方法
    func EF_registerCell<T: UICollectionViewCell>(cell: T.Type) where T: RegisterCellFromNib {
        if let nib = T.nib { register(nib, forCellWithReuseIdentifier: T.identifier) }
        else { register(cell, forCellWithReuseIdentifier: T.identifier) }
    }

    /// 从缓存池池出队已经存在的 cell
    func EF_dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

    /// 注册头部
    func EF_registerSupplementaryHeaderView<T: UICollectionReusableView>(reusableView: T.Type) where T: RegisterCellFromNib {
        // T 遵守了 RegisterCellOrNib 协议，所以通过 T 就能取出 identifier 这个属性
        if let nib = T.nib {
            register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        } else {
            register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        }
    }

    /// 获取可重用的头部
    func EF_dequeueReusableSupplementaryHeaderView<T: UICollectionReusableView>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

protocol StoryBoardLoadable {
}

extension StoryBoardLoadable where Self: UIViewController {
    static func loadStoryboard() -> Self {
        return UIStoryboard(name: "\(self)", bundle: nil).instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}

protocol NibLoadable {
}

extension NibLoadable {
    static func loadViewFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! Self
    }
}

extension UIView {
    /// x
    var x: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }

    /// y
    var y: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }

    /// height
    var height: CGFloat {
        get { return frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }

    /// width
    var width: CGFloat {
        get { return frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }

    /// size
    var size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }

    /// centerX
    var centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }

    /// centerY
    var centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }

    func showSkeleton(view: UIView, animated: Bool = true, withLighColors: Bool = true) {
        for subview in view.subviews {
            guard subview.tag != notAnimateTag, !subview.isHidden else {
                continue
            }
            showSkeleton(view: subview)
            subview.addSkeletonLayer(animated: animated, withLighColors: withLighColors)
        }
    }

    func removeSkeleton(view: UIView) {
        for subview in view.subviews {
            removeSkeleton(view: subview)
            subview.removeSkeletonLayer()
        }
    }

    private func removeSkeletonLayer() {
        guard self.tag != notAnimateTag, !self.isHidden, self.layer.sublayers != nil else {
            return
        }
        layer.sublayers = nil
    }

    private func addSkeletonLayer(animated: Bool, withLighColors: Bool) {
        if let viewAsLabel = self as? UILabel {
            viewAsLabel.text = ""
            let numberOfLayers = viewAsLabel.numberOfLines > 0 ? viewAsLabel.numberOfLines : 1
            let layerHeight: CGFloat = 10
            for index in 0 ... numberOfLayers where index % 2 == 0 {
                if animated {
                    addGradientLayer(withHeight: layerHeight, width: self.bounds.width - CGFloat(index * 20), origin: CGFloat(index) * layerHeight, withLighColors: withLighColors)
                } else {
                    addSolidLayer(withHeight: layerHeight, width: self.bounds.width - CGFloat(index * 20), origin: CGFloat(index) * layerHeight)
                }
            }

        } else if let viewAsImageView = self as? UIImageView {
            viewAsImageView.image = nil
        }

        if animated {
            addGradientLayer(withHeight: bounds.height, width: bounds.height, withLighColors: withLighColors)
        } else {
            addSolidLayer(withHeight: bounds.height, width: bounds.height)
        }
    }

    private func addGradientLayer(withHeight height: CGFloat, width: CGFloat, origin: CGFloat = 0, withLighColors: Bool) {
        let gradient = CAGradientLayer()
        let fragmentSize = 0.5
        gradient.frame = CGRect(x: 0, y: origin, width: width, height: height > 10 ? 10 : height)
        gradient.startPoint = CGPoint(x: -(1 + fragmentSize), y: 0)
        gradient.endPoint = CGPoint(x: 1 + fragmentSize, y: 0)

        if withLighColors {
            gradient.colors = [
                UIColor.white.cgColor,
                UIColor.white.cgColor,
                UIColor.gradientLightGray().cgColor,
                UIColor.white.cgColor,
                UIColor.gradientLightGray().cgColor,
            ]
        } else {
            gradient.colors = [
                UIColor.gradientLightGray().cgColor,
                UIColor.gradientLightGray().cgColor,
                UIColor.gradientDarkerGray().cgColor,
                UIColor.gradientLightGray().cgColor,
                UIColor.gradientDarkerGray().cgColor,
            ]
        }

        let startLocations = [NSNumber(value: Double(gradient.startPoint.x)),
                              NSNumber(value: Double(gradient.startPoint.x)),
                              NSNumber(value: 0),
                              NSNumber(value: fragmentSize),
                              NSNumber(value: 1 + fragmentSize)]

        gradient.locations = startLocations

        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = startLocations

        gradientAnimation.toValue = [
            NSNumber(value: 0),
            NSNumber(value: 1),
            NSNumber(value: 1),
            NSNumber(value: 1 + (fragmentSize - 0.1)),
            NSNumber(value: 1 + fragmentSize)]

        gradientAnimation.repeatCount = Float.infinity
        gradientAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientAnimation.isRemovedOnCompletion = false
        gradientAnimation.duration = 1.2
        gradient.add(gradientAnimation, forKey: "locations")
        layer.insertSublayer(gradient, at: 0)
    }

    private func addSolidLayer(withHeight height: CGFloat, width: CGFloat, origin: CGFloat = 0) {
        let gradient = CALayer()
        gradient.frame = CGRect(x: 0, y: origin, width: width, height: height > 10 ? 10 : height)
        gradient.backgroundColor = UIColor.gradientLightGray().cgColor
        layer.addSublayer(gradient)
    }
}

extension UIColor {
    static func gradientLightGray() -> UIColor {
        return UIColor(red: 220.0 / 255.0, green: 220.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
    }

    static func gradientDarkerGray() -> UIColor {
        return UIColor(red: 180 / 255.0, green: 180 / 255.0, blue: 180 / 255.0, alpha: 1.0)
    }
}

extension UIColor {
    //        self.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }

    /// 背景灰色 f8f9f7
    class func globalBackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }

    /// 背景红色
    class func globalRedColor() -> UIColor {
        return UIColor(r: 196, g: 73, b: 67)
    }

    /// 字体蓝色
    class func blueFontColor() -> UIColor {
        return UIColor(r: 72, g: 100, b: 149)
    }

    /// 背景灰色 132
    class func grayColor132() -> UIColor {
        return UIColor(r: 132, g: 132, b: 132)
    }

    /// 背景灰色 232
    class func grayColor232() -> UIColor {
        return UIColor(r: 232, g: 232, b: 232)
    }

    /// 夜间字体背景灰色 113
    class func grayColor113() -> UIColor {
        return UIColor(r: 113, g: 113, b: 113)
    }

    /// 夜间背景灰色 37
    class func grayColor37() -> UIColor {
        return UIColor(r: 37, g: 37, b: 37)
    }

    /// 灰色 210
    class func grayColor210() -> UIColor {
        return UIColor(r: 210, g: 210, b: 210)
    }
}

extension UIImageView {
    /// 设置图片圆角
    func circleImage() {
        /// 建立上下文
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        /// 获取当前上下文
        let ctx = UIGraphicsGetCurrentContext()
        /// 添加一个圆，并裁剪
        ctx?.addEllipse(in: bounds)
        ctx?.clip()
        /// 绘制图像
        draw(bounds)
        /// 获取绘制的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        /// 关闭上下文
        UIGraphicsEndImageContext()
        DispatchQueue.global().async {
            self.image = image
        }
    }
}
