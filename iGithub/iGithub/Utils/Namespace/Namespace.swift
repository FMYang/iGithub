//
//  Namespace.swift
//  iGithub
//
//  Created by yfm on 2019/1/5.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

public protocol NamespaceWrappable {
    associatedtype WrapperType
    var sp: WrapperType { get set }
    static var sp: WrapperType.Type { get }
}

public extension NamespaceWrappable {
    var sp: NamespaceWrapper<Self> {
        get {
            return NamespaceWrapper(value: self)
        }
        set {}
    }

    static var sp: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

public struct NamespaceWrapper<Base> {
    public var wrappedValue: Base
    public init(value: Base) {
        self.wrappedValue = value
    }
}

import class Foundation.NSObject
extension NSObject: NamespaceWrappable {}

