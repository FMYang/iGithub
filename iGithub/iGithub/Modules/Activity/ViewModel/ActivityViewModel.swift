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
            Network.request(ActivityApi.publicEvent(userName: "FMYang"))
                .asObservable()
                .mapArray(type: Activity.self)
    }

    func fetchActivityAndRepo() -> Observable<[ActivityCellViewModel?]> {
        let activitys = fetchPublicEvents()

        // [activity] -> [repo.name] -> [RepoDetail]
        let repos = activitys.map { return $0.map { return $0?.repo?.name } }
            .flatMap { (urls) -> Observable<String?> in
                return Observable.from(urls)
            }
            .flatMap({ (url) -> Observable<ActivityListRepoDetail?> in
                return Network.request(ActivityApi.activityRepo(repoName:
                    url!))
                    .asObservable()
                    .mapObject(type: ActivityListRepoDetail.self)
            })
            .toArray()

        // [activity] + [RepoDetail] -> [ActivityCellViewModel]
        return Observable.zip(activitys, repos)
            .flatMap { (object) -> Observable<[ActivityCellViewModel?]> in
                var cellModels = [ActivityCellViewModel]()
                let (activity, repo) = object
                for i in 0..<activity.count {
                    let obj = ActivityCellViewModel(activity: activity[i], repo: repo[i])
                    cellModels.append(obj)
                }
                return Observable.from(optional: cellModels)
            }
        
    }
}
