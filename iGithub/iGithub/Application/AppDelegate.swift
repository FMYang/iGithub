//
//  AppDelegate.swift
//  iGithub
//
//  Created by yfm on 2019/1/3.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import Foundation
import KafkaRefresh

fileprivate enum RootType {
    case login
    case tabbar
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KafkaRefreshDefaults.standard()?.headDefaultStyle = .replicatorWoody
        KafkaRefreshDefaults.standard()?.themeColor = UIColor.sp.theme_red
        AOP.swizzling()
        self.starLogic()
        return true
    }
}

extension AppDelegate {
    func starLogic() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        if AuthManager.share.tokenValidated {
            window?.rootViewController = TabbarController()
        } else {
            let loginVC = LoginViewController()
            window?.rootViewController = loginVC
        }
        window?.makeKeyAndVisible()
    }

    func loginSuccess() {
        let tabbarController = TabbarController()
        self.set(rootViewController: tabbarController, type: .tabbar)
    }

    func logout() {
        UserManager.share.remove()
        let loginVC = LoginViewController()
        self.set(rootViewController: loginVC, type: .login)
    }

   fileprivate func set(rootViewController viewController: UIViewController, type: RootType) {
        let transion = CATransition()
        transion.type = .push
        transion.subtype = (type == .login) ? .fromLeft : .fromRight
        window?.safeSet(rootViewController: viewController, withTransition: transion)
    }
}

