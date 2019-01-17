//
//  UIImageView+Kingfisher.swift
//  iGithub
//
//  Created by yfm on 2019/1/17.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import Kingfisher

extension NamespaceWrapper where Base: UIImageView {
    /// set image
    ///
    /// - Parameter path: image path
    func setImage(path: String) {
        if let url = URL(string: path) {
            wrappedValue.kf.setImage(with: url)
        }
    }

    /// set image and rounded
    ///
    /// - Parameters:
    ///   - path: image path
    ///   - cornerRadius: radius
    ///   - targetSize: target size
    func setImageWithRounded(path: String?,
                             cornerRadius: Float,
                             targetSize: CGSize) {
        if let _path = path, let url = URL(string: _path) {
            let processor = RoundCornerImageProcessor(cornerRadius: CGFloat(cornerRadius), targetSize: targetSize)
            wrappedValue.kf.setImage(with: url,
                                     placeholder: nil,
                                     options: [.processor(processor),
                                               .cacheSerializer(FormatIndicatedCacheSerializer.png)])
        }
    }
}
