//
//  LGFSwiftPTFlowLayout.swift
//  LGFSwiftPT
//
//  Created by 来 on 2019/10/10.
//  Copyright © 2019 laiguofeng. All rights reserved.
//

import UIKit

public protocol LGFSwiftPTFlowLayoutDelegate: NSObjectProtocol {
    // MARK: - 自定义分页动画（我这里提供一个配置入口，也可以自己在外面配置 UICollectionViewFlowLayout 原理一样，自己在外面配置的话记得配置 self.scrollDirection = .horizontal self.minimumInteritemSpacing = 0 self.minimumLineSpacing = 0 self.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)）
    func lgf_FreePageViewCustomizeAnimation(_ attributes: [UICollectionViewLayoutAttributes], _ flowLayout: UICollectionViewFlowLayout)
}

public class LGFSwiftPTFlowLayout: UICollectionViewFlowLayout {
    public weak var lgf_SwiftPTFlowLayoutDelegate: LGFSwiftPTFlowLayoutDelegate?
    public var lgf_PVAnimationType: lgf_FreePageViewAnimationType!
    
    override public func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        minimumInteritemSpacing = 0.0
        minimumLineSpacing = 0.0
        sectionInset = .zero
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attrs = super.layoutAttributesForElements(in: rect)?.map { ($0.copy() as! UICollectionViewLayoutAttributes) } ?? []
        switch lgf_PVAnimationType {
        case .topToBottom?:
            lgf_FreePageViewTopToBottomAnimationConfig(attrs, self)
            break
        case .smallToBig?:
            lgf_FreePageViewSmallToBigAnimationConfig(attrs, self)
            break
        case .customize?:
            lgf_SwiftPTFlowLayoutDelegate?.lgf_FreePageViewCustomizeAnimation(attrs, self)
            debugPrint(String.init(format: "🤖️:自定义分页动画的 contentOffset.x:%f", collectionView!.contentOffset.x))
            break
        default:
            break
        }
        return attrs
    }
}
