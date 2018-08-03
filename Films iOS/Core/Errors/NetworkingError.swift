//
//  NetworkingError.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 02.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case corruptedData
    case networkingError
    case jsonCouldNotBeSerialized
}
