//
//  Api.swift
//  iGithub
//
//  Created by yfm on 2019/1/4.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import Moya

protocol GithubTarget: TargetType {
    var params: [String: Any]? {get}
    var moyaMethod: Moya.Method {get}
}

extension GithubTarget {
    var moyaMethod: Moya.Method {
        return .get
    }

    var params: [String: Any]? {
        return [:]
    }

    var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }

    var method: Moya.Method {
        return moyaMethod
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch method {
        case .get:
            guard let params = self.params else { return .requestPlain }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: params ?? [:], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
