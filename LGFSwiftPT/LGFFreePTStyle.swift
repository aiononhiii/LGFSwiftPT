//
//  LGFFreePTStyle.swift
//  LGFSwiftPT
//
//  Created by 来 on 2019/10/9.
//  Copyright © 2019 laiguofeng. All rights reserved.
//

import UIKit

let LGFPTBundle = Bundle.init(path: Bundle.main.path(forResource:"LGFSwiftPT", ofType:"bundle") ?? "") ?? Bundle.main

enum lgf_FreePageViewAnimationType {
    case defult// 默认分页动画
    case topToBottom// 从上往下进入的分页动画
    case smallToBig// 从小到大进入的分页动画
    case none// 没有分页动画
    case customize// 自定义分页动画 我将返回你 layoutAttributesForElementsInRect 的所有参数，你也可以自己给外部的你自己创建的子控制器容器 collectionview 自己配置 UICollectionViewFlowLayout
}

enum lgf_FreePageLineAnimationType {
    case defult// title 底部线平滑改变大小
    case shortToLong// title 底部线先右边伸出变宽致 title 和下一个 title 的总宽度, 再左边收回恢复到下一个 title 的宽度
    case hideShow// 渐隐效果， title 底部线隐藏，再在下一个 title 的底部出现
    case tortoiseDown// 乌龟的头效果， title 底部线向下隐藏，再在下一个 title 的底部向上出现
    case tortoiseUp// 乌龟的头效果， title 底部线向上隐藏，再在下一个 title 的底部向下出现
    case smallToBig// title 底部线缩小放大
    case customize// 我想自定义这个效果，将返回你或许需要的值（selectX，selectWidth，unSelectX，unSelectWidth等等），用这些值来制造你自己想要的 line 动画
}

enum lgf_FreeTitleScrollFollowType {
    case defult// 在可滚动的情况下, 选中 title 默认滚动到 lgf_PVTitleView 中间
    // 后续推出下面的 仿腾讯新闻, 天天快报选中 title 滚动效果 现暂时不可用 请勿设置
    case leftRight// 向左滚动选中 title 永远出现在最右边可见位置, 反之向右滚动选中 title 永远出现在最左边可见位置（此效果不会像上面的效果那样滚到中间）(模仿腾讯新闻)
    case customize// 我想自定义这个效果，将返回你或许需要的值
}

enum lgf_FreeTitleLineWidthType {
    case equalTitleSTR// 宽度等于字体宽度
    case equalTitleSTRAndImage// 宽度等于字体宽度 + 图 title 宽度
    case equalTitle// 宽度等于 title view宽度
    case fixedWith// 宽度等于固定宽度
}


class LGFFreePTStyle: NSObject {
    // 开启 UI 调试模式（自定义 line 动画时可打开）
    var lgf_StartDebug: Bool = false
    // 展示自定义动画辅助 Print
    var lgf_ShowPrint: Bool = true
    
    // MARK: ------------------- 数据源设置 -------------------
    // title 数组
    lazy var lgf_Titles: [String] = []
    
    // MARK: ------------------- 主 lgf_PVTitleView -------------------
    // lgf_PVTitleView
    weak var lgf_PVTitleView: UIScrollView!
    // lgf_PVTitleView 父视图背景色
    var lgf_PVTitleViewBackgroundColor: UIColor = UIColor.clear
    // 主 lgf_PVTitleView 在父控件上的frame 默认等于父控件
    var lgf_PVTitleViewFrame: CGRect = .zero
    
    // MARK: ------------------- 分页控件是否带分页动画 -------------------
    // 分页控件分页动画枚举
    var lgf_PVAnimationType: lgf_FreePageViewAnimationType = .defult
    
    // MARK: ------------------- 整体序列设置 -------------------
    // 当所有 title 总宽度加起来小于 lgf_PVTitleView 宽度时 是否居中显示 默认 NO - 不居中(从左边开始显示)
    var lgf_IsTitleCenter: Bool = false
    // 选中结束后标的回位模式 默认 defult
    var lgf_TitleScrollFollowType: lgf_FreeTitleScrollFollowType = .defult
    // 是否立即回位(淘宝首页立即回位)
    var lgf_IsExecutedImmediatelyTitleScrollFollow: Bool = false
    // page左右间距 默认 0.0
    var lgf_PageLeftRightSpace: CGFloat = 0.0
    
