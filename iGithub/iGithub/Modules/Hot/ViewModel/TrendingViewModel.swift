//
//  TrendingViewModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/11.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

class TrendingViewModel {
    func fetchTrending() -> Observable<[TrendingCellViewModel?]> {
        return Network.request(HotApi.trending(since: "weekly"))
            .asObservable()
            .mapArray(type: TrendingRepo.self)
            .flatMap({ (repos) -> Observable<[TrendingCellViewModel?]> in
                let cellVMs = repos.map { return $0.map { return TrendingCellViewModel(model: $0)} }
                return Observable.from(optional: cellVMs)
            })
    }
}
