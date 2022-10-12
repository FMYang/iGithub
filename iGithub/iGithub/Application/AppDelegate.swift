//
//  AppDelegate.swift
//  iGithub
//
//  Created by yfm on 2019/1/3.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import Foundation
import WebKit

fileprivate enum RootType {
    case login
    case tabbar
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AOP.swizzling()
        UIView.configRefreshStyle()
        self.starLogic()
        return true
    }
}

extension AppDelegate {
    func starLogic() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        if AuthManager.share.tokenValidated {
            let tabbarController = TabbarController()
            window?.rootViewController = tabbarController
        } else {
            let loginVC = LoginViewController()
            window?.rootViewController = loginVC
        }
        window?.makeKeyAndVisible()
    }

    func loginSuccess() {
        let tabbarController = TabbarController()
        window?.rootViewController = tabbarController
//        self.set(rootViewController: tabbarController, type: .tabbar)
    }

    func logout() {
        UserManager.share.remove()
        cleanWebCookie()
        let loginVC = LoginViewController()
        window?.rootViewController = loginVC
//        self.set(rootViewController: loginVC, type: .login)
    }

    fileprivate func set(rootViewController viewController: UIViewController, type: RootType) {
        let transion = CATransition()
        transion.type = .push
        transion.subtype = (type == .login) ? .fromLeft : .fromRight
        window?.safeSet(rootViewController: viewController, withTransition: transion)
    }
}

extension AppDelegate {
    func cleanWebCookie() {
        let store = WKWebsiteDataStore.default()
        store.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            records.forEach { (record) in
                store.removeData(ofTypes: record.dataTypes, for: [record]) {
                    print("delete cookie success!")
                }
            }
        }
    }
}

