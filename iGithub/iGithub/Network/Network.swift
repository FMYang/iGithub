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
        urlRequest.timeoutInterval = 30
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
                var httpStatusCode: Int = 0
                switch result {
                case .success(let response):
                    data = try? JSONSerialization.jsonObject(with: response.data)
                    httpStatusCode = response.statusCode
                    do {
                        // filter http status code
                        let response = try response.filterSuccessfulStatusCodes()
                        observer.onNext(response)
                        observer.onCompleted()
                    } catch {
                        // http request fails
                        self.showAlert(String(describing: httpStatusCode), message: error.localizedDescription)
                        observer.onError(error)
                    }
                case .failure(let error):
                    httpStatusCode = error.response?.statusCode ?? 0
                    data = error.errorDescription
                    errorResult = error
                    self.showAlert(String(describing: httpStatusCode), message: error.localizedDescription)
                    observer.onError(error)
                }
                networkLog(url: target.baseURL.absoluteString + target.path, params: target.params, response: data, error: errorResult, httpStatusCode: httpStatusCode)
            })
            return Disposables.create()
        })
    }

    static func showAlert(_ title: String = "",
                          message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "confirm", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(confirmAction)
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
