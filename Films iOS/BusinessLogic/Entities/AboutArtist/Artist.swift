//
//  Artist.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

struct Artist: Codable {
    let id: Int
    let name: String
    let profilePath: String?
    let birthday: String?
    let placeOfBirth: String?
    let biography: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case birthday
        case placeOfBirth = "place_of_birth"
        case biography
    }
}
