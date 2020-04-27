//
//  LGFSwiftPT.swift
//  LGFSwiftPT
//
//  Created by 来 on 2019/10/9.
//  Copyright © 2019 laiguofeng. All rights reserved.
//

import UIKit

@objc public protocol LGFSwiftPTDelegate: NSObjectProtocol {
    
    // MARK: - 标动画完全结束后的选中标回调代理
    /// - Parameter selectIndex: 选中下标
    @objc func lgf_SelectSwiftPTTitle(_ selectIndex: Int)
    
    // MARK: - 以 contentOffsetX 匹配最精确的选中标回调代理
    /// - Parameter selectIndex: 选中下标
    @objc optional func lgf_RealSelectSwiftPTTitle(_ selectIndex: Int)

    // MARK: - 加载网络图片代理，具体加载框架我的 Demo 不做约束，请自己选择图片加载框架，使用前请打开 lgf_IsNetImage
    /// - Parameters:
    ///   - imageView: 要加载网络图片的 imageView
    ///   - imageUrl: 网络图片的 Url
    @objc optional func lgf_GetNetImage(_ imageView: UIImageView, _ imageUrl: URL!)
    
    // MARK: - 实现这个代理来对 LGFSwiftPTTitle 初始化时某些系统属性进行配置 backgroundColor/borderColor/CornerRadius等等 注意：这些新配置如果和 LGFSwiftPTStyle 冲突将覆盖 LGFSwiftPTStyle 的效果
    /// - Parameters:
    ///   - lgf_SwiftPTTitle: LGFSwiftPTTitle 本体
    ///   - index: 所在的 index
    ///   - style: LGFSwiftPTStyle
    @objc optional func lgf_GetLGFSwiftPTTitle(_ lgf_SwiftPTTitle: UIView, _ index: Int, _ style: LGFSwiftPTStyle)
    
    // MARK: -  实现这个代理来对 LGFSwiftPTTitle 中的 centerLine 生成时某些系统属性进行配置 backgroundColor/borderColor/CornerRadius/isHidden等等 LGFSwiftPTStyle 中 lgf_IsHaveCenterLine 需要为true
    /// - Parameters:
    ///   - centerLine: centerLine 本体
    ///   - index: 所在的 index
    ///   - style: LGFSwiftPTStyle
    ///   - X: -(width / 2) 等同于 centerX
    ///   - Y: 等同于 centerY
    ///   - W: 等同于 width
    ///   - H: 等同于 height
    @objc optional func lgf_GetLGFSwiftPTCenterLine(_ centerLine: UIView, _ index: Int, _ style: LGFSwiftPTStyle, _ X: NSLayoutConstraint, _ Y: NSLayoutConstraint, _ W: NSLayoutConstraint, _ H: NSLayoutConstraint)
    
    // MARK: - 实现这个代理来对 LGFSwiftPTLine 初始化时某些系统属性进行配置 backgroundColor/borderColor/CornerRadius等等 注意：这些新配置如果和 LGFSwiftPTStyle 冲突将覆盖 LGFSwiftPTStyle 的效果
    /// - Parameters:
    ///   - lgf_SwiftPTLine: LGFSwiftPTLine 本体
    ///   - style: LGFSwiftPTStyle
    @objc optional func lgf_GetLGFSwiftPTLine(_ lgf_SwiftPTLine: UIImageView, _ style: LGFSwiftPTStyle)
    
    // MARK: - 实现这个代理来对所有标的滚动动效状态进行配置（为了某些标队列特殊物理效果的需求）（注意：实现这个代理后我的默认效果将无效）
    /// - Parameters:
    ///   - allTitles: 所有标数组
    ///   - style: LGFSwiftPTStyle
    ///   - selectTitle: 选中标本体
    ///   - unSelectTitle: 未选中标本体
    ///   - selectIndex: 选中 index
    ///   - unSelectIndex: 未选中 index
    ///   - progress: 进度参数(运行项目可查看 progress 改变的 log 输出 然后自行设计)
    @objc optional func lgf_SetAllTitleState(_ allTitles: [LGFSwiftPTTitle], _ style: LGFSwiftPTStyle, _ selectTitle: LGFSwiftPTTitle, _ unSelectTitle: LGFSwiftPTTitle, _ selectIndex: Int, _ unSelectIndex: Int, _ progress: CGFloat)
    