    // MARK: ------------------- title 设置 -------------------
    // 是否支持副 title 副标题 lgf_Titles 格式：@[@"11~~~22", @"33~~~44"] 22 和 44 为副标题
    var lgf_IsDoubleTitle: Bool = false
    // title 固定宽度 默认等于 0.0 如果此属性大于 0.0 那么 title 宽度将为固定值
    // 如果设置此项（lgf_TitleFixedWidth） LGFTitleLineWidthType 将只支持 FixedWith 固定底部线宽度
    var lgf_TitleFixedWidth: CGFloat = 0.0
    // 选中 title 放大缩小倍数 默认 1.0(不放大缩小)
    var lgf_TitleTransformSX: CGFloat = 1.0 {
        didSet {
            lgf_TitleTransformSX = lgf_TitleTransformSX == 0.0 ? 0.00001 : lgf_TitleTransformSX
        }
    }
    // 选中 title 字体颜色 默认 blackColor 黑色 (对应 lgf_TitleUnSelectColor 两个颜色一样则取消渐变效果)
    var lgf_TitleSelectColor: UIColor = UIColor.black
    // 未选中 title 字体颜色 默认 lightGrayColor 淡灰色 (对应 lgf_TitleSelectColor 两个颜色一样则取消渐变效果)
    var lgf_UnTitleSelectColor: UIColor = UIColor.lightGray
    // title 选中字体 默认 [UIFont systemFontOfSize:14]
    var lgf_TitleSelectFont: UIFont = UIFont.systemFont(ofSize: 14)
    // title 未选中字体 默认 和选中字体一样
    var lgf_UnTitleSelectFont: UIFont = UIFont.systemFont(ofSize: 14)
    // 选中主 title 放大缩小倍数 默认 1.0(不放大缩小)
    var lgf_MainTitleTransformSX: CGFloat = 1.0 {
        didSet {
            lgf_MainTitleTransformSX = lgf_MainTitleTransformSX == 0.0 ? 0.00001 : lgf_MainTitleTransformSX
        }
    }
    // 选中主 title 上下偏移数 默认 0.0(不上下偏移)
    var lgf_MainTitleTransformTY: CGFloat = 0.0
    // 选中主 title 左右偏移数 默认 0.0(不左右偏移)
    var lgf_MainTitleTransformTX: CGFloat = 0.0
    // 副 title 默认和 title 一样
    var lgf_SubTitleSelectColor: UIColor = UIColor.black
    var lgf_UnSubTitleSelectColor: UIColor = UIColor.lightGray
    var lgf_SubTitleSelectFont: UIFont = UIFont.systemFont(ofSize: 14)
    var lgf_UnSubTitleSelectFont: UIFont = UIFont.systemFont(ofSize: 14)
    // 副 title 和 主 title 的距离
    var lgf_SubTitleTopSpace: CGFloat = 0.0
    // 选中副 title 放大缩小倍数 默认 1.0(不放大缩小)
    var lgf_SubTitleTransformSX: CGFloat = 1.0 {
        didSet {
            lgf_SubTitleTransformSX = lgf_SubTitleTransformSX == 0.0 ? 0.00001 : lgf_SubTitleTransformSX
        }
    }
    // 选中副 title 上下偏移数 默认 0.0(不上下偏移)
    var lgf_SubTitleTransformTY: CGFloat = 0.0
    // 选中副 title 左右偏移数 默认 0.0(不左右偏移)
    var lgf_SubTitleTransformTX: CGFloat = 0.0
    // line 是否对准 副 title
    var lgf_IsLineAlignSubTitle: Bool = false {
        didSet {
            if !lgf_IsDoubleTitle {
                lgf_IsLineAlignSubTitle = false
            }
        }
    }
    // title 是否有滑动动画 默认 YES 有动画
    var lgf_TitleHaveAnimation: Bool = true
    // title 左右间距 默认 0.0
    var lgf_TitleLeftRightSpace: CGFloat = 0.0
    // 点击 title 移动动画时间 默认 0.3
    var lgf_TitleClickAnimationDuration: TimeInterval = 0.3
    // 点击 title 后移动 title 居中动画时间 默认 0.2
    var lgf_TitleScrollToTheMiddleAnimationDuration: TimeInterval = 0.25
    // title 部分 **(非主要属性)**
    var lgf_TitleCornerRadius: CGFloat = 0.0
    var lgf_TitleBorderWidth: CGFloat = 0.0
    var lgf_TitleBorderColor: UIColor = UIColor.clear
    
