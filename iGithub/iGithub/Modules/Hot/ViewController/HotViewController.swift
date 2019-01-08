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
    var items = [HotItemViewModel?]()
    var page = 1

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.sp.registerCellFromNib(cls: PopularCell.self)
        view.estimatedRowHeight = 150
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        
        fetchData()
    }
    
    // MARK: - fuction
    func layoutUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - network
    func fetchData() {
        hotVM.fetchPopularRepo(q: "stars:>1 language:swift", sort: "stars", page: page)
            .subscribe(onNext: { [weak self] (result) in
                self?.items = result
                self?.tableView.reloadData()
                }, onError: { (error) in
                    print(error)
            }, onCompleted: {
                print("completed")
            })
            .disposed(by: bag)
    }
}

extension HotViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.sp.dequeueReuseCell(PopularCell.self, indexPath: indexPath)
        cell.bindData(vm: self.items[indexPath.row])
        return cell
    }
}

