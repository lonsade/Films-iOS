//
//  SearchFilmsUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class SearchFilmsUsecaseAssembly: Assembly {

    lazy var makeRequestGatewaySearch = MoviesGatewayAssembly.instance()

    var searchFilmsUsecase: SearchFilmsUsecaseOutput {
        return define(scope: .lazySingleton, init: SearchFilmsUsecase(
            makeRequestGatewaySearch: self.makeRequestGatewaySearch.listPopularFilmsGateway)
        )
    }
}
