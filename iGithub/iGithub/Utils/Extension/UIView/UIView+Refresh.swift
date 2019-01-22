//
//  UIView+Refresh.swift
//  iGithub
//
//  Created by yfm on 2019/1/18.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import KafkaRefresh

extension UIView {
    static func configRefreshStyle() {
        KafkaRefreshDefaults.standard()?.headDefaultStyle = .replicatorWoody
        KafkaRefreshDefaults.standard()?.themeColor = UIColor.sp.theme_red
    }
}
