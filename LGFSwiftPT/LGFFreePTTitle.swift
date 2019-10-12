//
//  LGFFreePTTitle.swift
//  LGFSwiftPT
//
//  Created by 来 on 2019/10/9.
//  Copyright © 2019 laiguofeng. All rights reserved.
//

import UIKit

protocol LGFFreePTTitleDelegate: NSObjectProtocol {
    // MARK: - 加载 title 网络图片代理，具体加载框架我的 Demo 不做约束，请自己选择图片加载框架，使用前请打开 lgf_IsNetImage
    /**
     imageView 要加载网络图片的 imageView
     imageUrl 网络图片的 Url
     */
    func lgf_GetTitleNetImage(_ imageView: UIImageView, _ imageUrl: URL!)
    // MARK: - 实现这个代理来对 LGFFreePTTitle 生成时某些系统属性进行配置 backgroundColor/borderColor/CornerRadius等等
    /**
     lgf_FreePTTitle LGFFreePTTitle 本体
     index 所在的 index
     style LGFFreePTStyle
     */
    func lgf_GetTitle(_ lgf_FreePTTitle: UIView, _ index: Int, _ style: LGFFreePTStyle)
}

class LGFFreePTTitle: UIView {
    
    weak var lgf_FreePTTitleDelegate: LGFFreePTTitleDelegate?
    
    @IBOutlet weak var lgf_Title: UILabel!// 标
    @IBOutlet weak var lgf_SubTitle: UILabel!// 子标
    @IBOutlet weak var lgf_TitleWidth: NSLayoutConstraint!// 标宽度
    @IBOutlet weak var lgf_TitleHeight: NSLayoutConstraint!// 标高度
    @IBOutlet weak var lgf_SubTitleTop: NSLayoutConstraint!// 子标相对于标距离
    @IBOutlet weak var lgf_SubTitleWidth: NSLayoutConstraint!// 标宽度
    @IBOutlet weak var lgf_SubTitleHeight: NSLayoutConstraint!// 子标高度（子标宽度暂时于标共享取两者MAX值）
    @IBOutlet weak var lgf_TitleCenterX: NSLayoutConstraint!// 标中心X
    @IBOutlet weak var lgf_TitleCenterY: NSLayoutConstraint!// 标中心Y
    
    @IBOutlet weak var lgf_TopImageSpace: NSLayoutConstraint!// 标上图片相对于标距离
    @IBOutlet weak var lgf_BottomImageSpace: NSLayoutConstraint!// 标下图片相对于标距离
    @IBOutlet weak var lgf_LeftImageSpace: NSLayoutConstraint!// 标左图片相对于标距离
    @IBOutlet weak var lgf_RightImageSpace: NSLayoutConstraint!// 标右图片相对于标距离
    
    @IBOutlet weak var lgf_TopImage: UIImageView!// 标上图片
    @IBOutlet weak var lgf_TopImageWidth: NSLayoutConstraint!// 标上图片宽度
    @IBOutlet weak var lgf_TopImageHeight: NSLayoutConstraint!// 标上图片高度
    
    @IBOutlet weak var lgf_BottomImage: UIImageView!// 标下图片
    @IBOutlet weak var lgf_BottomImageWidth: NSLayoutConstraint!// 标下图片宽度
    @IBOutlet weak var lgf_BottomImageHeight: NSLayoutConstraint!// 标下图片高度
    
    @IBOutlet weak var lgf_LeftImage: UIImageView!// 标左图片
    @IBOutlet weak var lgf_LeftImageWidth: NSLayoutConstraint!// 标左图片宽度
    @IBOutlet weak var lgf_LeftImageHeight: NSLayoutConstraint!// 标左图片高度
    
    @IBOutlet weak var lgf_RightImage: UIImageView!// 标右图片
    @IBOutlet weak var lgf_RightImageWidth: NSLayoutConstraint!// 标右图片宽度
    @IBOutlet weak var lgf_RightImageHeight: NSLayoutConstraint!// 标右图片高度
    
