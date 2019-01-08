//
//  NetworkLogPlugin.swift
//  iGithub
//
//  Created by yfm on 2019/1/8.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import Moya
import Result

public final class NetworkLogPlugin: PluginType {

    var requestHttpHeaders: [String: Any] = [:]
    var requestUrl: String = ""
    var method: String = "Get"
    var params: [String: Any] = [:]
    var responseData: Any?
    var responseHttpHeaders: Any?
    var _error: Error?
    var httpStatusCode: Int = -1

    public func willSend(_ request: RequestType, target: TargetType) {
        if let request = request.request {
            requestHttpHeaders = request.allHTTPHeaderFields ?? [:]
            requestUrl = target.baseURL.absoluteString + target.path
            method = target.method.rawValue
            params = (target as? GithubTarget)?.params ?? [:]
        }
    }

    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            httpStatusCode = response.statusCode
            responseData = try? JSONSerialization.jsonObject(with: response.data)
            responseHttpHeaders = response.response
        case .failure(let error):
            httpStatusCode = error.response?.statusCode ?? -1
            _error = error
        }

        networkLog(requestHttpHeader: requestHttpHeaders,
                   url: requestUrl,
                   params: params,
                   response: responseData,
                   httpStatusCode: httpStatusCode,
                   responseHttpHeader: responseHttpHeaders,
                   error: _error)
    }

    /// network log
    ///
    /// - Parameters:
    ///   - requestHttpHeader: request http headers
    ///   - url: request url
    ///   - params: request params
    ///   - response: response
    ///   - httpStatusCode: http status code
    ///   - responseHttpHeader: response http headers
    ///   - error: error
    func networkLog(requestHttpHeader: [String: Any],
                    url: String,
                    params: Any? = nil,
                    response: Any? = nil,
                    httpStatusCode: Int = -1,
                    responseHttpHeader: Any?,
                    error: Any? = nil) {
        var output: String = ""
        output += "======================== BEGIN REQUEST =========================\n\r"
        output += "request http header: \n\(requestHttpHeader)\n\r"
        output += "request url: \n\(url)\n\r"
        output += "request params: \n\(params ?? "nil")\n\r"
        output += "http status code: \n\(httpStatusCode)\n\r"
        output += "response result: \n\(response ?? error ?? "")\n\r"
        output += "response http header: \n\(responseHttpHeader ?? "")\n\r"
        output += "======================== END REQUEST ===========================\n\r"
        print(output)
    }
}
