//
//  PopularViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/10.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController {

    // MARK: - properties
    let bag = DisposeBag()
    let hotVM = PopularViewModel()
    var items = [PopularItemViewModel?]()
    var page = 1
    let languauges = ["Swift", "Objective-C", "Java", "JavaScript", "Kotlin"]
    var currentLanguage = "Swift"

    lazy var languageSelectedView: SelectedView = {
        let view = SelectedView.sp.loadNib()
        view.leftLabel.text = "Language"
        view.conditionLabel.text = "Swift"
        return view
    }()

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

        currentLanguage = languauges[0]
        fetchData()

        languageSelectedView.selectedButton.rx.tap
            .subscribe(onNext: {
                TDWDropDownMenu.show(frame: self.languageSelectedView.conditionView.frame, data: self.languauges, callBack: { [weak self] (str) in
                    self?.languageSelectedView.conditionLabel.text = str
                    self?.currentLanguage = str
                    self?.fetchData()
                })
            })
            .disposed(by: bag)
    }

    // MARK: - fuction
    func layoutUI() {
        self.view.addSubview(languageSelectedView)
        self.view.addSubview(tableView)
        languageSelectedView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }

        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(languageSelectedView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

    // MARK: - network
    func fetchData() {
        hotVM.fetchPopularRepo(q: currentLanguage, sort: "stars", page: page)
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

extension PopularViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.sp.dequeueReuseCell(PopularCell.self, indexPath: indexPath)
        cell.bindData(vm: self.items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        let vc = IWebViewController(urlPath: item?.url)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
