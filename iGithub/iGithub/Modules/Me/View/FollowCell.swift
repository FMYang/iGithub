//
//  FollowCell.swift
//  iGithub
//
//  Created by yfm on 2019/1/17.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class FollowCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loginNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func bindData(model: FollowUserViewModel?) {
        guard let _model = model else { return }
        avatarImageView.sp.setImageWithRounded(path: _model.avatar, cornerRadius: 25, targetSize: avatarImageView.bounds.size)
        loginNameLabel.text = _model.login
        userNameLabel.text = _model.name
        descriptionLabel.text = _model.description
        locationLabel.text = _model.location
    }
}