    // MARK: ------------------- ******** 特殊 title 设置 ******* -------------------
    // 要替换的特殊 title 数组（数组中元素 view (改 view 最好为单列，以方便设置 选中状态/动效/动画 等特殊处理) 的 lgf_FreePTSpecialTitleArray（值格式：@"0~~~80"） 字符串属性转化为数组后 数组的 firstObject（0） 即为要替换 title 的 index, 数组的 lastObject（80） 即为要替换 title 的自定义宽度）（记住这只是障眼法替换，因此原数据源支撑 UI 展示的数据必须存在，可设置为空字符串）
    lazy var lgf_FreePTSpecialTitleArray: [UIView] = []
    
    // MARK: ------------------- title 图片设置 -------------------
    // 图片Bundle 如果图片不在本控件bundel里请设置
    var lgf_ImageBundel: Bundle = Bundle.main
    // title 图片 ContentMode **(非主要属性)**
    var lgf_TitleImageContentMode: UIView.ContentMode = .scaleToFill
    // lgf_SelectImageNames 和 lgf_SameSelectImageName 设置一个就行 如果都设置了默认取 lgf_SameSelectImageName
    // 设置不同图 title 数组（必须和titles数组count保持一致,如果某一个 title 不想设置图 title 名字传空即可）
    // 选中图 title 数组和未选中图 title 数组如果只传了其中一个,将没有选中效果
    var lgf_SelectImageNames: [String] = [] {
        didSet {
            if lgf_UnSelectImageNames.count == 0 {
                lgf_UnSelectImageNames = lgf_SelectImageNames
            }
        }
    }
    var lgf_UnSelectImageNames: [String] = [] {
        didSet {
            if lgf_SelectImageNames.count == 0 {
                lgf_SelectImageNames = lgf_UnSelectImageNames
            }
        }
    }
    // 设置所有图 title 为相同
    var lgf_SameSelectImageName: String = "" {
        didSet {
            if lgf_SameUnSelectImageName.count == 0 {
                lgf_SameUnSelectImageName = lgf_SameSelectImageName
            }
        }
    }
    var lgf_SameUnSelectImageName: String = "" {
        didSet {
            if lgf_SameSelectImageName.count == 0 {
                lgf_SameSelectImageName = lgf_SameUnSelectImageName
            }
        }
    }
    // 是否是网络图片
    var lgf_IsNetImage: Bool = false
    
