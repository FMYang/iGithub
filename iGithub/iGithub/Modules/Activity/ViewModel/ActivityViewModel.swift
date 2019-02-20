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

    func fetchPublicEvents(page: Int) -> Observable<[Activity?]> {
        return
            Network.request(ActivityApi.publicEvent(userName: UserManager.share.userName,
                                                    page: page))
                .asObservable()
                .mapArray(type: Activity.self)
                .catchErrorJustReturn([])
    }

    func fetchActivityAndRepo(page: Int) -> Observable<[ActivityCellViewModel?]> {
        let activitys = fetchPublicEvents(page: page)
        
        // [event] -> [repo.name] -> [RepoDetail]
        let repos = activitys.map { return $0.map { return $0?.repo?.name } }
            .flatMap { (urls) -> Observable<String?> in
                return Observable.from(urls)
            }
            .flatMap { (url) -> Observable<RepoItem?> in
                return Network.request(ActivityApi.activityRepo(repoName:url!))
                    .asObservable()
                    .mapObject(type: RepoItem.self)
                    .catchErrorJustReturn(nil)
            }
            .toArray()
        
        // [event] + [RepoDetail] -> [ActivityCellViewModel]
        return Observable.zip(activitys, repos)
            .flatMap { (object) -> Observable<[ActivityCellViewModel?]> in
                var cellModels = [ActivityCellViewModel]()
                let (activity, repo) = object
                
                // match activity and repo，make sure data correct, because async request is unordered
                activity.forEach {
                    var matchRepo: RepoItem?
                    let id = $0?.repo?.id
                    repo.forEach {
                        if $0?.id == id {
                            matchRepo = $0
                        }
                    }
                    if let repo = matchRepo {
                        let obj = ActivityCellViewModel(activity: $0, repo: repo)
                        cellModels.append(obj)
                    }
                }

                return Observable.from(optional: cellModels)
            }
    }
}
