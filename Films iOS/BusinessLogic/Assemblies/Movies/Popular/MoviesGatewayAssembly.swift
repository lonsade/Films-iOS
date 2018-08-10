//
//  MoviesGatewayAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 10.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class MoviesGatewayAssembly: Assembly {

    lazy var networking: NetworkingAssembly = self.context.assembly()

    var tabNamesGateway: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                relativeURL: "/genre/movie/list",
                parameters: [
                    "api_key": "7e768e8012161bc9c4ca59f1e4f5979e",
                    "language": "en-US"
                ],
                headers: [
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                ],
                method: RequestMethod.GET
            )
        )
    }

    var listPopularFilmsGateway: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                relativeURL: "/movie/popular",
                parameters: [
                    "api_key": "7e768e8012161bc9c4ca59f1e4f5979e",
                    "language": "en-US"
                ],
                headers: [
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                ],
                method: RequestMethod.GET
            )
        )
    }

}