    lazy var lgf_SelectImageNames: [String] = []// 选中图片数组
    lazy var lgf_UnSelectImageNames: [String] = []// 未选中图片数组
    
    var lgf_IsHaveImage: Bool = false// 是否有标图片
    var lgf_CurrentTransformSX: CGFloat = 0.0// 放大缩小倍数
    var lgf_MainTitleCurrentTransformSX: CGFloat = 0.0// 主标题放大缩小倍数
    var lgf_MainTitleCurrentTransformTY: CGFloat = 0.0// 主标题上下位移
    var lgf_MainTitleCurrentTransformTX: CGFloat = 0.0// 主标题左右位移
    var lgf_SubTitleCurrentTransformSX: CGFloat = 0.0// 子标题放大缩小倍数
    var lgf_SubTitleCurrentTransformTY: CGFloat = 0.0// 子标题上下位移
    var lgf_SubTitleCurrentTransformTX: CGFloat = 0.0// 子标题左右位移
    // 标字体渐变色用数组
    lazy var lgf_SelectColorRGBA: [CGFloat] = {
        let (r, g, b, a) = lgf_Style.lgf_TitleSelectColor.lgfpt_Components.rgba
        let arr = [r, g, b, a]
        return arr
    }()
    lazy var lgf_UnSelectColorRGBA: [CGFloat] = {
        let (r, g, b, a) = lgf_Style.lgf_UnTitleSelectColor.lgfpt_Components.rgba
        let arr = [r, g, b, a]
        return arr
    }()
    lazy var lgf_DeltaRGBA: [CGFloat] = {
        let r = lgf_UnSelectColorRGBA[0] - lgf_SelectColorRGBA[0]
        let g = lgf_UnSelectColorRGBA[1] - lgf_SelectColorRGBA[1]
        let b = lgf_UnSelectColorRGBA[2] - lgf_SelectColorRGBA[2]
        let a = lgf_UnSelectColorRGBA[3] - lgf_SelectColorRGBA[3]
        let arr = [r, g, b, a]
        return arr
    }()
    lazy var lgf_SubSelectColorRGBA: [CGFloat] = {
        let (r, g, b, a) = lgf_Style.lgf_SubTitleSelectColor.lgfpt_Components.rgba
        let arr = [r, g, b, a]
        return arr
    }()
    lazy var lgf_SubUnSelectColorRGBA: [CGFloat] = {
        let (r, g, b, a) = lgf_Style.lgf_UnSubTitleSelectColor.lgfpt_Components.rgba
        let arr = [r, g, b, a]
        return arr
    }()
    lazy var lgf_SubDeltaRGBA: [CGFloat] = {
        let r = lgf_SubUnSelectColorRGBA[0] - lgf_SubSelectColorRGBA[0]
        let g = lgf_SubUnSelectColorRGBA[1] - lgf_SubSelectColorRGBA[1]
        let b = lgf_SubUnSelectColorRGBA[2] - lgf_SubSelectColorRGBA[2]
        let a = lgf_SubUnSelectColorRGBA[3] - lgf_SubSelectColorRGBA[3]
        let arr = [r, g, b, a]
        return arr
    }()
    