    // MARK: - 实现这个代理来对所有标的点击动效状态进行配置（为了某些标队列特殊物理效果的需求）（注意：实现这个代理后我的默认效果将无效）
    /// - Parameters:
    ///   - allTitles: 所有标数组
    ///   - style: LGFSwiftPTStyle
    ///   - selectTitle: 选中标本体
    ///   - unSelectTitle: 未选中标本体
    ///   - selectIndex: 选中 index
    ///   - unSelectIndex: 未选中 index
    ///   - progress: 进度参数(运行项目可查看 progress 改变的 log 输出 然后自行设计)
    @objc optional func lgf_SetAllTitleClickState(_ allTitles: [LGFSwiftPTTitle], _ style: LGFSwiftPTStyle, _ selectTitle: LGFSwiftPTTitle, _ unSelectTitle: LGFSwiftPTTitle, _ selectIndex: Int, _ unSelectIndex: Int, _ progress: CGFloat)
    
    // MARK: - 如果我原配的动画满足不了你，那么请使用这个自定义 line 动画代理（自定义配置滚动后 line 的动画）
    /// - Parameters:
    ///   - style: LGFSwiftPTStyle
    ///   - selectX: 选中标的 X
    ///   - selectWidth: 选中标的 Width
    ///   - unSelectX: 未选中标的 X
    ///   - unSelectWidth: 未选中标的 Width
    ///   - unSelectTitle: 未选中标本体
    ///   - selectTitle: 选中标本体
    ///   - unSelectIndex: 未选中 index
    ///   - selectIndex: 选中 index
    ///   - line: 本体
    ///   - progress: 进度参数(运行项目可查看 progress 改变的 log 输出 然后自行设计动画吧)
    @objc optional func lgf_SwiftPTViewCustomizeScrollLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ progress: CGFloat)
    
    // MARK: - 自定义配置点击后 line 的动画
    /// - Parameters:
    ///   - style: LGFSwiftPTStyle
    ///   - selectX: 选中标的 X
    ///   - selectWidth: 选中标的 Width
    ///   - unSelectX: 未选中标的 X
    ///   - unSelectWidth: 未选中标的 Width
    ///   - unSelectTitle: 未选中标本体
    ///   - selectTitle: 选中标本体
    ///   - unSelectIndex: 未选中 index
    ///   - selectIndex: 选中 index
    ///   - line: line 本体
    ///   - duration: 点击动画时长
    @objc optional func lgf_SwiftPTViewCustomizeClickLineAnimationConfig(_ style: LGFSwiftPTStyle, _ selectX: CGFloat, _ selectWidth: CGFloat, _ unSelectX: CGFloat, _ unSelectWidth: CGFloat, _ unSelectTitle: LGFSwiftPTTitle, _ selectTitle: LGFSwiftPTTitle, _ unSelectIndex: Int, _ selectIndex: Int, _ line: LGFSwiftPTLine, _ duration: TimeInterval)
    
    // MARK: - 自定义配置选中结束后标的回位模式
    /// - Parameters:
    ///   - style: LGFSwiftPTStyle
    ///   - lgf_TitleButtons: 所有标数组
    ///   - unSelectIndex: 未选中 index
    ///   - selectIndex: 选中 index
    ///   - duration: 回位动画时长
    @objc optional func lgf_TitleScrollFollowCustomizeAnimationConfig(_ style: LGFSwiftPTStyle, _ lgf_TitleButtons: [LGFSwiftPTTitle], _ unSelectIndex: Int, _ selectIndex: Int, _ duration: TimeInterval)
    
    // MARK: - 自定义分页动画（我这里提供一个配置入口，也可以自己在外面配置 UICollectionViewFlowLayout 原理一样，自己在外面配置的话记得配置 self.scrollDirection = .horizontal self.minimumInteritemSpacing = 0 self.minimumLineSpacing = 0 self.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)）
    /// - Parameters:
    ///   - attributes: UICollectionViewLayoutAttributes
    ///   - flowLayout: UICollectionViewFlowLayout
    @objc optional func lgf_FreePageViewCustomizeAnimationConfig(_ attributes: [UICollectionViewLayoutAttributes], _ flowLayout: UICollectionViewFlowLayout)
}

public class LGFSwiftPT: UIScrollView {
    
    /// LGFSwiftPT 主代理
    public weak var lgf_SwiftPTDelegate: LGFSwiftPTDelegate?
    /// 父控件
    public private(set) weak var lgf_SVC: UIViewController?
    /// line
    public private(set) var lgf_TitleLine: LGFSwiftPTLine!
    /// style
    public private(set) var lgf_Style: LGFSwiftPTStyle!
    /// 所有标堆
    public private(set) lazy var lgf_TitleButtons: [LGFSwiftPTTitle] = []
    /// 选中的下标
    public private(set) var lgf_SelectIndex: Int = 0
    /// 前一个变成未选中的下标
    public private(set) var lgf_UnSelectIndex: Int = 0
    /// 外部分页控制器
    public private(set) var lgf_PageView: UICollectionView!
    /// 最准确的选中标值
    public private(set) var lgf_RealSelectIndex: Int = 0
    /// 手势控制
    public private(set) var lgf_SwiftPTViewEnabled: Bool! {
        didSet {
            lgf_SetViewEnabled(lgf_SwiftPTViewEnabled, self)
        }
    }
    /// 操作中是否禁用手势
    public private(set) var lgf_PageViewEnabled: Bool! {
        didSet {
            lgf_SetViewEnabled(lgf_PageViewEnabled, lgf_PageView)
        }
    }
    
