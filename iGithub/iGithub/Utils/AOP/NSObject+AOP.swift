//
//  NSObject+AOP.swift
//  iGithub
//
//  Created by yfm on 2019/1/15.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

extension NSObject {
    static func aop_ExchangeInstanceSelector(originalSelector: Selector,
                                             swizzledSelector: Selector,
                                             cls: AnyClass)  {
        let originalMethod = class_getInstanceMethod(cls, originalSelector)
        let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
        let originalIMP = method_getImplementation(originalMethod!)
        let swizzledIMP = method_getImplementation(swizzledMethod!)

        let success = class_addMethod(cls, originalSelector, swizzledIMP, method_getTypeEncoding(swizzledMethod!))
        if success {
            class_replaceMethod(cls, swizzledSelector, originalIMP, method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}
