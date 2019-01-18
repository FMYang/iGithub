//
//  UIViewController+AOP.swift
//  iGithub
//
//  Created by yfm on 2019/1/18.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

protocol BaseViewControllerProtocol {
    var backButton: UIBarButtonItem { get }
}

extension UIViewController {
    static func swizzling_viewDidLoad() {
        self.aop_ExchangeInstanceSelector(originalSelector: #selector(self.viewDidLoad),
                                          swizzledSelector: #selector(self.aop_viewDidLoad),
                                          cls: UIViewController.self)
    }


    @objc func aop_viewDidLoad() {
        self.aop_viewDidLoad()

        if let count = self.navigationController?.viewControllers.count, count > 1 {
            self.navigationItem.leftBarButtonItem = backButton
        }
    }
}

extension UIViewController: BaseViewControllerProtocol {
    var backButton: UIBarButtonItem {
        let backButton = UIButton()
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        backButton.setImage(UIImage(named: "icon-back-arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        let item = UIBarButtonItem(customView: backButton)
        return item
    }

    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
