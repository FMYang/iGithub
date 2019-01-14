//
//  HotApi.swift
//  iGithub
//
//  Created by yfm on 2019/1/8.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import Moya

enum HotApi {
    case searchPopular(q: String, sort: String, page: Int)
    case trending(since: String)
}

extension HotApi: GithubTarget {

    var baseURL: URL {
        switch self {
        case .trending:
            return URL(string: "https://github-trending-api.now.sh/")!
        default:
            return URL(string: "https://api.github.com/")!
        }
    }

    var params: [String : Any]? {
        switch self {
        case let .searchPopular(q, sort, page):
            return ["q": "stars:>1 language:\(q)",
                    "sort": sort,
                    "page": page]
        case .trending(let since):
            return ["language": "All languages",
                    "since": since]
        }
    }

    var path: String {
        switch self {
        case .searchPopular:
            return "search/repositories"
        case .trending:
            return "repositories"
        }
    }
}
