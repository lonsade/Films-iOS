//
//  Cast.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

struct Cast: Codable {
    let profilePath: String?
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case profilePath = "profile_path"
        case id
        case name
    }
}
