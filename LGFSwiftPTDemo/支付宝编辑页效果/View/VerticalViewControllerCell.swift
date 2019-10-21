//
//  VerticalViewControllerCell.swift
//  LGFSwiftPTDemo
//
//  Created by 来 on 2019/10/20.
//  Copyright © 2019 laiguofeng. All rights reserved.
//

import UIKit

class VerticalViewControllerCell: UICollectionViewCell {
    @IBOutlet weak var editBack: UIView!
    @IBOutlet weak var deleteAndAdd: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    var imageName: String! {
        didSet {
            self.image.image = UIImage.init(named: imageName)
        }
    }
    var isEdit: Bool! {
        didSet {
            if isEdit {
                self.editBack.alpha = 1.0
                self.deleteAndAdd.transform = CGAffineTransform.identity
            } else {
                self.editBack.alpha = 0.0
                self.deleteAndAdd.transform = CGAffineTransform.init(scaleX: 0.00001, y: 0.00001)
            }
        }
    }
}
