//
//  HandyJSON+Rx.swift
//  iGithub
//
//  Created by yfm on 2019/1/4.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

extension ObservableType where E == Response {
    public func mapObject<T: HandyJSON>(type: T.Type) -> Observable<T?> {
        return flatMap({ (response) -> Observable<T?> in
            return Observable.just(response.mapObject(type: T.self))
        })
    }
    
    public func mapArray<T: HandyJSON>(type: T.Type) -> Observable<[T?]> {
        return flatMap({ (response) -> Observable<[T?]> in
            return Observable.just(response.mapArray(type: T.self))
        })
    }
}

extension Response {
    func mapObject<T: HandyJSON>(type: T.Type) -> T? {
        let json = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: json)
    }
    
    func mapArray<T: HandyJSON>(type: T.Type) -> [T?] {
        let json = String.init(data: data, encoding: .utf8)
        if let object = [T].deserialize(from: json) {
            return object
        }
        return []
    }
}