    weak var lgf_Style: LGFFreePTStyle! {// 配置用模型
        didSet {
            // 非主要属性配置
            if lgf_Style.lgf_TitleCornerRadius > 0.0 {
                layer.cornerRadius = lgf_Style.lgf_TitleCornerRadius
                if !clipsToBounds { clipsToBounds = true }
            }
            if lgf_Style.lgf_TitleBorderWidth > 0.0 {
                layer.borderWidth = lgf_Style.lgf_TitleBorderWidth
                layer.borderColor = lgf_Style.lgf_TitleBorderColor.cgColor
                if !clipsToBounds { clipsToBounds = true }
            }
            
            // 标 Label 配置
            lgf_Title.textColor = lgf_Style.lgf_UnTitleSelectColor
            lgf_Title.font = lgf_Style.lgf_UnTitleSelectFont
            lgf_Title.textAlignment = .center
            
            // 副标 Label 配置
            if (lgf_Style.lgf_IsDoubleTitle) {
                lgf_SubTitle.textColor = lgf_Style.lgf_UnSubTitleSelectColor
                lgf_SubTitle.font = lgf_Style.lgf_UnSubTitleSelectFont
                lgf_SubTitle.textAlignment = .center
            }
            
            // 如果设置了都是相同标图片, 那么就强制转成全部相同图片
            if lgf_Style.lgf_SameSelectImageName.count > 0 && lgf_Style.lgf_SameUnSelectImageName.count > 0 {
                lgf_Style.lgf_Titles.forEach {_ in
                    lgf_SelectImageNames.append(lgf_Style.lgf_SameSelectImageName)
                    lgf_UnSelectImageNames.append(lgf_Style.lgf_SameUnSelectImageName)
                }
                lgf_Style.lgf_SelectImageNames = lgf_SelectImageNames
                lgf_Style.lgf_UnSelectImageNames = lgf_UnSelectImageNames
            }
            
            // 是否需要显示标图片
            if (lgf_Style.lgf_SelectImageNames.count < lgf_Style.lgf_Titles.count) || (lgf_Style.lgf_UnSelectImageNames.count < lgf_Style.lgf_Titles.count) {
                lgf_IsHaveImage = false
                lgf_TopImage.isHidden = true
                lgf_BottomImage.isHidden = true
                lgf_LeftImage.isHidden = true
                lgf_RightImage.isHidden = true
                lgf_TopImageHeight.constant = 0.0
                lgf_BottomImageHeight.constant = 0.0
                lgf_LeftImageWidth.constant = 0.0
                lgf_RightImageWidth.constant = 0.0
                lgf_TopImageSpace.constant = 0.0
                lgf_BottomImageSpace.constant = 0.0
                lgf_LeftImageSpace.constant = 0.0
                lgf_RightImageSpace.constant = 0.0
                return
            }
            
            lgf_IsHaveImage = true
            
            // 只要有宽度，允许设置左图片
            if lgf_Style.lgf_LeftImageWidth > 0.0 {
                lgf_LeftImage.isHidden = false
                lgf_LeftImage.contentMode = lgf_Style.lgf_TitleImageContentMode
                lgf_LeftImageSpace.constant = lgf_Style.lgf_LeftImageSpace
                lgf_LeftImageWidth.constant = min(lgf_Style.lgf_LeftImageWidth, lgf_Style.lgf_PVTitleView.lgfpt_Height)
                lgf_LeftImageHeight.constant = min(lgf_Style.lgf_LeftImageHeight, lgf_Style.lgf_PVTitleView.lgfpt_Height)
                if (lgf_Style.lgf_IsNetImage) {
                    lgf_FreePTTitleDelegate?.lgf_GetTitleNetImage(lgf_LeftImage, URL.init(string: lgf_Style.lgf_UnSelectImageNames[tag]))
                } else {
                    lgf_LeftImage.image = UIImage.init(named: lgf_Style.lgf_UnSelectImageNames[tag], in: lgf_Style.lgf_ImageBundel, compatibleWith: nil)
                }
                lgf_TitleCenterX.constant = lgf_TitleCenterX.constant + (lgf_Style.lgf_LeftImageWidth / 2)
                if (lgf_Style.lgf_LeftImageSpace > 0.0) {
                    lgf_TitleCenterX.constant = lgf_TitleCenterX.constant + (lgf_Style.lgf_LeftImageSpace / 2)
                }
            } else {
                debugPrint("🤖️:如果要显示左边图标，请给 left_image_width 赋值")
            }
            
            // 只要有宽度，允许设置右图片
            if (lgf_Style.lgf_RightImageWidth > 0.0) {
                lgf_RightImage.isHidden = false
                lgf_RightImage.contentMode = lgf_Style.lgf_TitleImageContentMode
                lgf_RightImageSpace.constant = lgf_Style.lgf_RightImageSpace
                lgf_RightImageWidth.constant = min(lgf_Style.lgf_RightImageWidth, lgf_Style.lgf_PVTitleView.lgfpt_Height)
                lgf_RightImageHeight.constant = min(lgf_Style.lgf_RightImageHeight, lgf_Style.lgf_PVTitleView.lgfpt_Height)
                if (lgf_Style.lgf_IsNetImage) {
                    lgf_FreePTTitleDelegate?.lgf_GetTitleNetImage(lgf_RightImage, URL.init(string: lgf_Style.lgf_UnSelectImageNames[tag]))
                } else {
                    lgf_RightImage.image = UIImage.init(named: lgf_Style.lgf_UnSelectImageNames[tag], in: lgf_Style.lgf_ImageBundel, compatibleWith: nil)
                }
                lgf_TitleCenterX.constant = lgf_TitleCenterX.constant - (lgf_Style.lgf_RightImageWidth / 2.0)
                if (lgf_Style.lgf_RightImageSpace > 0.0) {
                    lgf_TitleCenterX.constant = lgf_TitleCenterX.constant - (lgf_Style.lgf_RightImageSpace / 2.0)
                }
            } else {
                debugPrint("🤖️:如果要显示右边图标，请给 right_image_width 赋值")
            }
            
            // 只要有高度，允许设置上图片
            if (lgf_Style.lgf_TopImageHeight > 0.0) {
                lgf_TopImage.isHidden = false
                lgf_TopImage.contentMode = lgf_Style.lgf_TitleImageContentMode
                lgf_TopImageSpace.constant = lgf_Style.lgf_TopImageSpace
                lgf_TopImageWidth.constant = min(lgf_Style.lgf_TopImageWidth, lgf_Style.lgf_PVTitleView.lgfpt_Width)
                lgf_TopImageHeight.constant = min(lgf_Style.lgf_TopImageHeight, lgf_Style.lgf_PVTitleView.lgfpt_Height)
                if (lgf_Style.lgf_IsNetImage) {
                    lgf_FreePTTitleDelegate?.lgf_GetTitleNetImage(lgf_TopImage, URL.init(string: lgf_Style.lgf_UnSelectImageNames[tag]))
                } else {
                    lgf_TopImage.image = UIImage.init(named: lgf_Style.lgf_UnSelectImageNames[tag], in: lgf_Style.lgf_ImageBundel, compatibleWith: nil)
                }
                lgf_TitleCenterY.constant = lgf_TitleCenterY.constant + (lgf_Style.lgf_TopImageHeight / 2.0)
                if (lgf_Style.lgf_TopImageSpace > 0.0) {
                    lgf_TitleCenterY.constant = lgf_TitleCenterY.constant + (lgf_Style.lgf_TopImageSpace / 2.0)
                }
            } else {
                debugPrint("🤖️:如果要显示顶部图标，请给 top_image_height 赋值")
            }
            
            // 只要有高度，允许设置下图片
            if (lgf_Style.lgf_BottomImageHeight > 0.0) {
                lgf_BottomImage.isHidden = false
                lgf_BottomImage.contentMode = lgf_Style.lgf_TitleImageContentMode
                lgf_BottomImageSpace.constant = lgf_Style.lgf_BottomImageSpace
                lgf_BottomImageWidth.constant = min(lgf_Style.lgf_BottomImageWidth, lgf_Style.lgf_PVTitleView.lgfpt_Width)
                lgf_BottomImageHeight.constant = min(lgf_Style.lgf_BottomImageHeight, lgf_Style.lgf_PVTitleView.lgfpt_Height)
                if (lgf_Style.lgf_IsNetImage) {
                    lgf_FreePTTitleDelegate?.lgf_GetTitleNetImage(lgf_BottomImage, URL.init(string: lgf_Style.lgf_UnSelectImageNames[tag]))
                } else {
                    lgf_BottomImage.image = UIImage.init(named: lgf_Style.lgf_UnSelectImageNames[tag], in: lgf_Style.lgf_ImageBundel, compatibleWith: nil)
                }
                lgf_TitleCenterY.constant = lgf_TitleCenterY.constant - (lgf_Style.lgf_BottomImageHeight / 2.0)
                if (lgf_Style.lgf_BottomImageSpace > 0.0) {
                    lgf_TitleCenterY.constant = lgf_TitleCenterY.constant - (lgf_Style.lgf_BottomImageSpace / 2.0)
                }
            } else {
                debugPrint("🤖️:如果要显示底部图标，请给 bottom_image_height 赋值")
            }
        }
    }
    
