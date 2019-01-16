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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KafkaRefreshDefaults.standard()?.headDefaultStyle = .replicatorWoody
        KafkaRefreshDefaults.standard()?.themeColor = UIColor.sp.theme_red
        UINavigationController.swizzing()
        self.starLogic()
        return true
    }
}

extension AppDelegate {
    func starLogic() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        if AuthManager.share.tokenValidated {
            window?.rootViewController = TabbarController.share
        } else {
            let loginVC = LoginViewController()
            window?.rootViewController = loginVC
        }
        window?.makeKeyAndVisible()
    }

    func loginSuccess() {
        TabbarController.share.selectedIndex = 0
        window?.rootViewController = TabbarController.share
        window?.makeKeyAndVisible()
    }

    func logout() {
        UserManager.share.remove()
        let loginVC = LoginViewController()
        window?.rootViewController = loginVC
    }
}

