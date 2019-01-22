//
//  UIWindow+Memory.swift
//  iGithub
//
//  Created by yfm on 2019/1/18.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

extension UIWindow {
    func set(rootViewController viewController: UIViewController) {
        let transion = CATransition()
        transion.type = .push
        transion.subtype = .fromRight
        self.safeSet(rootViewController: viewController, withTransition: transion)
    }

    func safeSet(rootViewController viewController: UIViewController, withTransition transition: CATransition? = nil) {

        self.rootViewController?.view.subviews.forEach { (view) in
            view.removeFromSuperview()
        }

        if let transition = transition {
            layer.add(transition, forKey: kCATransition)
        }

        self.rootViewController = viewController

        if let transiontinClass = NSClassFromString("UITransitionView") {
            for subView in subviews where subView.isKind(of: transiontinClass) {
                subView.removeFromSuperview()
            }
        }
    }
}
