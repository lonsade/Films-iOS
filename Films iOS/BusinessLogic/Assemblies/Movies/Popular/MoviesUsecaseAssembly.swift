//
//  MoviesUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 10.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class MoviesUsecaseAssembly: Assembly {

    lazy var moviesGatewayAssembly: MoviesGatewayAssembly = self.context.assembly()

    var tabNamesUsecase: ITabNamesUsecase {
        return define(scope: .lazySingleton, init:
            TabNamesUsecase(makeRequestGatewayTabNames: self.moviesGatewayAssembly.tabNamesGateway)
        )
    }

    var listPopularFilmsUsecase: IListPopularFilmsUsecase {
        return define(scope: .lazySingleton, init:
            ListPopularFilmsUsecase(
                makeRequestGatewayListPopular: self.moviesGatewayAssembly.listPopularFilmsGateway
            )
        )
    }

}
