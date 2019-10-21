//
//  VerticalViewControllerOneCell.swift
//  LGFSwiftPTDemo
//
//  Created by 来 on 2019/10/20.
//  Copyright © 2019 laiguofeng. All rights reserved.
//

import UIKit

class VerticalViewControllerOneCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    var imageName: String! {
        didSet {
            self.image.image = UIImage.init(named: imageName)
        }
    }
}
