//
//  UIView+HUD.swift
//  iGithub
//
//  Created by yfm on 2019/1/18.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import MBProgressHUD

private var hudKey = "com.iGithub.hud"

extension NamespaceWrapper where Base: UIView {

    mutating func showLoading(_ title: String?) {
        if let text = title {
            let hud = MBProgressHUD.showAdded(to: wrappedValue, animated: true)
            ig_hud = hud
            hud.bezelView.style = .solidColor
            hud.bezelView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            hud.contentColor = .white
            hud.label.text = text
            hud.removeFromSuperViewOnHide = true
        }
    }

    func hideLoading() {
        guard let hud = ig_hud else { return }
        hud.hide(animated: true, afterDelay: 0.25)
    }

    func hideWithMessage(title: String) {
        guard let hud = ig_hud else { return }
        hud.mode = .text
        hud.label.text = title
        hud.hide(animated: true, afterDelay: 2)
    }

    func showToast(_ title: String?) {
        if let text = title {
            let hud = MBProgressHUD.showAdded(to: wrappedValue, animated: true)
            hud.mode = .text
            hud.label.text = text
            hud.hide(animated: true, afterDelay: 2.0)
            hud.removeFromSuperViewOnHide = true
        }
    }

    var ig_hud: MBProgressHUD? {
        get {
            return objc_getAssociatedObject(wrappedValue, &hudKey) as? MBProgressHUD
        }
        set {
            objc_setAssociatedObject(wrappedValue, &hudKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
