//
//  Aop.swift
//  iGithub
//
//  Created by yfm on 2019/1/15.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

extension UINavigationController {
    static func swizzling_pushViewController() {
        self.aop_ExchangeInstanceSelector(originalSelector: #selector(self.pushViewController(_:animated:)),
                                          swizzledSelector: #selector(self.aop_pushViewController(_:animated:)),
                                          cls: UINavigationController.self)
    }
}

extension UINavigationController {
    @objc func aop_pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        self.aop_pushViewController(viewController, animated: animated)

        if self.viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = false
        }
    }
}
