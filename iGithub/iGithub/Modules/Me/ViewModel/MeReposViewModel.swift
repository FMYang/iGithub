//
//  MeReposViewModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/17.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

class MeReposViewModel {
    
    func fetchUserRepos() -> Observable<[PopularItemViewModel?]> {
        return Network.request(MeApi.listRepos(userName: "FMYang", page: 1))
            .asObservable()
            .mapArray(type: RepoItem.self)
            .flatMap { (items) -> Observable<[PopularItemViewModel?]> in
                let itemViewModels = items.map { return PopularItemViewModel(item: $0) }
                return Observable.from(optional: itemViewModels)
            }

    }
}
