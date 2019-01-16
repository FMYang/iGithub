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

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data.init(self.utf8).base64EncodedString()
    }

    public func isEmail() -> Bool {
        let pattern = "\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"
        return self.range(of: pattern,
                          options: String.CompareOptions.regularExpression,
                          range: nil,
                          locale: nil) != nil
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
