//
//  File.swift
//  iGithub
//
//  Created by yfm on 2019/1/10.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

// https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/
// https://github.com/settings/applications/965464

let client_id = "5d9a014c274cbae38154"
let client_secret = "10ae9d865d9007d30e6376a79c0b21821f75702f"

let screen_width = UIScreen.main.bounds.width
let screen_height = UIScreen.main.bounds.height

let isIphoneX = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2436), (UIScreen.main.currentMode?.size)!) : false

let isIphoneXS = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 828, height: 1792), (UIScreen.main.currentMode?.size)!) : false

let isIphoneXSOrXR = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1242, height: 2688), (UIScreen.main.currentMode?.size)!) : false

let isIphoneXOrLater = (isIphoneX || isIphoneXS || isIphoneXSOrXR)

let IG_NaviHeight: CGFloat = isIphoneXOrLater ? 88 : 64
let IG_TabbarHeight: CGFloat = isIphoneXOrLater ? 83 : 49

let ig_pageSize = 30
