//
//  GalleryImage.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

struct GalleryImage: Codable {
    let filePath: String

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
