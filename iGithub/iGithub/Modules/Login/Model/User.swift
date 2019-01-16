//
//  User.swift
//  iGithub
//
//  Created by yfm on 2019/1/14.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import HandyJSON

struct User: HandyJSON {
    var avatar_url: String?
    var bio: String?
    var blog: String?
    var collaborators: Int?
    var company: String?
    var created_at: String?
    var disk_usage: String?
    var email: String?
    var events_url: String?
    var followers: Int?
    var followers_url: String?
    var following: Int?
    var following_url: String?
    var gists_url: String?
    var gravatar_id: String?
    var hireable: String?
    var html_url: String?
    var id: Int?
    var location: String?
    var login: String?
    var name: String?
    var node_id: String?
    var organizations_url: String?
    var owned_private_repos: Int?
    var plan: Plan?
    var private_gists: Int?
    var public_gists: Int?
    var public_repos: Int?
    var received_events_url: String?
    var repos_url: String?
    var site_admin: String?
    var starred_url: String?
    var subscriptions_url: String?
    var total_private_repos: Int?
    var two_factor_authentication: Int?
    var type: String?
    var updated_at: String?
    var url: String?
    
//    mutating func mapping(mapper: HelpingMapper) {
//        mapper <<<
//            self.created_at <-- TransformOf(fromJSON: { (rawString) -> String? in
//                let timeNow = rawString?.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'")?.toString(dateFormat: "yyyy-MM-dd HH:mm:ss")
//                return timeNow
//            }, toJSON: { (str) -> String? in
//                return str
//            })
//    }
}

struct Plan: HandyJSON {
    var collaborators: Int?
    var name: String?
    var private_repos: Int?
    var space: Int?
}