    // MARK: - 初始化配置
    /// - Parameters:
    ///   - style: LGFSwiftPTStyle
    ///   - SVC: 父控制器
    ///   - SV: 父控件
    ///   - PV: 分页父控件
    public class func lgf(_ style: LGFSwiftPTStyle, _ SVC: UIViewController?, _ SV: UIView!, _ PV: UICollectionView!) -> LGFSwiftPT {
        return lgf(style, SVC, SV, PV, .zero)
    }
    
    // MARK: - 初始化配置(纯代码)
    /// - Parameters:
    ///   - style: LGFSwiftPTStyle
    ///   - SVC: 父控制器
    ///   - PV: 父控件
    ///   - frame: frame CGRect
    public class func lgf(_ style: LGFSwiftPTStyle, _ SVC: UIViewController?, _ PV: UICollectionView!, _ frame: CGRect) -> LGFSwiftPT {
        return lgf(style, SVC, nil, PV, frame)
    }
    public class func lgf(_ style: LGFSwiftPTStyle, _ SVC: UIViewController?, _ SV: UIView!, _ PV: UICollectionView!, _ frame: CGRect) -> LGFSwiftPT {
        assert(style.lgf_UnSelectImageNames.count == style.lgf_SelectImageNames.count, "🤖️:选中图片数组和未选中图片数组count必须一致")
        let SwiftPT = LGFPTBundle.loadNibNamed(String(describing: LGFSwiftPT.self.classForCoder()), owner: self, options: nil)?.first as! LGFSwiftPT
        SwiftPT.lgf_Style = style
        SwiftPT.lgf_PageView = PV
        SwiftPT.lgf_SVC = SVC
        SwiftPT.lgf_Style.lgf_PVTitleView = SwiftPT
        // 部分基础 UI 配置
        SwiftPT.backgroundColor = SwiftPT.lgf_Style.lgf_PVTitleViewBackgroundColor
        if #available(iOS 11.0, *) {
            if SwiftPT.lgf_PageView != nil {
                SwiftPT.lgf_PageView.contentInsetAdjustmentBehavior = .never
            }
        } else {
            SwiftPT.lgf_SVC!.automaticallyAdjustsScrollViewInsets = false
        }
        if SV != nil {
            SV.addSubview(SwiftPT)
        }
        
