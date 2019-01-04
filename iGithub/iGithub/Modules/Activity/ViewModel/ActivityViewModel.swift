//
//  ActivityViewModel.swift
//  iGithub
//
//  Created by 杨方明 on 2019/1/4.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import RxSwift

class ActivityViewModel {
    func fetchPublicEvents() -> Observable<[Activity?]> {
        return
            Network.request(ActivityApi.publicEvent(userName: "FMYang"))
                .asObservable()
                .mapArray(type: Activity.self)
    }
}
