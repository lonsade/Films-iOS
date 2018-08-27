//
//  SearchAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class SearchAssembly: Assembly {

    lazy var usecaseAssembly = SearchFilmsUsecaseAssembly.instance()

    var searchFilmsDataSource: SearchFilmsDataSourceInput & SearchFilmsDataSourceOutput {
        return define(init: SearchFilmsDataSource())
    }

    var router: SearchFilmsRoutingInput {
        return define(init: SearchFilmsRouting())
    }

    var searchFilmsDisplayManager: SearchFilmsDisplayManagerOutput {
        return define(init: SearchFilmsDisplayManager(dataSource: self.searchFilmsDataSource))
    }

    var searchFilmsPresenter: SearchFilmsPresenterInput {
        return define(init: SearchFilmsPresenter(
            dataSource: self.searchFilmsDataSource,
            usecase: self.usecaseAssembly.searchFilmsUsecase)
        )
    }

    func inject(into mvc: SearchViewController) {
        defineInjection(into: mvc) {
            $0.presenter = self.searchFilmsPresenter
            $0.displayManager = self.searchFilmsDisplayManager
            $0.router = self.router
            return $0
        }
    }

}
