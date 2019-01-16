//
//  MeTableFooterView.swift
//  iGithub
//
//  Created by yfm on 2019/1/16.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class MeTableFooterView: UITableViewHeaderFooterView {
    @IBOutlet weak var logoutButton: UIButton!

    weak var delegate: ProfileFooterViewDelegate?

    let bag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()

        logoutButton.layer.cornerRadius = 4

        logoutButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.delegate?.logout()
            })
            .disposed(by: bag)
    }
}
