//
//  UITableView+nib.swift
//  TuandaiLoan
//
//  Created by yfm on 2018/10/13.
//  Copyright © 2018年 com.tuandaiwang.www. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIView reusable protocol extension
protocol UIViewReusable {
    static var className: String {get}
}

extension UIViewReusable {
    static var className: String {
        return String(describing: self)
    }
}

extension UIView: UIViewReusable {}

// MARK: - extension UITableView
extension NamespaceWrapper where Base: UITableView {
    func registerCell<T: UIView>(cls: T.Type) {
        wrappedValue.register(cls, forCellReuseIdentifier: T.className)
    }

    func registerCellFromNib<T: UIView>(cls: T.Type) {
        wrappedValue.register(UINib.init(nibName: T.className, bundle: nil), forCellReuseIdentifier: T.className)
    }

    func registerCellFromNib<T: UIView>(cls: T.Type, identifier: String) {
        wrappedValue.register(UINib.init(nibName: T.className, bundle: nil), forCellReuseIdentifier: identifier)
    }

    func registerHeaderFooter<T: UIView>(cls: T.Type) {
        wrappedValue.register(cls, forHeaderFooterViewReuseIdentifier: T.className)
    }

    func registerHeaderFooterFromNib<T: UIView>(cls: T.Type) {
        wrappedValue.register(UINib.init(nibName: T.className, bundle: nil), forHeaderFooterViewReuseIdentifier: T.className)
    }

    func dequeueReuseCell<T: UIView>(_: T.Type, indexPath: IndexPath) -> T {
        guard let cell = wrappedValue.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Can't dequeue reuseable cell with identifier = \(T.className)")
        }
        return cell
    }

    func dequeueHeaderFooter<T: UIView>(_: T.Type) -> T {
        guard let view = wrappedValue.dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T else {
            fatalError("Can't dequeue reuseable HeaderFooterView with identifier = \(T.className)")
        }
        return view
    }
}

// MARK: - extension UIView

extension NamespaceWrapper where Base: UIView {
    static func loadNib() -> Base {
        let nibName = String(describing: Base.self)
        guard let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? Base else {
            fatalError("Can't load nib with name = \(nibName)")
        }
        return view
    }
}
