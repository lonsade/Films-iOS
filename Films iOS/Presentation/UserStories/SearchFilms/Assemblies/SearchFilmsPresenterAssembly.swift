//
//  SearchFilmsPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class SearchFilmsPresenterAssembly: Assembly {

    lazy var dataSourceAssembly = SearchFilmsDataSourceAssembly.instance()

    lazy var usecaseAssembly = SearchFilmsUsecaseAssembly.instance()

    var searchFilmsPresenter: SearchFilmsPresenterInput {
        return define(init: SearchFilmsPresenter(
            dataSource: self.dataSourceAssembly.searchFilmsDataSource,
            usecase: self.usecaseAssembly.searchFilmsUsecase)
        )
    }

}
