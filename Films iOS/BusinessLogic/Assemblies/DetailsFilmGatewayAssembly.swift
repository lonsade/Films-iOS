//
//  DetailsFilmGatewayAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class DetailsFilmGatewayAssembly: Assembly {

    lazy var networking: NetworkingAssembly = self.context.assembly()

    var detailsFilmGateway: IDetailsFilmGateway {
        return define(scope: .lazySingleton, init:
            DetailsFilmGateway(
                networking: self.networking.networking,
                relativeURL: "/movie/299536",
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
