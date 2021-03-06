//
//  SearchFilmsUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class SearchFilmsUsecaseAssembly: Assembly {

    lazy var networking: NetworkingAssembly = self.context.assembly()

    /// Gateways

    var moviesGateway: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                parameters: [
                    "api_key": L10n.apiKey,
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

    /// Usecases

    var searchFilmsUsecase: SearchFilmsUsecaseOutput {
        return define(scope: .lazySingleton, init: SearchFilmsUsecase(
            makeRequestGatewaySearch: self.moviesGateway)
        )
    }
}
