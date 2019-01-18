//
//  Date+Extension.swift
//  iGithub
//
//  Created by yfm on 2019/1/7.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

extension Date {
    public func timeFromNow() -> String {
        var timeFromNowInWords : String = ""

        let calendar = Calendar.current
        let currentTime = Date()
        let components = calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: self, to: currentTime)

        if components.year! > 1 {
            timeFromNowInWords = "\(components.year!) years ago"
        } else if components.year! == 1 {
            timeFromNowInWords = "one year ago"
        } else if components.month! > 1 {
            timeFromNowInWords = "\(components.month!) months ago"
        } else if components.month! == 1 {
            timeFromNowInWords = "one month ago"
        } else if components.day! > 1 {
            timeFromNowInWords = "\(components.day!) days ago"
        } else if components.day! == 1 {
            timeFromNowInWords = "one day ago"
        } else if components.hour! > 1 {
            timeFromNowInWords = "\(components.hour!) hours ago"
        } else if components.hour! == 1 {
            timeFromNowInWords = "one hour ago"
        } else if components.minute! > 1 {
            timeFromNowInWords = "\(components.minute!) minutes ago"
        } else if  components.second! > 5 {
            timeFromNowInWords = "\(components.second!) seconds ago"
        } else {
            timeFromNowInWords = "Just posted"
        }

        return timeFromNowInWords
    }
}

extension Date {
    func toString(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh")
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}