    // MARK: - 标初始化
    /**
     titleText 标文字
     index 在 LGFFreePT 中的位置下标
     style 配置用模型
     @return LGFFreePTTitle
     */
    class func lgf_AllocTitle(_ titleText: String, _ index: Int,_ style: LGFFreePTStyle!, _ delegate: LGFFreePTTitleDelegate) -> LGFFreePTTitle {
        // 初始化标
        let title = LGFPTBundle.loadNibNamed(String(describing: LGFFreePTTitle.self.classForCoder()), owner: self, options: nil)?.first as! LGFFreePTTitle
        title.tag = index
        title.lgf_FreePTTitleDelegate = delegate
        title.lgf_Style = style
        
        // 开启调试模式所有背景将设置随机颜色方便调试
        if title.lgf_Style.lgf_StartDebug {
            title.backgroundColor = UIColor.lgfpt_RandomColor()
            title.lgf_Title.backgroundColor = UIColor.lgfpt_RandomColor()
            title.lgf_SubTitle.backgroundColor = UIColor.lgfpt_RandomColor()
            title.lgf_LeftImage.backgroundColor = UIColor.lgfpt_RandomColor()
            title.lgf_RightImage.backgroundColor = UIColor.lgfpt_RandomColor()
            title.lgf_TopImage.backgroundColor = UIColor.lgfpt_RandomColor()
            title.lgf_BottomImage.backgroundColor = UIColor.lgfpt_RandomColor()
        }
        
