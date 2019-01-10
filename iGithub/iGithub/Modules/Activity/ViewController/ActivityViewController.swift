//
//  ActivityViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/3.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import FDFullscreenPopGesture

class ActivityViewController: UIViewController {
    
    let activityVM = ActivityViewModel()
    let bag = DisposeBag()
    var listModel = [ActivityCellViewModel?]()

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.sp.registerCellFromNib(cls: ActivityListCell.self)
        view.estimatedRowHeight = 150
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true
        layoutUI()

//        activityVM.fetchActivityAndRepo().subscribe(onNext: { [weak self] (cellModels) in
//            self?.listModel = cellModels
//            self?.tableView.reloadData()
//        }, onError: { (error) in
//            print(error.localizedDescription)
//        })
//        .disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - fuction
    func layoutUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension ActivityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.sp.dequeueReuseCell(ActivityListCell.self, indexPath: indexPath)
        cell.bindData(vm: self.listModel[indexPath.row])
        return cell
    }
}
