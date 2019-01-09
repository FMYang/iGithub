//
//  RepoViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/9.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class RepoViewController: UIViewController {

    lazy var webView: WKWebView = {
        let view = WKWebView()
        return view
    }()

    convenience init(url: String?) {
        self.init()

        let url: String? = "https://github.com/Alamofire/Alamofire"

        guard let _url = url, let aurl = URL(string: _url) else {
            return
        }
        self.webView.load(URLRequest(url: aurl))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }


}
