//
//  VerticalViewController.swift
//  LGFSwiftPTDemo
//
//  Created by 来 on 2019/10/20.
//  Copyright © 2019 laiguofeng. All rights reserved.
//

import UIKit

class VerticalViewController: UIViewController {
    
    @IBOutlet weak var pageSuperView: UIView!
    @IBOutlet weak var pageSuperViewSuperView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionViewOne: UICollectionView!
    @IBOutlet weak var collectionViewOneBack: UIView!
    @IBOutlet weak var collectionViewFiveBack: UIView!
    @IBOutlet weak var latelyView: UIView!
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var collectionViewTwo: UICollectionView!
    @IBOutlet weak var collectionViewThree: UICollectionView!
    @IBOutlet weak var collectionViewFour: UICollectionView!
    @IBOutlet weak var collectionViewFive: UICollectionView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    // LGFSwiftPT
    lazy var fptView: LGFSwiftPT = {
        // 支付宝效果配置
        let style = LGFSwiftPTStyle()
        style.lgf_LineWidthType = .equalTitleSTR// 底部线对准字
        style.lgf_TitleLeftRightSpace = 10.0
        style.lgf_LineHeight = 2.0
        style.lgf_TitleSelectFont = UIFont.boldSystemFont(ofSize: 16)
        style.lgf_UnTitleSelectFont = UIFont.boldSystemFont(ofSize: 16)
        style.lgf_LineColor = UIColor.init(red: 15.0 / 255.0, green: 143.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
        style.lgf_TitleSelectColor = UIColor.init(red: 15.0 / 255.0, green: 143.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
        style.lgf_UnTitleSelectColor = UIColor.darkGray
        style.lgf_LineAnimation = .defult
        style.lgf_TitleScrollToTheMiddleAnimationDuration = 0.2
        let view = LGFSwiftPT.lgf(style, self, self.pageSuperView, nil)
        view.lgf_SwiftPTDelegate = self
        return view
    }()
    // 头部高度
    var headerHeight: CGFloat = 454.0 + 10.0
    // 我的应用数据源数组
    lazy var myDataArray: [String] = []
    // 最近使用数据源数组
    lazy var latelyDataArray: [String] = []
    // 底下数据源数组
    lazy var dataArray: [[String: [String]]] = []
    // 记录用于滚动选择判断的 contentOffset.y
    lazy var pageSelectYArray: [[Double]] = []
    // 是否编辑
    var isEdit: Bool = false
    var isSelectTitle: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            collectionViewOne.contentInsetAdjustmentBehavior = .never
            collectionViewTwo.contentInsetAdjustmentBehavior = .never
            collectionViewThree.contentInsetAdjustmentBehavior = .never
            collectionViewFour.contentInsetAdjustmentBehavior = .never
            collectionViewFive.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        myDataArray = ["转账", "信用卡还款", "淘票票电影", "花呗", "滴滴出行", "饿了么外卖", "蚂蚁庄园", "蚂蚁森林", "充值中心", "我的快递"]
        latelyDataArray = ["生活缴费", "城市服务", "车主服务", "红包", "商家服务", "发票管家", "借呗", "更多"]
        dataArray = [["便民生活" : ["充值中心", "信用卡还款", "生活缴费", "城市服务", "我的快递", "医疗健康", "记账本", "发票管家", "车主服务", "交通出行", "体育服务", "安全备忘"]],
                     ["财富管理" : ["余额宝", "花呗", "芝麻信用", "借呗", "蚂蚁保险", "汇率换算"]],
                     ["资金往来" : ["转账", "红包", "AA收款", "亲情号", "商家服务"]],
                     ["购物娱乐" : ["出境", "彩票", "奖励金"]],
                     ["教育公益" : ["校园生活", "蚂蚁森林", "蚂蚁庄园", "中小学", "运动", "亲子账户"]],
                     ["第三方服务" : ["淘票票电影", "滴滴出行", "饿了么外卖", "天猫", "淘宝", "火车票机票", "飞猪酒店", "蚂上租租房", "高德打车", "哈啰出行"]]]
        
        // 计算需要选中的 contentOffset.y 保存
        var oldY = 0.0
        var newY = 0.0
        for (index, value) in dataArray.enumerated() {
            if let items = value.values.first {
                let num = ceilf(Float(items.count) / 4.0)
                newY = newY + (index == 0 ? 10.0 : 50.0) + Double(num) * 70.0
                pageSelectYArray.append([oldY, newY])
                oldY = oldY + (index == 0 ? 10.0 : 50.0) + Double(num) * 70.0
            }
        }
        
        // 刷新title数组[
        fptView.lgf_Style.lgf_Titles = ["便民生活", "财富管理", "资金往来", "购物娱乐", "教育公益", "第三方服务"]
        fptView.lgf_ReloadTitleAndSelectIndex(0, false, false)
        setHeader()
    }
    
    func setHeader() {
        // 设置头高度（可动态适配，我这边只用于示例代码因此是写死的高度）
        headerHeight = 454.0 + 10.0
        // 添加头
        headerView.frame = CGRect.init(x: 0.0, y: -headerHeight, width: UIScreen.main.bounds.width, height: headerHeight)
        collectionViewFour.addSubview(headerView)
        collectionViewFour.sendSubviewToBack(headerView)
        // 添加 LGFFreePTView 父控件
        pageSuperViewSuperView.frame = CGRect.init(x: 0.0, y: -10.0, width: UIScreen.main.bounds.width, height: 48.0)
        collectionViewFour.addSubview(pageSuperViewSuperView)
        
        setCVContentInset(0.0)
    }
    
    func setCVContentInset(_ top: CGFloat) {
        let f = (CGFloat(pageSelectYArray.last!.last! - pageSelectYArray.last!.first!) + top)
        let lastY = UIScreen.main.bounds.height - UIDevice.lgf_NavBarH() - 40.0 - f
        collectionViewFour.contentInset = UIEdgeInsets.init(top: headerHeight, left: 0.0, bottom: lastY, right: 0.0)
        collectionViewFour.setContentOffset(CGPoint.init(x: 0, y: 0.0 - collectionViewFour.contentInset.top), animated: false)
    }
    
    @IBAction func edit (_ sender: UIButton) {
        isEdit = !isEdit
        if isEdit {
            collectionViewFiveBack.frame = CGRect.init(x: 0.0, y: 0.0, width: UIDevice.lgf_ScreenW, height: 250.0)
            headerView.addSubview(collectionViewFiveBack)
            headerView.insertSubview(collectionViewFiveBack, belowSubview: latelyView)
            setCVContentInset(258.0)
            UIView.animate(withDuration: 0.3, animations: {
                self.collectionViewOneBack.transform = CGAffineTransform.init(translationX: 0.0, y: 20.0)
                self.latelyView.transform = CGAffineTransform.init(translationX: 0.0, y: self.collectionViewFive.lgfpt_Height)
                self.recommendView.transform = CGAffineTransform.init(translationX: 0.0, y: self.collectionViewFive.lgfpt_Height)
                self.collectionViewOneBack.alpha = 0.0
                self.recommendView.alpha = 0.0
                self.editButton.alpha = 0.0
                self.completeButton.alpha = 1.0
                self.collectionViewFive.transform = CGAffineTransform.init(translationX: 0.0, y: 10.0)
                self.collectionViewFiveBack.alpha = 1.0
            }) { (finish) in
                self.headerView.backgroundColor = UIColor.init(lgf_HexString: "F5F4FB")
                self.collectionViewFiveBack.removeFromSuperview()
                self.collectionViewFiveBack.frame = CGRect.init(x: 0.0, y: -self.headerHeight, width: UIDevice.lgf_ScreenW, height: 250.0)
                self.collectionViewFour.addSubview(self.collectionViewFiveBack)
                self.goEdit({
                    
                })
            }
        } else {
            headerView.backgroundColor = UIColor.init(lgf_HexString: "FFFFFF")
            fptView.lgf_SelectIndex(0, 0.1, 0.25)
            setCVContentInset(0.0)
            goEdit {
                UIView.animate(withDuration: 0.3, animations: {
                    self.collectionViewFive.transform = CGAffineTransform.identity
                    self.collectionViewFiveBack.alpha = 0.0
                    self.collectionViewOneBack.transform = CGAffineTransform.identity
                    self.collectionViewOneBack.alpha = 1.0
                    self.editButton.alpha = 1.0
                    self.completeButton.alpha = 0.0
                }, completion: { (finish) in
                    UIView.animate(withDuration: 0.3, animations: {
                        self.latelyView.transform = CGAffineTransform.identity
                        self.recommendView.transform = CGAffineTransform.identity
                        self.recommendView.alpha = 1.0;
                    }, completion: { (finish) in
                        self.collectionViewFiveBack.removeFromSuperview()
                    })
                })
            }
        }
    }
    
    func goEdit(_ completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: 0.3, animations: {
            self.collectionViewTwo.visibleCells.forEach({ (view) in
                let cell = view as! VerticalViewControllerCell
                cell.isEdit = self.isEdit
            })
            self.collectionViewFour.visibleCells.forEach({ (view) in
                let cell = view as! VerticalViewControllerCell
                cell.isEdit = self.isEdit
            })
        }) { (finish) in
            completion()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension VerticalViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == collectionViewFour {
            return fptView.lgf_Style.lgf_Titles.count
        }
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        view.layer.zPosition = 0.0
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader && collectionView == collectionViewFour {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "VerticalViewControllerReusableView", for: indexPath) as! VerticalViewControllerReusableView
            header.title.text = fptView.lgf_Style.lgf_Titles[indexPath.section]
            if indexPath.section == 0 {
                header.lgfpt_Height = 0.0
            } else {
                header.lgfpt_Height = 40.0
            }
            return header
        }
        return UIView() as! UICollectionReusableView
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewOne {
            return 6
        } else if collectionView == collectionViewTwo {
            return latelyDataArray.count
        } else if collectionView == collectionViewThree {
            return 10
        } else if collectionView == collectionViewFive {
            return myDataArray.count
        }
        let items: [String] = dataArray[section].values.first!
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        if collectionView == collectionViewOne {
            return CGSize.init(width: collectionView.lgfpt_Width / 6.0, height: collectionView.lgfpt_Height)
        } else if (collectionView == self.collectionViewTwo) {
            return CGSize.init(width: UIDevice.lgf_ScreenW / 4.0, height: 140.0 / 2.0)
        } else if (collectionView == self.collectionViewThree) {
            return CGSize.init(width: collectionView.lgfpt_Width / 3.1, height: collectionView.lgfpt_Height)
        } else if (collectionView == self.collectionViewFive) {
            return CGSize.init(width: UIDevice.lgf_ScreenW / 4.0, height: 140.0 / 2.0)
        }
        return CGSize.init(width: UIDevice.lgf_ScreenW / 4.0, height: 140.0 / 2.0)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewOne {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalViewControllerOneCell", for: indexPath) as! VerticalViewControllerOneCell
            cell.imageName = myDataArray[indexPath.item]
            return cell
        } else if collectionView == collectionViewTwo {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalViewControllerCell", for: indexPath) as! VerticalViewControllerCell
            cell.title.text = latelyDataArray[indexPath.item]
            cell.isEdit = isEdit
            cell.imageName = cell.title.text
            return cell
        } else if collectionView == collectionViewThree {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalViewControllerThreeCell", for: indexPath) as! VerticalViewControllerThreeCell
            return cell
        } else if collectionView == collectionViewFive {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalViewControllerCell", for: indexPath) as! VerticalViewControllerCell
            cell.title.text = myDataArray[indexPath.item]
            cell.imageName = cell.title.text
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalViewControllerCell", for: indexPath) as! VerticalViewControllerCell
        cell.title.text = dataArray[indexPath.section].values.first?[indexPath.item]
        cell.isEdit = isEdit
        cell.imageName = cell.title.text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? VerticalViewControllerCell {
            self.view.makeToast(cell.title.text)
        } else {
            self.view.makeToast("点击了 cell")
        }
    }
}

extension VerticalViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionViewFour {
            pageSuperViewSuperView.lgfpt_Y = max(-18.0, isEdit ?  (scrollView.contentOffset.y + 250.0) : (scrollView.contentOffset.y - 8.0))
            collectionViewFiveBack.lgfpt_Y = min(max(-headerHeight, scrollView.contentOffset.y), scrollView.contentOffset.y)
            if (!self.isSelectTitle) {
                for (index, value) in pageSelectYArray.enumerated() {
                    let realY = isEdit ? (scrollView.contentOffset.y + 250.0 + 8.0) : scrollView.contentOffset.y
                    if (realY > CGFloat(value.first!) && realY < CGFloat(value.last!)) {
                        fptView.lgf_SelectIndex(index, 0.1, 0.25)
                    }
                }
            }
            self.collectionViewFour.visibleCells.forEach({ (view) in
                let cell = view as! VerticalViewControllerCell
                if cell.isEdit != self.isEdit {
                    cell.isEdit = self.isEdit
                }
            })
        }
    }
}

extension VerticalViewController: LGFSwiftPTDelegate {
    func lgf_SelectSwiftPTTitle(_ selectIndex: Int) {
        // 选中滚动
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(configIsSelectTitle), object: nil)
        isSelectTitle = true
        collectionViewFour.setContentOffset(CGPoint.init(x: 0.0, y: CGFloat(pageSelectYArray[selectIndex].first!) - (isEdit ? 250.0 + 8.0 : 0.0)), animated: true)
        perform(#selector(configIsSelectTitle), with: nil, afterDelay: 0.3)
    }
    
    @objc func configIsSelectTitle() {
        isSelectTitle = false
    }
}