        DispatchQueue.main.async {
            if SwiftPT.lgf_PageView != nil {
                SwiftPT.lgf_PageViewConfig()
            }
            // 是否有固定 Frame
            if SwiftPT.lgf_Style.lgf_PVTitleViewFrame == .zero {
                if frame == .zero {
                    SwiftPT.frame = SwiftPT.superview?.bounds ?? .zero
                } else {
                    SwiftPT.frame = frame
                }
            } else {
                SwiftPT.frame = SwiftPT.lgf_Style.lgf_PVTitleViewFrame
            }
        }
        return SwiftPT
    }
    
    // MARK: - 刷新所有标
    /// - Parameters:
    ///   - selectIndex: 刷新后要选中的 title
    ///   - isExecutionDelegate: 是否开启代理监控
    ///   - isReloadPageCV: 是否刷新 lgf_PageView
    ///   - animated: 是否带动画
    public func lgf_ReloadTitle() {
        lgf_ReloadTitleAndSelectIndex(0, false)
    }
    public func lgf_ReloadTitleAndSelectIndex(_ selectIndex: Int, _ animated: Bool) {
        lgf_ReloadTitleAndSelectIndex(selectIndex, true, animated)
    }
    public func lgf_ReloadTitleAndSelectIndex(_ selectIndex: Int, _ isExecutionDelegate: Bool, _ animated: Bool) {
        lgf_ReloadTitleAndSelectIndex(selectIndex, isExecutionDelegate, true, animated)
    }
    public func lgf_ReloadTitleAndSelectIndex(_ selectIndex: Int, _ isExecutionDelegate: Bool, _ isReloadPageCV: Bool, _ animated: Bool) {
        if lgf_Style.lgf_Titles.count == 0 { return }
        if lgf_PageView != nil {
            assert(lgf_Style.lgf_Titles.count == lgf_PageView.dataSource?.collectionView(lgf_PageView, numberOfItemsInSection: 0), "🤖️:如果关联 lgf_PageView 外部子控制器/ cell 数量必须和 lgf_Titles 标数量保持一致，如果不关联 lgf_PageView 请传 nil")
            if isReloadPageCV {
                lgf_PageView.reloadData()
            }
        }
        assert((selectIndex <= (lgf_Style.lgf_Titles.count - 1)) && (selectIndex >= 0), "🤖️:lgf_ReloadTitleAndSelectIndex -> selectIndex 导致数组越界了")
        // 删除一遍所有子控件
        lgf_RemoveAllSubViews()
        DispatchQueue.main.async {
            // 初始化选中值
            self.lgf_AutoSelectIndex(selectIndex)
            // 添加标
            self.lgf_AddTitles()
            // 添加底部滚动线
            self.lgf_AddLine()
            // 默认选中
            self.setNeedsLayout()
            self.layoutIfNeeded()
            self.lgf_AdjustUIWhenBtnOnClickExecutionDelegate(isExecutionDelegate, animated ? self.lgf_Style.lgf_TitleClickAnimationDuration : 0.0, self.lgf_Style.lgf_TitleScrollToTheMiddleAnimationDuration)
        }
    }
    
    // MARK: - 手动选中某个标（如果关联外部 CV 外部 CV 请手动滚动）
    /// - Parameters:
    ///   - index: 要选中的 title
    ///   - isExecutionDelegate: 是否开启代理监控
    ///   - isReloadPageCV: 是否刷新 lgf_PageView
    ///   - duration: 动画时间
    ///   - autoScrollDuration: 滚动动画时间
    ///   - animated: 是否带动画
    public func lgf_SelectIndex(_ index: Int) {
        lgf_SelectIndex(index, false)
    }
    public func lgf_SelectIndex(_ index: Int, _ isExecutionDelegate: Bool) {
        lgf_SelectIndex(index, lgf_Style.lgf_TitleClickAnimationDuration, lgf_Style.lgf_TitleScrollToTheMiddleAnimationDuration, isExecutionDelegate)
    }
    public func lgf_SelectIndex(_ index: Int, _ duration: TimeInterval, _ autoScrollDuration: TimeInterval) {
        lgf_SelectIndex(index, duration, autoScrollDuration, false)
    }
    public func lgf_SelectIndex(_ index: Int, _ duration: TimeInterval, _ autoScrollDuration: TimeInterval, _ isExecutionDelegate: Bool) {
        assert((index <= (lgf_Style.lgf_Titles.count - 1)) && (index >= 0), "🤖️:lgf_ReloadTitleAndSelectIndex -> selectIndex 导致数组越界了")
        DispatchQueue.main.async {
            // 初始化选中值
            self.lgf_AutoSelectIndex(index)
            // 默认选中
            self.lgf_AdjustUIWhenBtnOnClickExecutionDelegate(isExecutionDelegate, duration, autoScrollDuration)
        }
    }
    
    // MARK: - 添加标
    private func lgf_AddTitles() {
        for (index, value) in lgf_Style.lgf_Titles.enumerated() {
            let title = LGFSwiftPTTitle.lgf_AllocTitle(value, index, lgf_Style, self)
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(lgf_TitleClick(_:)))
            tap.cancelsTouchesInView = false
            title.addGestureRecognizer(tap)
            lgf_TitleButtons.append(title)
        }
        // 标view 滚动区域配置
        lgf_AutoSwiftPTContentSize()
        // 设置标总长度小于 LGFSwiftPT 宽度的情况下是否居中
        if lgf_Style.lgf_IsTitleCenter {
            if contentSize.width < lgfpt_Width {
                lgfpt_X = (lgfpt_Width - contentSize.width) / 2.0
            } else {
                lgfpt_X = 0.0
            }
        }
    }
    
    // MARK: - 添加底部线
    private func lgf_AddLine() {
        if lgf_Style.lgf_IsShowLine {
            lgf_TitleLine = LGFSwiftPTLine.lgf_AllocLine(lgf_Style, self)
            addSubview(lgf_TitleLine)
            sendSubviewToBack(lgf_TitleLine)
        }
    }
    
    // MARK: - 配置 lgf_PageView
    private func lgf_PageViewConfig() {
        if lgf_PageView != nil {
            let layout = LGFSwiftPTFlowLayout()
            layout.lgf_PVAnimationType = lgf_Style.lgf_PVAnimationType
            layout.lgf_SwiftPTFlowLayoutDelegate = self
            lgf_PageView.collectionViewLayout = layout
            lgf_PageView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
            lgf_PageView.isPagingEnabled = true
            lgf_PageView.scrollsToTop = false
            lgf_PageView.tag = 333333// 用来解决侧滑返回手势冲突
        }
    }
    
    // MARK: - 自动计算 contentSize
    public func lgf_AutoSwiftPTContentSize() {
        var contentWidth: CGFloat = 0.0
        lgf_TitleButtons.forEach { contentWidth += $0.lgfpt_Width }
        contentSize = CGSize.init(width: contentWidth, height: -lgfpt_Height)
    }
    
    // MARK: - 删除所有子控件
    public func lgf_RemoveAllSubViews() {
        subviews.forEach { $0.removeFromSuperview() }
        lgf_TitleButtons.removeAll()
    }
    
    deinit {
        lgf_RemoveAllSubViews()
        if lgf_PageView != nil {
            lgf_PageView.removeObserver(self, forKeyPath: "contentOffset")
        }
        lgf_Style = nil
        lgf_SVC?.children.forEach {
            $0.willMove(toParent: lgf_SVC)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        removeFromSuperview()
        debugPrint("🤖️:分页控件 LGFSwiftPT --- 已经释放完毕 ✈️")
    }
}

