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
    var body: [String: Any]?
    var responseData: Any?
    var responseHttpHeaders: Any?
    var _error: Error?
    var httpStatusCode: Int = -1

    public func willSend(_ request: RequestType, target: TargetType) {
    }

    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            if let request = response.request {
                requestHttpHeaders = request.allHTTPHeaderFields ?? [:]
                requestUrl = request.url?.absoluteString ?? ""
                method = target.method.rawValue
                body = try? JSONSerialization.jsonObject(with: request.httpBody ?? Data()) as? [String: Any] ?? [:]
            }

            httpStatusCode = response.statusCode
            responseData = try? JSONSerialization.jsonObject(with: response.data)
            responseHttpHeaders = response.response
        case .failure(let error):
            if let request = error.response?.request {
                requestHttpHeaders = request.allHTTPHeaderFields ?? [:]
                requestUrl = request.url?.absoluteString ?? ""
                method = target.method.rawValue
                body = try? JSONSerialization.jsonObject(with: request.httpBody ?? Data()) as? [String: Any] ?? [:]
            }
            
            httpStatusCode = error.response?.statusCode ?? -1
            _error = error
        }

        networkLog(requestHttpHeader: requestHttpHeaders,
                   url: requestUrl,
                   body: body,
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
                    body: Any? = nil,
                    response: Any? = nil,
                    httpStatusCode: Int = -1,
                    responseHttpHeader: Any?,
                    error: Any? = nil) {
        var output: String = ""
        output += "======================== BEGIN REQUEST =========================\n\r"
        output += "request http header: \n\(requestHttpHeader)\n\r"
        output += "request url: \n\(url)\n\r"
        output += "request body: \n\(body ?? [:])\n\r"
        output += "http status code: \n\(httpStatusCode)\n\r"
        output += "response result: \n\(response ?? error ?? "")\n\r"
        output += "response http header: \n\(responseHttpHeader ?? "")\n\r"
        output += "======================== END REQUEST ===========================\n\r"
        print(output)
    }
}
