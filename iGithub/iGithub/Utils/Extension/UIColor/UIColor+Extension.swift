//
//  UIColor+Extension.swift
//  iGithub
//
//  Created by yfm on 2019/1/5.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(valueRGB: UInt) {
        self.init(
            red: CGFloat((valueRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((valueRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(valueRGB & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }

    static func color(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    /// create image by color
    ///
    /// - Parameter color: color
    /// - Returns: image
    static func createImage(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(color.cgColor)
        ctx?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

