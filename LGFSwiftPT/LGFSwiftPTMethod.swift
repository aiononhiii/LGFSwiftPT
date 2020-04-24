//
//  LGFSwiftPTMethod.swift
//  LGFSwiftPT
//
//  Created by 来 on 2019/10/9.
//  Copyright © 2019 laiguofeng. All rights reserved.
//

import Foundation
import UIKit

/*
 LGFSwiftPTMethod 这里的所有代码都可以用自定义来代替（可用作自定义动画时的参考）
 */

// MARK: ------------------- 我自己原配的 line 滚动动画逻辑代码
public func lgf_AutoScrollLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ progress: CGFloat) {
    switch style.lgf_LineAnimation {
    case .defult:
            lgf_PageLineAnimationDefultScrollLineAnimationConfig(style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, line, progress)
        break
    case .shortToLong:
            lgf_PageLineAnimationShortToLongScrollLineAnimationConfig(style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, line, progress)
        break
    case .hideShow:
            lgf_PageLineAnimationHideShowScrollLineAnimationConfig(style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, line, progress)
        break
    case .smallToBig:
            lgf_PageLineAnimationSmallToBigScrollLineAnimationConfig(style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, line, progress)
        break
    case .tortoiseDown:
            lgf_PageLineAnimationTortoiseDownScrollLineAnimationConfig(style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, line, progress)
        break
    case .tortoiseUp:
            lgf_PageLineAnimationTortoiseUpScrollLineAnimationConfig(style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, line, progress)
        break
    default:
        break
    }
}

public func lgf_PageLineAnimationDefultScrollLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ progress: CGFloat) {
    line.lgfpt_X = selectX * progress + unSelectX * (1.0 - progress)
    line.lgfpt_Width = selectWidth * progress + unSelectWidth * (1.0 - progress)
}

public func lgf_PageLineAnimationShortToLongScrollLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ progress: CGFloat) {
    var space: CGFloat = 0.0
    if style.lgf_IsZoomExtruding {
        space = (unSelectTitle.lgfpt_Width - unSelectWidth) / 2.0 + (selectTitle.lgfpt_Width - selectWidth) / 2.0
    } else {
        space = (unSelectTitle.lgfpt_Width / unSelectTitle.lgf_CurrentTransformSX - unSelectWidth) / 2.0 + (selectTitle.lgfpt_Width / selectTitle.lgf_CurrentTransformSX - selectWidth) / 2.0
    }
    if progress > 0.5 {
        if unSelectIndex < selectIndex {
            line.lgfpt_X = selectX - (space + unSelectWidth) * 2.0 * (1.0 - progress)
        } else {
            line.lgfpt_X = selectX
        }
    } else {
        if unSelectIndex > selectIndex {
            line.lgfpt_X = unSelectX - (space + selectWidth) * 2.0 * progress
        } else {
            line.lgfpt_X = unSelectX
        }
    }
    if progress > 0.5 {
        line.lgfpt_Width = selectWidth  + (unSelectWidth + space) * 2.0 * (1.0 - progress)
    } else {
        line.lgfpt_Width = unSelectWidth + (selectWidth + space) * 2.0 * progress
    }
}

public func lgf_PageLineAnimationHideShowScrollLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ progress: CGFloat) {
    if progress > 0.5 {
        line.lgfpt_X = selectX
        line.lgfpt_Width = selectWidth
        line.alpha = 1.0 - (2.0 * (1.0 - progress))
    } else {
        line.lgfpt_X = unSelectX
        line.lgfpt_Width = unSelectWidth
        line.alpha = 1.0 - (2.0 * progress)
    }
}

public func lgf_PageLineAnimationSmallToBigScrollLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ progress: CGFloat) {
    line.transform = CGAffineTransform.identity
    if progress > 0.5 {
        let num = 1.0 - (2.0 * (1.0 - progress))
        line.lgfpt_X = selectX
        line.lgfpt_Width = selectWidth
        line.transform = CGAffineTransform.init(scaleX: num, y: num)
    } else {
        let num = 1.0 - (2.0 * progress)
        line.lgfpt_X = unSelectX
        line.lgfpt_Width = unSelectWidth
        line.transform = CGAffineTransform.init(scaleX: num, y: num)
    }
}

