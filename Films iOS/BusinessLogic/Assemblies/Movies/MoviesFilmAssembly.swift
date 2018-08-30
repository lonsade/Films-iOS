//
//  MoviesFilmAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class MoviesFilmAssembly: Assembly {

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

    var genresGateway: IMakeRequestGateway {
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

    var tabNamesAccessor: RealmAccessor<TabName> {
        return define(init: RealmAccessor<TabName>())
    }

    var filmsAccessor: RealmAccessor<CategoryFilm> {
        return define(init: RealmAccessor<CategoryFilm>())
    }

    var tabNamesUsecase: ITabNamesUsecase {
        return define(init: TabNamesUsecase(
            makeRequestGatewayTabNames: self.genresGateway,
            tabNamesAcceessor: self.tabNamesAccessor
        ))
    }

    var moviesFilmsUsecase: IListPopularFilmsUsecase {
        return define(init: ListPopularFilmsUsecase(makeRequestGatewayListPopular: self.moviesGateway,
                                                    filmsAccessor: self.filmsAccessor))
    }

}
