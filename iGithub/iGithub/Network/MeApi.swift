//
//  MeApi.swift
//  iGithub
//
//  Created by yfm on 2019/1/17.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

enum MeApi {
    case listRepos(userName: String, page: Int)
    case listFollowers(userName: String, page: Int)
    case listFollowing(userName: String, page: Int)
    case user(userName: String)
}

extension MeApi: GithubTarget {
    var params: [String : Any]? {
        switch self {
        case .listRepos(_, let page):
            return ["page": page]
        case let .listFollowers(_, page):
            return ["page": page]
        case let .listFollowing(_, page):
            return ["page": page]
        default:
            return [:]
        }
    }

    var path: String {
        switch self {
        case .listRepos(let userName, _):
            return "users/\(userName)/repos"
        case .listFollowers(let userName, _):
            return "users/\(userName)/followers"
        case .listFollowing(let userName, _):
            return "users/\(userName)/following"
        case .user(let userName):
            return "users/\(userName)"
        }
    }
}