public func lgf_PageLineAnimationTortoiseDownScrollLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ progress: CGFloat) {
    let space = style.lgf_LineBottom + line.lgfpt_Height
    if progress > 0.5 {
        line.lgfpt_X = selectX
        line.lgfpt_Width = selectWidth
        line.transform = CGAffineTransform.identity
        line.transform = CGAffineTransform.init(translationX: 0.0, y: space * (2.0 * (1.0 - progress)))
    } else {
        line.lgfpt_X = unSelectX
        line.lgfpt_Width = unSelectWidth
        line.transform = CGAffineTransform.identity
        line.transform = CGAffineTransform.init(translationX: 0.0, y: space + space * (1.0 - (2.0 * (1.0 - progress))))
    }
}

public func lgf_PageLineAnimationTortoiseUpScrollLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ progress: CGFloat) {
    let space = style.lgf_LineBottom - style.lgf_PVTitleView.lgfpt_Height
    if progress > 0.5 {
        line.lgfpt_X = selectX
        line.lgfpt_Width = selectWidth
        line.transform = CGAffineTransform.identity
        line.transform = CGAffineTransform.init(translationX: 0.0, y: space * (2.0 * (1.0 - progress)))
    } else {
        line.lgfpt_X = unSelectX
        line.lgfpt_Width = unSelectWidth
        line.transform = CGAffineTransform.identity
        line.transform = CGAffineTransform.init(translationX: 0.0, y: space + space * (1.0 - (2.0 * (1.0 - progress))))
    }
}

// MARK: ------------------- 我自己原配的 line 点击动画逻辑代码
public func lgf_AutoClickLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ duration: TimeInterval) {
    switch style.lgf_LineAnimation {
    case .defult:
        lgf_PageLineAnimationDefultClickLineAnimationConfig(style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, line, duration)
        break
    case .shortToLong:
        lgf_PageLineAnimationShortToLongClickLineAnimationConfig(style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, line, duration)
        break
    case .hideShow:
        lgf_PageLineAnimationHideShowClickLineAnimationConfig(style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, line, duration)
        break
    case .smallToBig:
        lgf_PageLineAnimationSmallToBigClickLineAnimationConfig(style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, line, duration)
        break
    case .tortoiseDown:
        lgf_PageLineAnimationTortoiseDownClickLineAnimationConfig(style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, line, duration)
        break
    case .tortoiseUp:
        lgf_PageLineAnimationTortoiseUpClickLineAnimationConfig(style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, line, duration)
        break
    default:
        break
    }
}

public func lgf_PageLineAnimationDefultClickLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ duration: TimeInterval) {
    line.lgfpt_X = selectX
    line.lgfpt_Width = selectWidth
}

public func lgf_PageLineAnimationShortToLongClickLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ duration: TimeInterval) {
    line.lgfpt_X = selectX
    line.lgfpt_Width = selectWidth
}

public func lgf_PageLineAnimationHideShowClickLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ duration: TimeInterval) {
    // 通过关键帧动画配合我给你的 duration，你应该可以实现很多你想要的独有的效果
    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5 - (0.0001 / duration)) {
        line.alpha = 0.0
    }
    UIView.addKeyframe(withRelativeStartTime: 0.5 + (0.0001 / duration), relativeDuration: 0.5 - (0.0001 / duration)) {
        line.alpha = 1.0
    }
    UIView.addKeyframe(withRelativeStartTime: 0.5 - (0.0001 / duration), relativeDuration: 0.0002 / duration) {
        line.lgfpt_X = selectX
        line.lgfpt_Width = selectWidth
    }
}

