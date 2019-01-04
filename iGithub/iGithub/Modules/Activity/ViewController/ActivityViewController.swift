//
//  ActivityViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/3.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import RxSwift

class ActivityViewController: UIViewController {

    let url = "https://api.github.com/users/FMYang/received_events/public"
    
    let activityVM = ActivityViewModel()
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityVM.fetchPublicEvents()
            .subscribe(onNext: { (result) in
                if result.count > 0 {
                    print(result[0]?.id)
                }
            }, onError: { (error) in
                print(error.localizedDescription)
            })
            .disposed(by: bag)
    }

}
