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

    var detailGateway: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                parameters: ["api_key": "7e768e8012161bc9c4ca59f1e4f5979e", "language": "en-US"],
                headers: ["Content-Type": "application/json", "Accept": "application/json"],
                method: RequestMethod.GET
            )
        )
    }

    var galleryGateway: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                parameters: ["api_key": "7e768e8012161bc9c4ca59f1e4f5979e", "language": "en-US", "include_image_language": "en,null"],
                headers: ["Content-Type": "application/json", "Accept": "application/json"],
                method: RequestMethod.GET
            )
        )
    }

    // TODO: перенести page в параметр (для дальнейшей динамической подгрузки фильмов)

    var similarGateway: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                parameters: ["api_key": "7e768e8012161bc9c4ca59f1e4f5979e", "language": "en-US", "page": "1"],
                headers: ["Content-Type": "application/json", "Accept": "application/json"],
                method: RequestMethod.GET
            )
        )
    }

}