        // 需要显示子标题
        if title.lgf_Style.lgf_IsDoubleTitle {
            title.lgf_Title.text = titleText.components(separatedBy: "~~~").first
            title.lgf_SubTitle.text = titleText.components(separatedBy: "~~~").last
        } else {
            title.lgf_Title.text = titleText
        }
        
        // 获取字体宽度
        title.lgf_Title.adjustsFontSizeToFitWidth = true
        let titleSize: CGSize = title.lgf_Title.text?.lgfpt_TextSizeWithFont(font: title.lgf_Style.lgf_TitleSelectFont.pointSize > title.lgf_Style.lgf_UnTitleSelectFont.pointSize ? title.lgf_Style.lgf_TitleSelectFont : title.lgf_Style.lgf_UnTitleSelectFont, constrainedToSize: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: title.lgf_Style.lgf_PVTitleView.lgfpt_Height)) ?? .zero
        var subTitleSize: CGSize = .zero
        if title.lgf_Style.lgf_IsDoubleTitle {
            title.lgf_SubTitle.adjustsFontSizeToFitWidth = true
            subTitleSize = title.lgf_SubTitle.text?.lgfpt_TextSizeWithFont(font: title.lgf_Style.lgf_SubTitleSelectFont.pointSize > title.lgf_Style.lgf_UnSubTitleSelectFont.pointSize ? title.lgf_Style.lgf_SubTitleSelectFont : title.lgf_Style.lgf_UnSubTitleSelectFont, constrainedToSize: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: title.lgf_Style.lgf_PVTitleView.lgfpt_Height)) ?? .zero
            title.lgf_SubTitleHeight.constant = subTitleSize.height
            title.lgf_TitleCenterY.constant = title.lgf_TitleCenterY.constant - subTitleSize.height / 2.0 - title.lgf_Style.lgf_SubTitleTopSpace / 2.0
            title.lgf_SubTitleTop.constant = title.lgf_Style.lgf_SubTitleTopSpace
            title.lgf_SubTitleWidth.constant = subTitleSize.width
        }
        title.lgf_TitleWidth.constant = titleSize.width
        title.lgf_TitleHeight.constant = titleSize.height
        
        // 标 X
        var titleX: CGFloat = 0.0
        if (index > 0) {
            let subview = title.lgf_Style.lgf_PVTitleView.subviews[index - 1]
            titleX = subview.lgfpt_X + subview.lgfpt_Width
        } else {
            titleX = title.lgf_Style.lgf_PageLeftRightSpace
        }
        
        // 标宽度
        let maxWidth = max(titleSize.width, subTitleSize.width)
        let totalWidth = (maxWidth + (style.lgf_TitleLeftRightSpace * 2.0) + title.lgf_Style.lgf_LeftImageWidth + title.lgf_Style.lgf_RightImageWidth + title.lgf_Style.lgf_LeftImageSpace + title.lgf_Style.lgf_RightImageSpace)
        let titleWidth = title.lgf_Style.lgf_TitleFixedWidth > 0.0 ? title.lgf_Style.lgf_TitleFixedWidth : totalWidth
        title.frame = CGRect.init(x: titleX, y: 0.0, width: titleWidth, height: title.lgf_Style.lgf_PVTitleView.lgfpt_Height)
        title.lgf_Style.lgf_PVTitleView.addSubview(title)
        
        // 根据特殊 title 数组 和 特殊 title 的 tag 判断某个 index 是否要替换特殊 title
        if style.lgf_FreePTSpecialTitleArray.count > 0 {
            style.lgf_FreePTSpecialTitleArray.forEach {
                let propertyArray = $0.lgf_FreePTSpecialTitleProperty?.components(separatedBy: "~~~")
                if propertyArray!.count == 2 {
                    let specialTitleIndex = Int(propertyArray!.first ?? "0")
                    if index == specialTitleIndex {
                        title.subviews.forEach { $0.removeFromSuperview() }
                        title.lgfpt_Width = CGFloat(Int(propertyArray!.last ?? "0") ?? 0)
                        $0.frame = title.bounds
                        title.addSubview($0)
                    }
                }
            }
        }
        // 这个代理放在最下面，对一些 LGFFreePTStyle 配置的属性拥有最终修改权
        title.lgf_FreePTTitleDelegate?.lgf_GetTitle(title, index, style)
        return title
    }
    
    // MARK: - 标整体状态改变 核心逻辑部分
    /**
     progress 外部 progress
     isSelectTitle 是否是要选中的 LGFFreePTTitle
     selectIndex 选中的 index
     unselectIndex 未选中的 index
     */
    func lgf_SetMainTitleTransform(_ progress: CGFloat, _ isSelectTitle: Bool, _ selectIndex: Int, _ unselectIndex: Int) {
        let deltaScale = lgf_Style.lgf_TitleTransformSX - 1.0
        let mainTitleDeltaScale = lgf_Style.lgf_MainTitleTransformSX - 1.0
        let subTitleDeltaScale = lgf_Style.lgf_SubTitleTransformSX - 1.0
        
        if isSelectTitle {
            lgf_CurrentTransformSX = 1.0 + deltaScale * progress
            lgf_MainTitleCurrentTransformSX = 1.0 + mainTitleDeltaScale * progress
            lgf_MainTitleCurrentTransformTY = lgf_Style.lgf_MainTitleTransformTY * progress
            lgf_MainTitleCurrentTransformTX = lgf_Style.lgf_MainTitleTransformTX * progress
            lgf_SubTitleCurrentTransformSX = 1.0 + subTitleDeltaScale * progress
            lgf_SubTitleCurrentTransformTY = lgf_Style.lgf_SubTitleTransformTY * progress
            lgf_SubTitleCurrentTransformTX = lgf_Style.lgf_SubTitleTransformTX * progress
        } else {
            lgf_CurrentTransformSX = lgf_Style.lgf_TitleTransformSX - deltaScale * progress
            lgf_MainTitleCurrentTransformSX = lgf_Style.lgf_MainTitleTransformSX - mainTitleDeltaScale * progress
            lgf_MainTitleCurrentTransformTY = lgf_Style.lgf_MainTitleTransformTY - lgf_Style.lgf_MainTitleTransformTY * progress
            lgf_MainTitleCurrentTransformTX = lgf_Style.lgf_MainTitleTransformTX - lgf_Style.lgf_MainTitleTransformTX * progress
            lgf_SubTitleCurrentTransformSX = lgf_Style.lgf_SubTitleTransformSX - subTitleDeltaScale * progress
            lgf_SubTitleCurrentTransformTY = lgf_Style.lgf_SubTitleTransformTY - lgf_Style.lgf_SubTitleTransformTY * progress
            lgf_SubTitleCurrentTransformTX = lgf_Style.lgf_SubTitleTransformTX - lgf_Style.lgf_SubTitleTransformTX * progress
        }
        
        transform = CGAffineTransform.init(scaleX: lgf_CurrentTransformSX, y: lgf_CurrentTransformSX)
        lgf_Title.transform = CGAffineTransform.identity
        lgf_Title.transform = CGAffineTransform.init(scaleX: lgf_MainTitleCurrentTransformSX, y: lgf_MainTitleCurrentTransformSX)
        lgf_Title.transform = lgf_Title.transform.translatedBy(x: lgf_MainTitleCurrentTransformTX, y: lgf_MainTitleCurrentTransformTY)
        
        lgf_SubTitle.transform = CGAffineTransform.identity
        lgf_SubTitle.transform = CGAffineTransform.init(scaleX: lgf_SubTitleCurrentTransformSX, y: lgf_SubTitleCurrentTransformSX)
        lgf_SubTitle.transform = lgf_SubTitle.transform.translatedBy(x: lgf_SubTitleCurrentTransformTX, y: lgf_SubTitleCurrentTransformTY)
        
        // 标颜色渐变
        if lgf_Style.lgf_TitleSelectColor != lgf_Style.lgf_UnTitleSelectColor {
            let colors = isSelectTitle ? lgf_UnSelectColorRGBA : lgf_SelectColorRGBA
            lgf_Title.textColor = UIColor.init(red: colors[0] - (isSelectTitle ? lgf_DeltaRGBA[0] : -lgf_DeltaRGBA[0]) * progress, green: colors[1] - (isSelectTitle ? lgf_DeltaRGBA[1] : -lgf_DeltaRGBA[1]) * progress, blue: colors[2] - (isSelectTitle ? lgf_DeltaRGBA[2] : -lgf_DeltaRGBA[2]) * progress, alpha: colors[3] - (isSelectTitle ? lgf_DeltaRGBA[3] : -lgf_DeltaRGBA[3]) * progress)
        }
        if lgf_Style.lgf_IsDoubleTitle && lgf_Style.lgf_SubTitleSelectColor != lgf_Style.lgf_UnSubTitleSelectColor {
            let colors = isSelectTitle ? lgf_SubUnSelectColorRGBA : lgf_SubSelectColorRGBA
            lgf_SubTitle.textColor = UIColor.init(red: colors[0] - (isSelectTitle ? lgf_SubDeltaRGBA[0] : -lgf_SubDeltaRGBA[0]) * progress, green: colors[1] - (isSelectTitle ? lgf_SubDeltaRGBA[1] : -lgf_SubDeltaRGBA[1]) * progress, blue: colors[2] - (isSelectTitle ? lgf_SubDeltaRGBA[2] : -lgf_SubDeltaRGBA[2]) * progress, alpha: colors[3] - (isSelectTitle ? lgf_SubDeltaRGBA[3] : -lgf_SubDeltaRGBA[3]) * progress)
        }
        
        // 字体改变
        if !(lgf_Style.lgf_TitleSelectFont == lgf_Style.lgf_UnTitleSelectFont) {
            lgf_Title.font = (isSelectTitle == (progress > 0.5)) ? lgf_Style.lgf_TitleSelectFont : lgf_Style.lgf_UnTitleSelectFont
        }
        if lgf_Style.lgf_IsDoubleTitle {
            if !(lgf_Style.lgf_SubTitleSelectFont == lgf_Style.lgf_UnSubTitleSelectFont) {
                lgf_SubTitle.font = (isSelectTitle == (progress > 0.5)) ? lgf_Style.lgf_SubTitleSelectFont : lgf_Style.lgf_UnSubTitleSelectFont
            }
        }
        
        // 图标选中
        if lgf_Style.lgf_SelectImageNames.count > 0 && lgf_Style.lgf_UnSelectImageNames.count > 0 {
            let ssImageName = lgf_Style.lgf_SelectImageNames[selectIndex]
            let uuImageName = lgf_Style.lgf_UnSelectImageNames[unselectIndex]
            let usImageName = lgf_Style.lgf_UnSelectImageNames[selectIndex]
            let suImageName = lgf_Style.lgf_SelectImageNames[unselectIndex]
            let imageName = (isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName))
            if lgf_Style.lgf_LeftImageWidth > 0.0 && lgf_Style.lgf_LeftImageHeight > 0.0 {
                if lgf_Style.lgf_IsNetImage {
                    lgf_FreePTTitleDelegate?.lgf_GetTitleNetImage(lgf_LeftImage, URL.init(string: imageName))
                } else {
                    lgf_LeftImage.image = UIImage.init(named: imageName, in: lgf_Style.lgf_ImageBundel, compatibleWith: nil)
                }
            }
            if lgf_Style.lgf_RightImageWidth > 0.0 && lgf_Style.lgf_RightImageHeight > 0.0 {
                if lgf_Style.lgf_IsNetImage {
                    lgf_FreePTTitleDelegate?.lgf_GetTitleNetImage(lgf_RightImage, URL.init(string: imageName))
                } else {
                    lgf_RightImage.image = UIImage.init(named: imageName, in: lgf_Style.lgf_ImageBundel, compatibleWith: nil)
                }
            }
            if lgf_Style.lgf_TopImageHeight > 0.0 && lgf_Style.lgf_TopImageWidth > 0.0 {
                if lgf_Style.lgf_IsNetImage {
                    lgf_FreePTTitleDelegate?.lgf_GetTitleNetImage(lgf_TopImage, URL.init(string: imageName))
                } else {
                    lgf_TopImage.image = UIImage.init(named: imageName, in: lgf_Style.lgf_ImageBundel, compatibleWith: nil)
                }
            }
            if lgf_Style.lgf_BottomImageHeight > 0.0 && lgf_Style.lgf_BottomImageWidth > 0.0 {
                if lgf_Style.lgf_IsNetImage {
                    lgf_FreePTTitleDelegate?.lgf_GetTitleNetImage(lgf_BottomImage, URL.init(string: imageName))
                } else {
                    lgf_BottomImage.image = UIImage.init(named: imageName, in: lgf_Style.lgf_ImageBundel, compatibleWith: nil)
                }
            }
        }
    }
    
}
