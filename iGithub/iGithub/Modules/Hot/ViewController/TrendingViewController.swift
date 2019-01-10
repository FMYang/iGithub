//
//  TrendingViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/10.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let lb = UILabel()
        lb.text = "Trending"
        lb.textColor = .black
        self.view.addSubview(lb)
        lb.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
