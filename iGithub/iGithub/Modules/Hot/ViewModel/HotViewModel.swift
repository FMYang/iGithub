//
//  HotViewModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/8.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import RxSwift

class HotViewModel {
    func fetchPopularRepo(q: String,
                          sort: String,
                          page: Int) -> Observable<[HotItemViewModel?]> {
        return Network.request(HotApi.searchPopular(q: q, sort: sort, page: page))
            .asObservable()
            .mapObject(type: RepoModel.self)
            .flatMap({ (repoModel) -> Observable<[HotItemViewModel?]> in
                let items = repoModel?.items.map { return $0.map { return HotItemViewModel(item: $0) }}
                return Observable.from(optional: items)
            })
    }
}
