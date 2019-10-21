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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("123123")
        
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 70, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 70), collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        view.addSubview(self.collectionView)
        
        sview = UIView.init(frame: CGRect.init(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 50))
        view.addSubview(sview)
        let style = LGFSwiftPTStyle()
        style.lgf_LineHeight = 5
        style.lgf_LineWidth = 20
        style.lgf_LineAnimation = .shortToLong
        style.lgf_LineWidthType = .equalTitleSTR
        style.lgf_StartDebug = true
        style.lgf_TitleTransformSX = 2.0
        style.lgf_PVAnimationType = .smallToBig
        style.lgf_TitleLeftRightSpace = 10
        
        let lab = UILabel.init()
        lab.lgfpt_SwiftPTSpecialTitleProperty = "4~~~100"
        lab.text = "来国锋"
        lab.textColor = UIColor.red
        style.lgf_SwiftPTSpecialTitleArray = [lab]
        
        swiftPT = LGFSwiftPT.lgf(style, self, sview, collectionView)
        swiftPT.lgf_SwiftPTDelegate = self
        swiftPT.lgf_Style?.lgf_Titles = ["转入", "转出转闪电", "转入", "出", "", "转出", "转出", "转出", "转出", "转出", "转出", "转出", "转出"]
        swiftPT.lgf_ReloadTitle()
        
        view.bringSubviewToFront(showAliPayBtn)
    }
    
    
    @IBAction func showAliPay(_ sender: Any) {
        let vc = UIStoryboard.init(name: "VerticalViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "VerticalViewController")
        self.navigationController?.pushViewController(vc, animated: true)
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
        return swiftPT.lgf_Style?.lgf_Titles.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.lgfpt_RandomColor()
        return cell
    }
}

