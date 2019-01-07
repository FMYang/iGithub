//
//  UIImage+Round.swift
//  iGithub
//
//  Created by yfm on 2019/1/7.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func rounded() -> UIImage {
        let rect = CGRect(origin: .zero, size: self.size)
        UIGraphicsBeginImageContext(self.size)
        UIBezierPath(roundedRect: rect, cornerRadius: rect.size.height/2).addClip()
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
