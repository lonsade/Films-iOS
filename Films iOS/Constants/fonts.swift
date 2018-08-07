//
//  fonts.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 31.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable identifier_name line_length type_body_length

extension UIFont {

    private static func getFont(named name: String, of size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            #if DEBUG
            fatalError("Invalid Font")
            #else
            return .systemFont(ofSize: size)
            #endif
        }
        return font
    }

    static let FTabName = getFont(named: "Segoe UI", of: 14)

    static let FAppName = getFont(named: "SegoeUI-Semibold", of: 17)

    static let FTitleContent = getFont(named: "SegoeUI-Semibold", of: 13)

    static let FActiveTextOnContent = getFont(named: "SegoeUI-Semibold", of: 12)

    static let FTextAgeOnFilmCollection = getFont(named: "SegoeUI-Semibold", of: 12)

    static let FAboutFilmTab = getFont(named: "Segoe UI", of: 13)

    static let FAboutFilmTitle = getFont(named: "SegoeUI-Semibold", of: 24)

    static let FAboutFilmInfoTitleAndDesc = getFont(named: "Segoe UI", of: 14)

    static let FAboutFilmTitles = getFont(named: "SegoeUI-Semibold", of: 18)

}

// swiftlint:enable identifier_name line_length type_body_length
