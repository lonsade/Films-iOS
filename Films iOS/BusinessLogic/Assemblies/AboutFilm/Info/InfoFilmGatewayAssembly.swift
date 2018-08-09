//
//  AboutFilmGatewayAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class InfoFilmGatewayAssembly: Assembly {

    lazy var networking: NetworkingAssembly = self.context.assembly()

    var detailGatewayAssembly: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                relativeURL: "/movie/353081",
                parameters: ["api_key": "7e768e8012161bc9c4ca59f1e4f5979e", "language": "en-US"],
                headers: ["Content-Type": "application/json", "Accept": "application/json"],
                method: RequestMethod.GET
            )
        )
    }

    var galleryGatewayAssembly: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                relativeURL: "/movie/353081/images",
                parameters: ["api_key": "7e768e8012161bc9c4ca59f1e4f5979e", "language": "en-US", "include_image_language": "en,null"],
                headers: ["Content-Type": "application/json", "Accept": "application/json"],
                method: RequestMethod.GET
            )
        )
    }

}
