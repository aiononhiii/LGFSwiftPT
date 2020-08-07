//
//  LGFSwiftPTLine.swift
//  LGFSwiftPT
//
//  Created by 来 on 2019/10/9.
//  Copyright © 2019 laiguofeng. All rights reserved.
//

import UIKit

public protocol LGFSwiftPTLineDelegate: NSObjectProtocol {
    
    // MARK: - 加载 line 网络图片代理，具体加载框架我的 Demo 不做约束，请自己选择图片加载框架，使用前请打开 lgf_IsNetImage
    /// - Parameters:
    ///   - imageView: 要加载网络图片的 imageView
    ///   - imageUrl: 网络图片的 Url
    func lgf_GetLineNetImage(_ imageView: UIImageView, _ imageUrl: URL!)
    
    // MARK: - 实现这个代理来对 LGFSwiftPTLine 生成时某些系统属性进行配置 backgroundColor/borderColor/CornerRadius等等
    /// - Parameters:
    ///   - lgf_SwiftPTLine: LGFSwiftPTLine 本体
    ///   - style: LGFSwiftPTStyle
    func lgf_GetLine(_ lgf_SwiftPTLine: UIImageView, _ style: LGFSwiftPTStyle)
}

public class LGFSwiftPTLine: UIImageView {
    
    /// LGFSwiftPTLine 主代理
    public weak var lgf_SwiftPTLineDelegate: LGFSwiftPTLineDelegate?
    
    /// 配置用模型
    public private(set) weak var lgf_Style: LGFSwiftPTStyle! {
        didSet {
            // 坐标配置
            let Y = lgf_Style.lgf_PVTitleView.lgfpt_Height - ((lgf_Style.lgf_LineHeight + lgf_Style.lgf_LineBottom) > lgf_Style.lgf_PVTitleView.lgfpt_Height ? lgf_Style.lgf_PVTitleView.lgfpt_Height : (lgf_Style.lgf_LineHeight + lgf_Style.lgf_LineBottom))
            let H = (lgf_Style.lgf_LineHeight + lgf_Style.lgf_LineBottom) > lgf_Style.lgf_PVTitleView.lgfpt_Height ? (lgf_Style.lgf_PVTitleView.lgfpt_Height - lgf_Style.lgf_LineBottom) : lgf_Style.lgf_LineHeight
            switch lgf_Style.lgf_LineWidthType {
            case .fixedWith:
                lgfpt_Width = lgf_Style.lgf_LineWidth
                break
            case .equalTitle:
                lgfpt_Width = lgf_Style.lgf_TitleFixedWidth
                break
            default:
                break
            }
            lgfpt_Y = Y
            lgfpt_Height = H
            // 添加 line 图片
            if lgf_Style.lgf_LineImageName.count > 0 && subviews.count == 0 {
                if lgf_Style.lgf_IsLineNetImage {
                    lgf_SwiftPTLineDelegate?.lgf_GetLineNetImage(self, URL.init(string: lgf_Style.lgf_LineImageName))
                } else {
                    image = UIImage.init(named: lgf_Style.lgf_LineImageName, in: lgf_Style.lgf_ImageBundel, compatibleWith: nil)
                }
            }
            // 非主要属性配置
            if lgf_Style.lgf_LineCornerRadius > 0.0 {
                layer.cornerRadius = lgf_Style.lgf_LineCornerRadius
                if !clipsToBounds { clipsToBounds = true }
            }
            if lgf_Style.lgf_TitleBorderWidth > 0.0 {
                layer.borderWidth = lgf_Style.lgf_LineBorderWidth
                layer.borderColor = lgf_Style.lgf_LineBorderColor.cgColor
                if !clipsToBounds { clipsToBounds = true }
            }
            contentMode = lgf_Style.lgf_LineImageContentMode
            backgroundColor = lgf_Style.lgf_LineColor
            
        }
    }
    
    // MARK: - LGFSwiftPTLine 初始化
    /// - Parameters:
    ///   - style: LGFSwiftPTStyle
    ///   - delegate: LGFSwiftPTLineDelegate
    class func lgf_AllocLine(_ style: LGFSwiftPTStyle, _ delegate: LGFSwiftPTLineDelegate) -> LGFSwiftPTLine {
        let line = LGFSwiftPTStyle.LGFPTBundle.loadNibNamed(String(describing: LGFSwiftPTLine.self.classForCoder()), owner: self, options: nil)?.first as! LGFSwiftPTLine
        line.lgf_SwiftPTLineDelegate = delegate
        line.lgf_Style = style
        // 这个代理放在最下面，对一些 LGFSwiftPTStyle 配置的属性拥有最终修改权
        line.lgf_SwiftPTLineDelegate?.lgf_GetLine(line, style)
        return line
    }
    
    deinit {
        debugPrint("🤖️:LGFSwiftPTLine --- 已释放 ✈️")
    }
    
}