public func lgf_PageLineAnimationSmallToBigClickLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ duration: TimeInterval) {
    // 通过关键帧动画配合我给你的 duration，你应该可以实现很多你想要的独有的效果
    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5 - (0.0001 / duration)) {
        line.transform = CGAffineTransform.init(scaleX: 0.0001, y: 0.0001)
    }
    UIView.addKeyframe(withRelativeStartTime: 0.5 + (0.0001 / duration), relativeDuration: 0.5 - (0.0001 / duration)) {
        line.transform = CGAffineTransform.identity
    }
    UIView.addKeyframe(withRelativeStartTime: 0.5 - (0.0001 / duration), relativeDuration: 0.0002 / duration) {
        line.lgfpt_X = selectX
        line.lgfpt_Width = selectWidth
    }
}

public func lgf_PageLineAnimationTortoiseDownClickLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ duration: TimeInterval) {
    let space = style.lgf_LineBottom + line.lgfpt_Height
    // 通过关键帧动画配合我给你的 duration，你应该可以实现很多你想要的独有的效果
    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5 - (0.0001 / duration)) {
        line.transform = CGAffineTransform.init(translationX: 0.0, y: space)
    }
    UIView.addKeyframe(withRelativeStartTime: 0.5 + (0.0001 / duration), relativeDuration: 0.5 - (0.0001 / duration)) {
        line.transform = CGAffineTransform.identity
    }
    UIView.addKeyframe(withRelativeStartTime: 0.5 - (0.0001 / duration), relativeDuration: 0.0002 / duration) {
        line.lgfpt_X = selectX
        line.lgfpt_Width = selectWidth
    }
}

public func lgf_PageLineAnimationTortoiseUpClickLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ duration: TimeInterval) {
    let space = style.lgf_LineBottom - style.lgf_PVTitleView.lgfpt_Height
    // 通过关键帧动画配合我给你的 duration，你应该可以实现很多你想要的独有的效果
    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5 - (0.0001 / duration)) {
        line.transform = CGAffineTransform.init(translationX: 0.0, y: space)
    }
    UIView.addKeyframe(withRelativeStartTime: 0.5 + (0.0001 / duration), relativeDuration: 0.5 - (0.0001 / duration)) {
        line.transform = CGAffineTransform.identity
    }
    UIView.addKeyframe(withRelativeStartTime: 0.5 - (0.0001 / duration), relativeDuration: 0.0002 / duration) {
        line.lgfpt_X = selectX
        line.lgfpt_Width = selectWidth
    }
}

// MARK: ------------------- 我自己原配的 标 跟随动画逻辑代码
public func lgf_AutoTitleScrollFollowAnimationConfig(_ style: LGFSwiftPTStyle, _ lgf_TitleButtons: [LGFSwiftPTTitle], _ unSelectIndex: Int, _ selectIndex: Int, _ duration: TimeInterval) {
    switch style.lgf_TitleScrollFollowType {
    case .defult:
        lgf_TitleScrollFollowDefultAnimationConfig(style, lgf_TitleButtons, unSelectIndex, selectIndex, duration)
        break
    case .leftRight:
        lgf_TitleScrollFollowLeftRightAnimationConfig(style, lgf_TitleButtons, unSelectIndex, selectIndex, duration)
        break
    default:
        break
    }
}

public func lgf_TitleScrollFollowDefultAnimationConfig(_ style: LGFSwiftPTStyle, _ lgf_TitleButtons: [LGFSwiftPTTitle], _ unSelectIndex: Int, _ selectIndex: Int, _ duration: TimeInterval) {
    let selectTitle = lgf_TitleButtons[selectIndex]
    let offSetx = min(max(selectTitle.center.x - style.lgf_PVTitleView.lgfpt_Width * 0.5, 0.0), max(style.lgf_PVTitleView.contentSize.width - style.lgf_PVTitleView.lgfpt_Width, 0.0))
    UIView.animate(withDuration: duration) {
        style.lgf_PVTitleView.contentOffset = CGPoint.init(x: offSetx, y: 0.0)
    }
}

