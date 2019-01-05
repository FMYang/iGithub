//
//  ActivityViewModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/4.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import RxSwift

class ActivityViewModel {

    func fetchPublicEvents() -> Observable<[Activity?]> {
        return
            Network.request(ActivityApi.publicEvent(userName: "Leeeyou"))
                .asObservable()
                .mapArray(type: Activity.self)
//                .map { return $0.map { return ActivityCellViewModel.init(model: $0) } }
//                .catchErrorJustReturn([])
    }

    func transformToRepo() {
        let activitys = fetchPublicEvents()

        // [activity] -> [repo.url]
        let repos = activitys.map { return $0.map { return $0?.repo?.name } }
            .flatMap { (urls) -> Observable<String?> in
                return Observable.from(urls)
            }
            .flatMap({ (url) -> Observable<Repo?> in
                return Network.request(ActivityApi.activityRepo(repoName: url!))
                    .asObservable()
                    .mapObject(type: Repo.self)
            })
            .toArray()

        Observable.zip(activitys, repos).subscribe {
            let (a, b) = $0.element!
//            let a = result.0
//            let b = result.1
            print(a)
            print(b)
        }
    }
}
