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

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.created_at <-- TransformOf(fromJSON: { (rawString) -> String? in
                print("raw str \(rawString ?? "")")
                return rawString
            }, toJSON: { (str) -> String? in
                print("new str \(str ?? "")")
                return str
            })
    }
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

struct RepoDetail: HandyJSON {
    var description: String?
    var stargazers_count: Int = 0
    var language: String?
    var updated_at: String?
}
