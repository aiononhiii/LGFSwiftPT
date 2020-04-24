//
//  ViewController.swift
//  LGFSwiftPTDemo
//
//  Created by 来 on 2019/10/10.
//  Copyright © 2019 laiguofeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LGFSwiftPTDelegate {
    
    @IBOutlet weak var showAliPayBtn: UIButton!
    
    func lgf_SelectSwiftPTTitle(_ selectIndex: Int) {
        
    }
    
    func lgf_RealSelectSwiftPTTitle(_ selectIndex: Int) {
        debugPrint(selectIndex)
    }
    
    var sview: UIView!
    
    var collectionView: UICollectionView!
    
    var swiftPT: LGFSwiftPT!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            UIApplication.shared.statusBarStyle = .lightContent
        } else {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 190, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 70), collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        view.addSubview(self.collectionView)
        
        sview = UIView.init(frame: CGRect.init(x: 0, y: 150, width: 300, height: 40))
        view.addSubview(sview)
        
        creatSwiftPT()
        
        view.bringSubviewToFront(showAliPayBtn)
        
    }
    
    func creatSwiftPT() {
        let style = LGFSwiftPTStyle()
        style.lgf_LineHeight = 5
        style.lgf_LineWidth = 20
        style.lgf_LineAnimation = .defult
        style.lgf_LineWidthType = .fixedWith
//        style.lgf_StartDebug = true
        style.lgf_MainTitleTransformSX = 1.2
        style.lgf_PVAnimationType = .topToBottom
        style.lgf_TitleScrollFollowType = .leftRight
        style.lgf_TitleLeftRightSpace = 10
        style.lgf_IsHaveCenterLine = true
        style.lgf_CenterLineSize = CGSize.init(width: 1, height: 10)
        // 自定义特殊标
        let lab = UILabel.init()
        lab.lgfpt_SwiftPTSpecialTitleProperty = "4~~~120"// 4 添加到对应下标， 100 宽度
        lab.text = "我是特殊标"
        lab.textAlignment = .center
        lab.textColor = UIColor.white
        lab.font = UIFont.boldSystemFont(ofSize: 15)
        style.lgf_SwiftPTSpecialTitleArray = [lab]
        
        style.lgf_Titles = ["转入", "转出转闪电", "转入", "出", "", "转出", "转出", "转出", "转出", "转出", "转出", "转出", "转出"] // 这两句可以随意替换设置
        
        swiftPT = LGFSwiftPT.lgf(style, self, sview, collectionView)
        swiftPT.lgf_SwiftPTDelegate = self
//        swiftPT.lgf_Style.lgf_Titles = ["转入", "转出转闪电", "转入", "出", "", "转出", "转出", "转出", "转出", "转出", "转出", "转出", "转出"]// 这两句可以随意替换设置
        swiftPT.lgf_ReloadTitle()// 这句必须设置，不然不刷新 swiftPT 的 UI，也可用来随时替换新的数据源（替换时如果你关联了外部 collectionview ，记得也同时修改你自己定义的外部 collectionview 的数据源防止数组越界）
    }
    
    
    @IBAction func showAliPay(_ sender: Any) {
        let vc = UIStoryboard.init(name: "VerticalViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "VerticalViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 特殊分割线可以用这个代理来实现
    func lgf_GetLGFSwiftPTCenterLine(_ centerLine: UIView, _ index: Int, _ style: LGFSwiftPTStyle, _ X: NSLayoutConstraint, _ Y: NSLayoutConstraint, _ W: NSLayoutConstraint, _ H: NSLayoutConstraint) {
        if index == 8 {
            centerLine.backgroundColor = UIColor.red
            W.constant = 10
            X.constant = -5
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        return collectionView.lgfpt_Size
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return swiftPT.lgf_Style.lgf_Titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.lgfpt_RandomColor()
        return cell
    }
}

