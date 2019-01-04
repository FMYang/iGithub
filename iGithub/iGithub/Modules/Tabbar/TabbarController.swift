//
//  TabbarController.swift
//  iGithub
//
//  Created by yfm on 2019/1/3.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

enum ItemType {
    case activity
    case hot
    case me

    var itemTitle: String {
        switch self {
        case .activity:
            return "Activity"
        case .hot:
            return "Hot"
        case .me:
            return "Me"
        }
    }

    var itemNormalIcon: UIImage? {
        switch self {
        case .activity:
            return UIImage(named: "tabbar-activity-normal")?.withRenderingMode(.alwaysOriginal)
        case .hot:
            return UIImage(named: "tabbar-hot-normal")?.withRenderingMode(.alwaysOriginal)
        case .me:
            return UIImage(named: "tabbar-me-normal")?.withRenderingMode(.alwaysOriginal)
        }
    }

    var itemSelectedIcon: UIImage? {
        switch self {
        case .activity:
            return UIImage(named: "tabbar-activity-selected")?.withRenderingMode(.alwaysOriginal)
        case .hot:
            return UIImage(named: "tabbar-hot-selected")?.withRenderingMode(.alwaysOriginal)
        case .me:
            return UIImage(named: "tabbar-me-selected")?.withRenderingMode(.alwaysOriginal)
        }
    }

    func getController() -> UIViewController {
        let item = UITabBarItem(title: self.itemTitle,
                                image: self.itemNormalIcon,
                                selectedImage: self.itemSelectedIcon)
        let vc: UIViewController
        switch self {
        case .activity:
            vc = ActivityViewController()
        case .hot:
            vc = HotViewController()
        case .me:
            vc = MeViewController()
        }
        vc.tabBarItem = item
        return UINavigationController(rootViewController: vc)
    }
}

class TabbarController: UITabBarController {

    private let items: [ItemType] = [.activity,
                                   .hot,
                                   .me]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = items.map { $0.getController() }
        appearance()
    }

    func appearance() {
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor : UIColor.red], for: .selected)
    }
}
