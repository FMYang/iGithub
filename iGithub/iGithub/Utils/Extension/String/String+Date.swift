//
//  String+Date.swift
//  iGithub
//
//  Created by yfm on 2019/1/7.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

extension String {
    func toDate(dateFormat: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh")
        formatter.dateFormat = dateFormat
        let toDate = formatter.date(from: self)
        return toDate
    }
}
