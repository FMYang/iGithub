//
//  AOP.swift
//  iGithub
//
//  Created by yfm on 2019/1/18.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

class AOP {
    static func swizzling() {
        UINavigationController.swizzling_pushViewController()
        UIViewController.swizzling_viewDidLoad()
    }
}
