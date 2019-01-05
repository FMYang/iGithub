//
//  File.swift
//  iGithub
//
//  Created by yfm on 2019/1/4.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import HandyJSON

struct Activity: HandyJSON  {
    var actor: Actor?
    var created_at: String?
    var id: Int?
    var org: Org?
    var payload: PayLoad?
    var repo: Repo?
    var type: String?
}

/// 用户信息
struct Actor: HandyJSON {
    var avatar_url: String?
    var display_login: String?
    var gravatar_id: String?
    var id: Int?
    var login: String?
    var url: String?
}

/// 组织信息
struct Org: HandyJSON {
    var avatar_url: String?
    var gravatar_id: String?
    var id: Int?
    var login: String?
    var url: String?
}

/// 仓库信息
struct Repo: HandyJSON {
    var id: Int?
    var name: String?
    var url: String?
}

/// 用户行为
struct PayLoad: HandyJSON {
    var action: String?
}
