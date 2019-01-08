//
//  HotViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/3.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class HotViewController: UIViewController {

    let bag = DisposeBag()
    let hotVM = HotViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        hotVM.fetchPopularRepo(q: "stars:>1 language:swift", sort: "stars", page: 1)
            .subscribe(onNext: { (model) in
                model?.items?.forEach({ (item) in
                    print(item.name)
                })
            }, onError: { (error) in
                print(error)
            })
    }

}
