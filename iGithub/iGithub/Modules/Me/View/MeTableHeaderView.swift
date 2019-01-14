//
//  MeTableHeaderView.swift
//  iGithub
//
//  Created by yfm on 2019/1/14.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import Kingfisher

class MeTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var userNameLabel: UILabel!

    func bindData() {
        guard let user = UserManager.share.user else { return }
        userNameLabel.text = user.name
//        let processor = RoundCornerImageProcessor(cornerRadius: 25, targetSize: avatarImageVIew.frame.size)
//        if let url = URL(string: user.avatar_url ?? "") {
//            avatarImageVIew.kf.setImage(with: url,
//                                        placeholder: nil,
//                                        options: [.processor(processor)])
//        }
//

    }
}