    // 以下属性只要有值，对应imageview就会显示出来
    // 顶部 title 图片与 title 的间距 默认 0
    var lgf_TopImageSpace: CGFloat = 0.0
    // 顶部 title 图片宽度 默认等于设置的高度 最大不超过 title view高度
    var lgf_TopImageWidth: CGFloat = 0.0 {
        didSet {
            if lgf_TopImageWidth == 0.0 {
                lgf_TopImageWidth = lgf_TopImageHeight
            } else {
                if lgf_TopImageHeight == 0.0 {
                    lgf_TopImageHeight = lgf_TopImageWidth
                }
            }
        }
    }
    // 顶部 title 图片高度 默认等于设置的宽度
    var lgf_TopImageHeight: CGFloat = 0.0 {
        didSet {
            if lgf_TopImageHeight == 0.0 {
                lgf_TopImageHeight = lgf_TopImageWidth
            } else {
                if lgf_TopImageWidth == 0.0 {
                    lgf_TopImageWidth = lgf_TopImageHeight
                }
            }
        }
    }
    // 底部 title 图片与 title 的间距 默认 0
    var lgf_BottomImageSpace: CGFloat = 0.0
    // 底部 title 图片宽度 默认等于设置的高度 最大不超过 title view高度
    var lgf_BottomImageWidth: CGFloat = 0.0 {
        didSet {
            if lgf_BottomImageWidth == 0.0 {
                lgf_BottomImageWidth = lgf_BottomImageHeight
            } else {
                if lgf_BottomImageHeight == 0.0 {
                    lgf_BottomImageHeight = lgf_BottomImageWidth
                }
            }
        }
    }
    // 底部 title 图片高度 默认等于设置的宽度
    var lgf_BottomImageHeight: CGFloat = 0.0 {
        didSet {
            if lgf_BottomImageHeight == 0.0 {
                lgf_BottomImageHeight = lgf_BottomImageWidth
            } else {
                if lgf_BottomImageWidth == 0.0 {
                    lgf_BottomImageWidth = lgf_BottomImageHeight
                }
            }
        }
    }
    // 左边 title 图片与 title 的间距 默认 0
    var lgf_LeftImageSpace: CGFloat = 0.0
    // 左边 title 图片宽度 默认等于设置的高度 最大不超过 title view高度
    var lgf_LeftImageWidth: CGFloat = 0.0 {
        didSet {
            if lgf_LeftImageWidth == 0.0 {
                lgf_LeftImageWidth = lgf_LeftImageHeight
            } else {
                if lgf_LeftImageHeight == 0.0 {
                    lgf_LeftImageHeight = lgf_LeftImageWidth
                }
            }
        }
    }
    // 左边 title 图片高度 默认等于设置的宽度
    var lgf_LeftImageHeight: CGFloat = 0.0 {
        didSet {
            if lgf_LeftImageHeight == 0.0 {
                lgf_LeftImageHeight = lgf_LeftImageWidth
            } else {
                if lgf_LeftImageWidth == 0.0 {
                    lgf_LeftImageWidth = lgf_LeftImageHeight
                }
            }
        }
    }
    // 右边 title 图片与 title 的间距 默认 0
    var lgf_RightImageSpace: CGFloat = 0.0
    // 右边 title 图片宽度 默认等于设置的高度 最大不超过 title view高度
    var lgf_RightImageWidth: CGFloat = 0.0 {
        didSet {
            if lgf_RightImageWidth == 0.0 {
                lgf_RightImageWidth = lgf_RightImageHeight
            } else {
                if lgf_RightImageHeight == 0.0 {
                    lgf_RightImageHeight = lgf_RightImageWidth
                }
            }
        }
    }
    // 右边 title 图片高度 默认等于设置的宽度
    var lgf_RightImageHeight: CGFloat = 0.0 {
        didSet {
            if lgf_RightImageHeight == 0.0 {
                lgf_RightImageHeight = lgf_RightImageWidth
            } else {
                if lgf_RightImageWidth == 0.0 {
                    lgf_RightImageWidth = lgf_RightImageHeight
                }
            }
        }
    }
    
    // MARK: ------------------- title 底部线设置 -------------------
    // 是否显示 title 底部滚动线 默认 YES 显示
    var lgf_IsShowLine: Bool = true
    // title 底部滚动线 背景图片 默认 无图
    var lgf_LineImageName: String = ""
    // 是否是 line 网络图片
    var lgf_IsLineNetImage: Bool = false
    // title 底部滚动线 颜色 默认 blueColor
    var lgf_LineColor: UIColor = UIColor.blue
    // title 底部滚动线 动画宽度设置 默认宽度等于 title 字体宽度 - equalTitle
    var lgf_LineWidthType: lgf_FreeTitleLineWidthType = .equalTitle
    // title 底部滚动线 宽度 默认 0 - 设置 LGFTitleLineType 固定宽度(FixedWith)时有效
    var lgf_LineWidth: CGFloat = 0.0
    // title 底部滚动线 高度 默认 1.0 (line_height最大高度为 LGFFreePT 的高度)
    var lgf_LineHeight: CGFloat = 1.0
    // title 底部滚动线相对于底部位置 默认 0 - 贴于底部
    var lgf_LineBottom: CGFloat = 0.0
    // title 底部滚动线中心点左右偏移 默认 0 - 不偏移
    var lgf_LineCenterX: CGFloat = 0.0
    // title 底部滚动线滑动动画 默认 defult 有跟随动画
    var lgf_LineAnimation: lgf_FreePageLineAnimationType = .defult
    // title 底部滚动线 部分 **(非主要属性)**
    var lgf_LineCornerRadius: CGFloat = 0.0
    var lgf_LineBorderWidth: CGFloat = 0.0
    var lgf_LineBorderColor: UIColor = UIColor.clear
    var lgf_LineImageContentMode: UIView.ContentMode = .scaleToFill
    
}
