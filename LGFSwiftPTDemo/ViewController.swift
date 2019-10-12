//
//  ViewController.swift
//  LGFSwiftPTDemo
//
//  Created by 来 on 2019/10/10.
//  Copyright © 2019 laiguofeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LGFSwiftPTDelegate {
    func lgf_SelectFreePTTitle(_ selectIndex: Int) {
        
    }
    
    var sview: UIView!
    
    var collectionView: UICollectionView!
    
    var freePT: LGFSwiftPTView!
    
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
        style.lgf_TitleFixedWidth = 50
        style.lgf_LineHeight = 5
        style.lgf_LineWidth = 5
        style.lgf_LineAnimation = .shortToLong
        style.lgf_LineWidthType = .equalTitleSTR
        style.lgf_StartDebug = true
        style.lgf_TitleTransformSX = 1.2
        
        freePT = LGFSwiftPTView.lgf(style, self, sview, collectionView)
        freePT.lgf_FreePTDelegate = self
        freePT.lgf_Style?.lgf_Titles = ["转入", "转出", "转入", "转出","转入", "转出","转入", "转出", "转出","转入", "转出","转入", "转出", "转出","转入", "转出","转入", "转出"]
        freePT.lgf_ReloadTitle()
        
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
        return freePT.lgf_Style?.lgf_Titles.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.lgfpt_RandomColor()
        return cell
    }
}

