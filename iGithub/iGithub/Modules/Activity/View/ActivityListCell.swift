//
//  ActivityListCell.swift
//  iGithub
//
//  Created by yfm on 2019/1/5.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import Kingfisher

class ActivityListCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var repoView: UIView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var repoLanguageLabel: UILabel!
    @IBOutlet weak var repoStarLabel: UILabel!
    @IBOutlet weak var repoUpdateTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        avatarImageView.layer.cornerRadius = avatarImageView.sp.height/2
        repoView.layer.borderColor = UIColor(valueRGB: 0xbbbbbb).cgColor
        repoView.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func bindData(vm: ActivityCellViewModel?) {
        guard let vm = vm else { return }
        avatarImageView.kf.setImage(with: URL(string: vm.avatar ?? "")!)
        titleLabel.text = vm.title
        timeLabel.text = vm.updateTime
        repoNameLabel.text = vm.repoTitle
        repoDescriptionLabel.text = vm.repoDescription
        repoLanguageLabel.text = vm.repoLangauge
        repoStarLabel.text = vm.repoStar
        repoUpdateTimeLabel.text = vm.repoUpdateTime
    }
}