public func lgf_TitleScrollFollowLeftRightAnimationConfig(_ style: LGFSwiftPTStyle, _ lgf_TitleButtons: [LGFSwiftPTTitle], _ unSelectIndex: Int, _ selectIndex: Int, _ duration: TimeInterval) {
    let isRight = selectIndex > unSelectIndex
    let title = lgf_TitleButtons[isRight ? min(selectIndex + 1, lgf_TitleButtons.count - 1) : max(selectIndex - 1, 0)]
    UIView.animate(withDuration: duration) {
        if (isRight) {
            if selectIndex == (lgf_TitleButtons.count - 1) {
                style.lgf_PVTitleView.contentOffset = CGPoint.init(x: style.lgf_PVTitleView.contentSize.width - style.lgf_PVTitleView.lgfpt_Width, y: 0.0)
            } else {
                if (title.lgfpt_X + title.lgfpt_Width) >= (style.lgf_PVTitleView.contentOffset.x + style.lgf_PVTitleView.lgfpt_Width) {
                    style.lgf_PVTitleView.contentOffset = CGPoint.init(x: title.lgfpt_X + title.lgfpt_Width - style.lgf_PVTitleView.lgfpt_Width + (((selectIndex + 1) == (lgf_TitleButtons.count - 1)) ? style.lgf_PageLeftRightSpace : 0.0), y: 0.0)
                }
            }
        } else {
            if selectIndex == 0 {
                style.lgf_PVTitleView.contentOffset = CGPoint.init(x: 0.0, y: 0.0)
            } else {
                if title.lgfpt_X < style.lgf_PVTitleView.contentOffset.x {
                    style.lgf_PVTitleView.contentOffset = CGPoint.init(x: title.lgfpt_X - (((selectIndex - 1) == 0) ? style.lgf_PageLeftRightSpace : 0.0), y: 0.0)
                }
            }
        }
    }
}

// MARK: ------------------- 新增的放大缩小后紧紧贴着左右（互相挤压）（类似汽车之家效果）
public func lgf_ZoomExtruding(_ allTitles: [LGFSwiftPTTitle], _ style: LGFSwiftPTStyle, _ selectTitle: LGFSwiftPTTitle, _ unSelectTitle: LGFSwiftPTTitle, _ selectIndex: Int, _ unSelectIndex: Int, _ progress: CGFloat) {
    for (index, title) in allTitles.enumerated() {
        if index == 0 {
            title.lgfpt_X = 0.0
        }
        if index - 1 > 0 {
            let left = allTitles[index - 1]
            left.lgfpt_X = title.lgfpt_X - left.lgfpt_Width
        }
        if index + 1 < allTitles.count {
            let right = allTitles[index + 1]
            right.lgfpt_X = title.lgfpt_X + title.lgfpt_Width
        }
    }
    style.lgf_PVTitleView.lgf_AutoSwiftPTContentSize()
}

// MARK: ------------------- 我自己原配分页动画(你可以参考我的来实现独一无二的自定义，当然你可以在我的GitHub首页把这些珍贵的代码分享给大家)
public func lgf_FreePageViewTopToBottomAnimationConfig(_ attributes: [UICollectionViewLayoutAttributes], _ flowLayout: UICollectionViewFlowLayout) {
    let contentOffsetX = flowLayout.collectionView!.contentOffset.x
    let collectionViewCenterX = flowLayout.collectionView!.lgfpt_Width * 0.5
    attributes.forEach { (attr) in
        let alpha = abs(1.0 - abs(attr.center.x - contentOffsetX - collectionViewCenterX) / flowLayout.collectionView!.lgfpt_Width)
        let scale = -abs(abs(attr.center.x - contentOffsetX - collectionViewCenterX) / flowLayout.collectionView!.lgfpt_Width) * 50.0
        let index = abs(flowLayout.collectionView!.contentOffset.x / flowLayout.collectionView!.lgfpt_Width)
        if flowLayout.collectionView!.panGestureRecognizer.translation(in: flowLayout.collectionView!).x < 0.0 {
            if (attr.indexPath.item != Int(index)) {
                attr.alpha = alpha
            }
        } else {
            if (attr.indexPath.item == Int(index)) {
                attr.alpha = alpha
            }
        }
        attr.transform = CGAffineTransform.init(translationX: 0.0, y: scale)
    }
}

