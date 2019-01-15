//
//  ActivityApi.swift
//  iGithub
//
//  Created by yfm on 2019/1/4.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

enum ActivityApi {
    case publicEvent(userName: String, page: Int)
    case activityRepo(repoName: String)
}

extension ActivityApi: GithubTarget {
    var params: [String : Any]? {
        switch self {
        case .publicEvent(_, let page):
            return ["page": page]
        default:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .publicEvent(let userName, _):
            return "users/\(userName)/received_events/public"
        case .activityRepo(let repoName):
            return "repos/\(repoName)"
        }
    }
}