// MARK: - 标点击
extension LGFSwiftPT {
    // MARK: - 标点击事件 滚动到指定tag位置
    @objc private func lgf_TitleClick(_ sender: UITapGestureRecognizer) {
        if !lgf_AutoSelectIndex(sender.view!.tag) {
            return
        }
        lgf_AdjustUIWhenBtnOnClickExecutionDelegate(true, lgf_Style.lgf_TitleClickAnimationDuration, lgf_Style.lgf_TitleScrollToTheMiddleAnimationDuration)
        // 获取精确 lgf_RealSelectIndex
        lgf_RealSelectIndex = lgf_SelectIndex
        lgf_SwiftPTDelegate?.lgf_RealSelectSwiftPTTitle?(lgf_RealSelectIndex)
    }
    
    // MARK: - 更新标view的UI(用于点击标的时候)
    private func lgf_AdjustUIWhenBtnOnClickExecutionDelegate(_ isExecution: Bool, _ duration: TimeInterval, _ autoScrollDuration: TimeInterval) {
        lgf_PageViewEnabled = false
        // 外部分页控制器 滚动到对应下标
        if lgf_PageView != nil {
            lgf_PageView.contentOffset = CGPoint.init(x: lgf_PageView.lgfpt_Width * CGFloat(lgf_SelectIndex), y: 0.0)
        }
        // 取得 前一个选中的标 和 将要选中的标
        let unSelectTitle = lgf_TitleButtons[lgf_UnSelectIndex]
        let selectTitle = lgf_TitleButtons[lgf_SelectIndex]
        // 动画时间
        let animatedDuration = lgf_Style.lgf_TitleHaveAnimation ? duration : 0.0
        UIView.animateKeyframes(withDuration: animatedDuration, delay: 0.0, options: .calculationModeLinear, animations: {
            // 标整体状态改变
            unSelectTitle.lgf_SetMainTitleTransform(1.0, false, self.lgf_SelectIndex, self.lgf_UnSelectIndex)
            selectTitle.lgf_SetMainTitleTransform(1.0, true, self.lgf_SelectIndex, self.lgf_UnSelectIndex)
            if self.lgf_Style.lgf_IsZoomExtruding {
                lgf_ZoomExtruding(self.lgf_TitleButtons, self.lgf_Style, selectTitle, unSelectTitle, self.lgf_SelectIndex, self.lgf_UnSelectIndex, 1.0)
            }
            if self.lgf_SwiftPTDelegate?.responds(to: #selector(self.lgf_SwiftPTDelegate!.lgf_SetAllTitleClickState(_:_:_:_:_:_:_:))) ?? false {
                self.lgf_SwiftPTDelegate?.lgf_SetAllTitleClickState?(self.lgf_TitleButtons, self.lgf_Style, selectTitle, unSelectTitle, self.lgf_SelectIndex, self.lgf_UnSelectIndex, 1.0)
            }
            
            let (selectX, selectWidth, unSelectX, unSelectWidth) = self.lgf_GetXAndW(selectTitle, unSelectTitle)
            // LGFSwiftPTMethod 类里是所有我已经实现的动画代码，也希望你们使用我的代理来自定义自己的动画，如果可以能够结合 LGFSwiftPTStyle 分享给大家那是极好的（我的动画代码不一定是最精简的，效果也不一定是最惊艳的～）
            if (self.lgf_TitleLine != nil) && self.lgf_Style.lgf_IsShowLine {
                if self.lgf_Style.lgf_LineAnimation == .customize {
                    self.lgf_SwiftPTDelegate?.lgf_SwiftPTViewCustomizeClickLineAnimationConfig?(self.lgf_Style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, self.lgf_UnSelectIndex, self.lgf_SelectIndex, self.lgf_TitleLine, animatedDuration)
                } else {
                    lgf_AutoClickLineAnimationConfig(self.lgf_Style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, self.lgf_UnSelectIndex, self.lgf_SelectIndex, self.lgf_TitleLine, duration)
                }
            }
        }) { (finish) in
            self.lgf_TitleAutoScrollToTheMiddleExecutionDelegate(isExecution, autoScrollDuration)
            self.lgf_PageViewEnabled = true
        }
    }
}

