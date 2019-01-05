//
//  Network.swift
//  iGithub
//
//  Created by yfm on 2019/1/4.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import Moya
import RxSwift

let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<MultiTarget>.RequestResultClosure) in
    do {
        var urlRequest = try endpoint.urlRequest()
        print("request url: \(urlRequest)")
        urlRequest.timeoutInterval = 20
        done(.success(urlRequest))
    } catch MoyaError.requestMapping(let url) {
        done(.failure(MoyaError.requestMapping(url)))
    } catch MoyaError.parameterEncoding(let error) {
        done(.failure(MoyaError.parameterEncoding(error)))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

let provider = MoyaProvider<MultiTarget>(requestClosure: requestClosure)

/// 网路请求日志打印
///
/// - Parameters:
///   - url: 请求URL
///   - params: 请求参数
///   - response: 返回成功结果
///   - error: 返回错误
///   - statusCode: HTTP状态码
func networkLog(url: String,
                params: Any? = nil,
                response: Any? = nil,
                error: Any? = nil,
                httpStatusCode: Int = 404) {
    var output: String = ""
    output += "======================== BEGIN REQUEST =========================\n\r"
    output += "request url: \n\(url)\n\r"
    output += "request params: \n\(params ?? "nil")\n\r"
    output += "http status code: \n\(httpStatusCode)\n\r"
    output += "response result: \n\(response ?? error ?? "")\n\r"
    output += "======================== END REQUEST ===========================\n\r"
    print(output)
}

class Network {
    /// 网络请求方法
    ///
    /// - Parameter target: 目标target
    /// - Returns: Observable<Response>
    static func request(_ target: GithubTarget) -> Observable<Response> {
        return Observable.create({ (observer) -> Disposable in
            provider.request(MultiTarget(target), completion: { result in
                var data: Any?
                var errorResult: Error?
                var httpStatusCode: Int?
                switch result {
                case .success(let response):
                    data = try? JSONSerialization.jsonObject(with: response.data)
                    httpStatusCode = response.statusCode
                    do {
                        let response = try response.filterSuccessfulStatusCodes()
                        observer.onNext(response)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                case .failure(let error):
                    httpStatusCode = error.response?.statusCode
                    data = error.errorDescription
                    errorResult = error
                    observer.onError(error)
                }
                networkLog(url: target.baseURL.absoluteString + target.path, params: target.params, response: data, error: errorResult, httpStatusCode: httpStatusCode ?? 404)
            })
            return Disposables.create()
        })
    }
}
