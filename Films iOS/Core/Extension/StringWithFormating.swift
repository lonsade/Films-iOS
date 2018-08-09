//
//  StringSizeWithFormating.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit
import Foundation

extension String {
    func getSizeWithFormating(font: UIFont) -> CGSize {
        let attrStr = NSAttributedString(string: self, attributes: [.font: font])
        return attrStr.size()
    }
    func withTMDb() -> String {
        return "TMDb "+self
    }

    func getDate(withFormat format: String) -> DateComponents {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let calendar = Calendar.current

        var validDate: Date
        if let date = dateFormatter.date(from: self) {
            validDate = date
        } else {
            #if DEBUG
            fatalError("Could not get date with dataFormatter from string: \(self)")
            #else
            validDate = Date()
            #endif
        }

        let components = calendar.dateComponents(
            [Calendar.Component.day, Calendar.Component.month, Calendar.Component.year],
            from: validDate
        )
        return components
    }

    func getStringDate(newFormat: String, oldFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = oldFormat

        var validDate: Date
        if let date = dateFormatter.date(from: self) {
            validDate = date
        } else {
            #if DEBUG
            fatalError("Could not get date with dataFormatter from string: \(self)")
            #else
            validDate = Date()
            #endif
        }
        dateFormatter.dateFormat = newFormat
        return dateFormatter.string(from: validDate)
    }
}
