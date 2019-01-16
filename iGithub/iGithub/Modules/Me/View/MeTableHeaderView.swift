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

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createAtLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var reposLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(vm: ProfileHeaderItem?) {
        guard let _vm = vm else { return }

        userNameLabel.text = _vm.name
        descriptionLabel.text = _vm.bio
        createAtLabel.text = _vm.create_at
        reposLabel.text = _vm.repos
        followersLabel.text = _vm.followers
        followingLabel.text = _vm.following
        
        let processor = RoundCornerImageProcessor(cornerRadius: 25, targetSize: avatarImageView.frame.size)
        if let url = URL(string: _vm.avatar ?? "") {
            avatarImageView.kf.setImage(with: url,
                                        placeholder: nil,
                                        options: [.processor(processor),
                                                  .cacheSerializer(FormatIndicatedCacheSerializer.png)])
        }
    }
}