// MARK: - 外层分页控制器滚动
extension LGFSwiftPT {
    // MARK: - 外层分页控制器 contentOffset 转化
    private func lgf_ConvertToProgress(_ contentOffsetX: CGFloat) {
        let selectProgress = contentOffsetX / lgf_PageView.lgfpt_Width
        var progress = selectProgress - floor(selectProgress)
        var selectIndex: CGFloat = 0.0
        var unSelectIndex: CGFloat = 0.0
        if contentOffsetX >= (lgf_PageView.contentSize.width - lgf_PageView.lgfpt_Width) {
            progress = 1.0
            unSelectIndex = selectProgress - 1.0
            selectIndex = selectProgress
        } else {
            selectIndex = selectProgress + 1.0
            unSelectIndex = selectProgress
        }
        // 获取精确 lgf_RealSelectIndex
        if lgf_RealSelectIndex != Int(roundf(Float(selectProgress))) {
            lgf_RealSelectIndex = Int(roundf(Float(selectProgress)))
            // 精确跟随
            if lgf_Style.lgf_IsExecutedImmediatelyTitleScrollFollow {
                lgf_AutoScrollTitle(lgf_RealSelectIndex)
            }
            lgf_SwiftPTDelegate?.lgf_RealSelectSwiftPTTitle?(lgf_RealSelectIndex)
        }
        lgf_AdjustUIWithProgress(progress, Int(unSelectIndex), Int(selectIndex))
    }
    
    // MARK: - 更新标view的UI(用于滚动外部分页控制器的时候)
    private func lgf_AdjustUIWithProgress(_ progress: CGFloat, _ unSelectIndex: Int, _ selectIndex: Int) {
        // 取得 前一个选中的标 和将要选中的标
        let unSelectTitle = lgf_TitleButtons[unSelectIndex]
        let selectTitle = lgf_TitleButtons[selectIndex]
        
        // 标整体状态改变
        unSelectTitle.lgf_SetMainTitleTransform(progress, false, selectIndex, unSelectIndex)
        selectTitle.lgf_SetMainTitleTransform(progress, true, selectIndex, unSelectIndex)
        if lgf_Style.lgf_IsZoomExtruding {
            lgf_ZoomExtruding(lgf_TitleButtons, lgf_Style, selectTitle, unSelectTitle, lgf_SelectIndex, lgf_UnSelectIndex, 1.0)
        }
        if lgf_SwiftPTDelegate?.responds(to: #selector(lgf_SwiftPTDelegate?.lgf_SetAllTitleState(_:_:_:_:_:_:_:))) ?? false {
            lgf_SwiftPTDelegate?.lgf_SetAllTitleState?(lgf_TitleButtons, lgf_Style, selectTitle, unSelectTitle, selectIndex, unSelectIndex, progress)
            if lgf_Style.lgf_ShowPrint {
                debugPrint(String.init(format: "🤖️:自定义标动效状态 progress:%f", progress))
            }
        }
        
        // 标底部滚动条 更新位置
        if (lgf_TitleLine != nil) && lgf_Style.lgf_IsShowLine {
            let (selectX, selectWidth, unSelectX, unSelectWidth) = lgf_GetXAndW(selectTitle, unSelectTitle)
            // LGFSwiftPTMethod 类里是所有我已经实现的动画代码，希望你们使用我的代理来自定义自己的动画，如果可以能够结合 LGFSwiftPTStyle 分享给大家那是极好的（我的动画代码不一定是最精简的，效果也不一定是最惊艳的～）
            if lgf_Style.lgf_LineAnimation == .customize {
                lgf_SwiftPTDelegate?.lgf_SwiftPTViewCustomizeScrollLineAnimationConfig?(lgf_Style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, lgf_TitleLine, progress)
                if lgf_Style.lgf_ShowPrint {
                    debugPrint(String.init(format: "🤖️:自定义 line 动画 progress:%f", progress))
                }
            } else {
                lgf_AutoScrollLineAnimationConfig(lgf_Style, selectX, selectWidth, unSelectX, unSelectWidth, unSelectTitle, selectTitle, unSelectIndex, selectIndex, lgf_TitleLine, progress)
            }
        }
    }
    
