//
//  MoviesContainerAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 02.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class MoviesContainerAssembly: Assembly {

    lazy var usecaseAssembly = MoviesFilmAssembly.instance()

    var tabNamesDataSource: ITabNamesDataSourceOutput & ITabNamesDataSourceInput {
        return define(scope: .lazySingleton, init: TabNamesDataSource())
    }

    var tabDisplayManager: TabDisplayManager {
        return define(scope: .lazySingleton, init:
            TabDisplayManager(tabNamesDataSource: self.tabNamesDataSource)
        )
    }

    var tabNamesPresenter: ITabNamesPresenter {
        return define(scope: .lazySingleton, init:
            TabNamesPresenter(
                tabNamesUsecase: self.usecaseAssembly.tabNamesUsecase,
                dataSource: self.tabNamesDataSource
            )
        )
    }

    func inject(into mvc: MainViewController) {
        defineInjection(into: mvc) {
            $0.tabDisplayManager = self.tabDisplayManager
            $0.tabNamesPresenter = self.tabNamesPresenter
            $0.genresDataSource = self.tabNamesDataSource
            return $0
        }
    }
}