public func lgf_FreePageViewSmallToBigAnimationConfig(_ attributes: [UICollectionViewLayoutAttributes], _ flowLayout: UICollectionViewFlowLayout) {
    let contentOffsetX = flowLayout.collectionView!.contentOffset.x
    let collectionViewCenterX = flowLayout.collectionView!.lgfpt_Width * 0.5
    attributes.forEach { (attr) in
        let scale = (1.0 - abs(attr.center.x - contentOffsetX - collectionViewCenterX) / flowLayout.collectionView!.lgfpt_Width * 0.8)
        attr.transform = CGAffineTransform.init(scaleX: scale, y: scale)
    }
}

// MARK: ------------------- 部分项目内扩展
public extension String {
    func lgfpt_Width(_ font: UIFont, _ height: CGFloat) -> CGFloat {
        return self.lgfpt_TextSizeWithFont(font: font, constrainedToSize:CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: height)).width + 1.0
    }
    func lgfpt_Height(_ font: UIFont, _ width: CGFloat) -> CGFloat {
        return self.lgfpt_TextSizeWithFont(font: font, constrainedToSize:CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude)).height + 1.0
    }
    func lgfpt_TextSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        if size.equalTo(CGSize.zero) {
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            textSize = self.size(withAttributes: attributes as? [NSAttributedString.Key : Any])
        } else {
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            let stringRect = self.boundingRect(with: size, options: option, attributes: attributes as? [NSAttributedString.Key : Any], context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}

public extension UIColor {
    struct LGFPTComponents {
        var _base: UIColor
        public var rgba: (CGFloat, CGFloat, CGFloat, CGFloat) {
            var r: CGFloat = 0; var g: CGFloat = 0; var b: CGFloat = 0; var a: CGFloat = 0
            _base.getRed(&r, green: &g, blue: &b, alpha: &a)
            return (r, g, b, a)
        }
        public var hsv: (CGFloat, CGFloat, CGFloat) {
            var h: CGFloat = 0; var s: CGFloat = 0; var v: CGFloat = 0; var a: CGFloat = 0
            _base.getHue(&h, saturation: &s, brightness: &v, alpha: &a)
            return (h, s, v)
        }
    }
    var lgfpt_Components: UIColor.LGFPTComponents {
        return LGFPTComponents(_base: self)
    }
    class func lgfpt_RandomColor() -> UIColor {
        return UIColor.init(red: CGFloat(arc4random() % 256) / 255.0, green: CGFloat(arc4random() % 256) / 255.0, blue: CGFloat(arc4random() % 256) / 255.0, alpha: 0.5)
    }
}

public extension UIScrollView {
    // MARK: - 获取横向滚动index
    func lgfpt_HorizontalIndex() -> Int {
        return Int(self.contentOffset.x / self.bounds.size.width)
    }
}

private var lgfpt_SwiftPTSpecialTitlePropertyKey: String = "lgfpt_SwiftPTSpecialTitlePropertyKey"

public extension UIView {
    
    // MARK: - 用于特殊 title 赋值属性用
    var lgfpt_SwiftPTSpecialTitleProperty: String? {
        get {
            return (objc_getAssociatedObject(self, &lgfpt_SwiftPTSpecialTitlePropertyKey) as? String)
        }
        set {
            objc_setAssociatedObject(self, &lgfpt_SwiftPTSpecialTitlePropertyKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    
    // MARK: - .x
    var lgfpt_X: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    // MARK: - .y
    var lgfpt_Y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    // MARK: - .maxX
    var lgfpt_MaxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    // MARK: - .maxY
    var lgfpt_MaxY: CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    // MARK: - .centerX
    var lgfpt_CenterX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    // MARK: - .centerY
    var lgfpt_CenterY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    // MARK: - .width
    var lgfpt_Width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    // MARK: - .height
    var lgfpt_Height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    
    // MARK: - .size
    var lgfpt_Size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var rect = self.frame
            rect.size = newValue
            self.frame = rect
        }
    }
}