    // MARK: - KVO 监听 contentOffset
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            if lgf_PageView != nil {
                // 🤖️:setContentOffset 方法触发的不算数～😝
                if lgf_PageView.isTracking || lgf_PageView.isDragging || lgf_PageView.isDecelerating {
                    lgf_SwiftPTViewEnabled  = false
                    lgf_ConvertToProgress(lgf_PageView.contentOffset.x < 0.0 ? 0.0 : lgf_PageView.contentOffset.x)
                    if Int(lgf_PageView.contentOffset.x) % Int(lgf_PageView.lgfpt_Width) == 0 {
                        lgf_SwiftPTViewEnabled = true
                        if !lgf_Style.lgf_IsExecutedImmediatelyTitleScrollFollow {
                            lgf_AutoScrollTitle(lgf_PageView.lgfpt_HorizontalIndex())
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - 标自动滚动
    private func lgf_AutoScrollTitle(_ selectIndex: Int) {
        if !lgf_AutoSelectIndex(selectIndex) {
            return
        }
        lgf_TitleAutoScrollToTheMiddleExecutionDelegate(true, lgf_Style.lgf_TitleScrollToTheMiddleAnimationDuration)
    }
}

// MARK: - 标回位
extension LGFSwiftPT {
    // MARK: - 调整title位置 使其滚动到中间
    private func lgf_TitleAutoScrollToTheMiddleExecutionDelegate(_ isExecution: Bool, _ autoScrollDuration: TimeInterval) {
        if lgf_SelectIndex > lgf_TitleButtons.count - 1 || lgf_TitleButtons.count == 0 {
            return
        }
        // LGFSwiftPTMethod 类里是所有我已经实现的动画代码，希望你们使用我的代理来自定义自己的动画，如果可以能够结合 LGFSwiftPTStyle 分享给大家那是极好的（我的动画代码不一定是最精简的，效果也不一定是最惊艳的～）
        if !(contentSize.width < lgfpt_Width) {
            if lgf_Style.lgf_TitleScrollFollowType == .customize {
                lgf_SwiftPTDelegate?.lgf_TitleScrollFollowCustomizeAnimationConfig?(lgf_Style, lgf_TitleButtons, lgf_UnSelectIndex, lgf_SelectIndex, autoScrollDuration)
                if lgf_Style.lgf_ShowPrint {
                    debugPrint(String.init(format: "🤖️:自定义回位动画的 contentOffset.x:%f", contentOffset.x))
                }
            } else {
                lgf_AutoTitleScrollFollowAnimationConfig(lgf_Style, lgf_TitleButtons, lgf_UnSelectIndex, lgf_SelectIndex, autoScrollDuration)
            }
        }
        if isExecution {
            debugPrint(String.init(format: "🤖️:当前选中:%@(%tu),当前未选中:%@(%tu)", lgf_Style.lgf_Titles[lgf_SelectIndex], lgf_SelectIndex,  lgf_Style.lgf_Titles[lgf_SelectIndex], lgf_UnSelectIndex))
            lgf_SwiftPTDelegate?.lgf_SelectSwiftPTTitle(lgf_SelectIndex)
        }
    }
}

// MARK: - 核心逻辑
extension LGFSwiftPT {
    // MARK: - 取得要改变的 X 和 Width 核心逻辑部分(注意：根据 lgf_LineWidthType 的类型，返回的结果会不一样)
    private func lgf_GetXAndW(_ selectTitle: LGFSwiftPTTitle, _ unSelectTitle: LGFSwiftPTTitle) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        var selectX: CGFloat = 0.0
        var selectWidth: CGFloat = 0.0
        var unSelectX: CGFloat = 0.0
        var unSelectWidth: CGFloat = 0.0
        switch lgf_Style.lgf_LineWidthType {
        case .equalTitle:
            selectX = selectTitle.lgfpt_X + lgf_Style.lgf_LineCenterX
            selectWidth = selectTitle.lgfpt_Width
            unSelectX = unSelectTitle.lgfpt_X + lgf_Style.lgf_LineCenterX
            unSelectWidth = unSelectTitle.lgfpt_Width
            break
        case .equalTitleSTRAndImage:
            selectX = (selectTitle.lgfpt_X + lgf_Style.lgf_LineCenterX + selectTitle.lgf_LeftImage.lgfpt_X * selectTitle.lgf_CurrentTransformSX)
            selectWidth = (selectTitle.lgf_RightImage.lgfpt_X + selectTitle.lgf_RightImage.lgfpt_Width - selectTitle.lgf_LeftImage.lgfpt_X) * selectTitle.lgf_CurrentTransformSX
            unSelectX = (unSelectTitle.lgfpt_X + lgf_Style.lgf_LineCenterX + unSelectTitle.lgf_LeftImage.lgfpt_X * unSelectTitle.lgf_CurrentTransformSX)
            unSelectWidth = (unSelectTitle.lgf_RightImage.lgfpt_X + unSelectTitle.lgf_RightImage.lgfpt_Width - unSelectTitle.lgf_LeftImage.lgfpt_X) * unSelectTitle.lgf_CurrentTransformSX
            break
        case .equalTitleSTR:
            selectX = selectTitle.lgfpt_X + lgf_Style.lgf_LineCenterX + (lgf_Style.lgf_IsLineAlignSubTitle ? selectTitle.lgf_SubTitle.lgfpt_X : selectTitle.lgf_Title.lgfpt_X) * selectTitle.lgf_CurrentTransformSX
            selectWidth = (lgf_Style.lgf_IsLineAlignSubTitle ? selectTitle.lgf_SubTitle.lgfpt_Width : selectTitle.lgf_Title.lgfpt_Width) * selectTitle.lgf_CurrentTransformSX
            unSelectX = unSelectTitle.lgfpt_X + lgf_Style.lgf_LineCenterX + (lgf_Style.lgf_IsLineAlignSubTitle ? unSelectTitle.lgf_SubTitle.lgfpt_X : unSelectTitle.lgf_Title.lgfpt_X) * unSelectTitle.lgf_CurrentTransformSX
            unSelectWidth = (lgf_Style.lgf_IsLineAlignSubTitle ? unSelectTitle.lgf_SubTitle.lgfpt_Width : unSelectTitle.lgf_Title.lgfpt_Width) * unSelectTitle.lgf_CurrentTransformSX
            break
        case .fixedWith:
            selectX = selectTitle.lgfpt_X + lgf_Style.lgf_LineCenterX + (selectTitle.lgfpt_Width - lgf_Style.lgf_LineWidth) / 2.0
            selectWidth = lgf_Style.lgf_LineWidth
            unSelectX = unSelectTitle.lgfpt_X + lgf_Style.lgf_LineCenterX + (unSelectTitle.lgfpt_Width - lgf_Style.lgf_LineWidth) / 2.0
            unSelectWidth = lgf_Style.lgf_LineWidth
            break
        }
        return (selectX, selectWidth, unSelectX, unSelectWidth)
    }
    
    // MARK: - 自动 selectIndex 转换
    @discardableResult
    private func lgf_AutoSelectIndex(_ selectIndex: Int) -> Bool {
        if lgf_SelectIndex == selectIndex {
            return false
        }
        lgf_UnSelectIndex = lgf_SelectIndex
        lgf_SelectIndex = selectIndex
        return true
    }
    
    // MARK: - 手势是否禁用
    private func lgf_SetViewEnabled(_ enabled: Bool, _ sview: UIScrollView?) {
        if enabled {
            sview?.isScrollEnabled = ((lgf_Style.lgf_PVAnimationType == .none) && (sview == lgf_PageView)) ? false : true
            sview?.isUserInteractionEnabled = true
        } else {
            sview?.isScrollEnabled = false
            sview?.isUserInteractionEnabled = false
        }
    }
}

// MARK: - 部分功能性代理
extension LGFSwiftPT: LGFSwiftPTLineDelegate {
    public func lgf_GetLineNetImage(_ imageView: UIImageView, _ imageUrl: URL!) {
        lgf_SwiftPTDelegate?.lgf_GetNetImage?(imageView, imageUrl)
    }
    public func lgf_GetLine(_ lgf_SwiftPTLine: UIImageView, _ style: LGFSwiftPTStyle) {
        lgf_SwiftPTDelegate?.lgf_GetLGFSwiftPTLine?(lgf_SwiftPTLine, style)
    }
}

extension LGFSwiftPT: LGFSwiftPTTitleDelegate {
    public func lgf_GetTitleNetImage(_ imageView: UIImageView, _ imageUrl: URL!) {
        lgf_SwiftPTDelegate?.lgf_GetNetImage?(imageView, imageUrl)
    }
    public func lgf_GetTitle(_ lgf_SwiftPTTitle: UIView, _ index: Int, _ style: LGFSwiftPTStyle) {
        lgf_SwiftPTDelegate?.lgf_GetLGFSwiftPTTitle?(lgf_SwiftPTTitle, index, style)
    }
    public func lgf_GetCenterLine(_ centerLine: UIView, _ index: Int, _ style: LGFSwiftPTStyle, _ X: NSLayoutConstraint, _ Y: NSLayoutConstraint, _ W: NSLayoutConstraint, _ H: NSLayoutConstraint) {
        lgf_SwiftPTDelegate?.lgf_GetLGFSwiftPTCenterLine?(centerLine, index, style, X, Y, W, H)
    }
}

extension LGFSwiftPT: LGFSwiftPTFlowLayoutDelegate {
    public func lgf_FreePageViewCustomizeAnimation(_ attributes: [UICollectionViewLayoutAttributes], _ flowLayout: UICollectionViewFlowLayout) {
        lgf_SwiftPTDelegate?.lgf_FreePageViewCustomizeAnimationConfig?(attributes, flowLayout)
    }
}
