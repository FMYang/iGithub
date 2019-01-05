//
//  UIView+Extension.swift
//  iGithub
//
//  Created by yfm on 2019/1/5.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import UIKit

extension NamespaceWrapper where Base: UIView {
    public var left: CGFloat {
        get {
            return wrappedValue.frame.origin.x
        }
        set(newValue) {
            wrappedValue.frame.origin.x = CGFloat(newValue)
        }
    }

    public var top: CGFloat {
        get {
            return wrappedValue.frame.origin.y
        }
        set(newValue) {
            wrappedValue.frame.origin.y = CGFloat(newValue)
        }
    }

    public var right: CGFloat {
        get {
            return wrappedValue.frame.origin.x + wrappedValue.frame.size.width
        }
        set(newValue) {
            wrappedValue.frame.origin.x = CGFloat(newValue) - wrappedValue.frame.size.width
        }
    }

    public var bottom: CGFloat {
        get {
            return wrappedValue.frame.origin.y + wrappedValue.frame.size.height
        }
        set(newValue) {
            wrappedValue.frame.origin.y = CGFloat(newValue) - wrappedValue.frame.size.height
        }
    }

    public var width: CGFloat {
        get {
            return wrappedValue.frame.size.width
        }
        set(newValue) {
            wrappedValue.frame.size.width = CGFloat(newValue)
        }
    }

    public var height: CGFloat {
        get {
            return wrappedValue.frame.size.height
        }
        set(newValue) {
            wrappedValue.frame.size.height = CGFloat(newValue)
        }
    }

    public var centerX: CGFloat {
        get {
            return wrappedValue.center.x
        }
        set(newValue) {
            wrappedValue.center = CGPoint(x: newValue, y: wrappedValue.center.y)
        }
    }

    public var centerY: CGFloat {
        get {
            return wrappedValue.center.y
        }
        set(newValue) {
            wrappedValue.center = CGPoint(x: wrappedValue.center.x, y: newValue)
        }
    }

    public var origin: CGPoint {
        get {
            return wrappedValue.frame.origin
        }
        set(newValue) {
            wrappedValue.frame.origin = newValue
        }
    }

    public var size: CGSize {
        get {
            return wrappedValue.frame.size
        }
        set(newValue) {
            wrappedValue.frame.size = newValue
        }
    }
}
