//
//  ProfileCell.swift
//  iGithub
//
//  Created by yfm on 2019/1/16.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var rightTextLabel: UILabel!
    @IBOutlet weak var rightArrowImageView: UIImageView!

    @IBOutlet weak var rightLabelRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var arrowWidthConstraint: NSLayoutConstraint!

    var hideArrow: Bool = false {
        didSet {
            if hideArrow {
                rightLabelRightConstraint.constant = 5
                arrowWidthConstraint.constant = 0
            } else {
                rightLabelRightConstraint.constant = 10
                arrowWidthConstraint.constant = 20
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func bindData(item: ProfileItem?) {
        guard let _item = item else { return }

        if let icon = _item.icon {
            iconImageView.image = UIImage(named: icon)
        }
        leftTextLabel.text = item?.text
        rightTextLabel.text = item?.detailText
        hideArrow = !(item?.enabled ?? false)
    }
}
