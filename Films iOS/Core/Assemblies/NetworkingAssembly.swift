//
//  NetworkingAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 02.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class NetworkingAssembly: Assembly {
    var networking: NetworkingProtocol {
        return define(scope: .lazySingleton, init:
            Networking(
                baseURL: "https://api.themoviedb.org/3"
            )
        )
    }
}
