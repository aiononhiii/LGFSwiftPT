//
//  LGF+UIColor.swift
//  LGFFreePTDemo-swift
//
//  Created by apple on 2019/7/26.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIColor {
    
    // MARK: - hex 16 进制颜色 传入(Int) 0x000000
    convenience init(lgf_Hex: Int, _ lgf_Alpha: Double = 1.0) {
        let r = CGFloat((lgf_Hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((lgf_Hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(lgf_Hex & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: CGFloat(lgf_Alpha))
    }
    
    // MARK: - hex 16 进制颜色 传入(String) "000000"
    convenience init?(lgf_HexString: String, _ lgf_Alpha: Double = 1.0) {
        let scanner = Scanner(string: lgf_HexString.replacingOccurrences(of: "#", with: ""))
        var rgbHex: UInt32 = 0
        guard scanner.scanHexInt32(&rgbHex) else {
            return nil
        }
        self.init(lgf_Hex: Int(rgbHex), lgf_Alpha)
    }
    
    // MARK: - rgb a
    @nonobjc
    convenience init(_ lgf_Red: Int, _ lgf_Green: Int, _ lgf_Blue: Int, _ lgf_Alpha: Double = 1.0) {
        self.init(red: CGFloat(lgf_Red) / 255, green: CGFloat(lgf_Green) / 255, blue: CGFloat(lgf_Blue) / 255, alpha: CGFloat(lgf_Alpha))
    }
    
    // MARK: -  随机颜色
    class func lgf_RandomColor() -> UIColor {
        return UIColor.init(Int(arc4random() % 256 / 255), Int(arc4random() % 256 / 255), Int(arc4random() % 256 / 255))
    }
    
    // MARK: -  随机灰度颜色
    class func lgf_RandomGrayColor() -> UIColor {
        let randomNumber = (Int(arc4random() % 200) + 55) / 255
        return UIColor.init(randomNumber, randomNumber, randomNumber)
    }
}

public extension UIColor {
    struct Components {
        var _base: UIColor
        public var rgba: (CGFloat, CGFloat, CGFloat, CGFloat) {
            var r: CGFloat = 0; var g: CGFloat = 0; var b: CGFloat = 0; var a: CGFloat = 0
            _base.getRed(&r, green: &g, blue: &b, alpha: &a)
            return (r, g, b, a)
        }
        public var hsv: (CGFloat, CGFloat, CGFloat) {
            var h: CGFloat = 0; var s: CGFloat = 0; var v: CGFloat = 0; var a: CGFloat = 0
            _base.getHue(&h, saturation: &s, brightness: &v, alpha: &a)
            return (h, s, v)
        }
    }
    var components: UIColor.Components {
        return Components(_base: self)
    }
}

#endif // canImport(UIKit)
