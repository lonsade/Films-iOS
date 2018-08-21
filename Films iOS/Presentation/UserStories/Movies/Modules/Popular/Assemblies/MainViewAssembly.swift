//
//  MainViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 02.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

class MainViewAssembly: Assembly {

    lazy var tabDisplayManager: TabDisplayManagerAssembly = TabDisplayManagerAssembly.instance()

    lazy var tabNamesPresenterAssembly: TabNamesPresenterAssembly = TabNamesPresenterAssembly.instance()

    lazy var genresDataSourceAssembly = TabNamesDataSourceAssembly.instance()

    lazy var presenterFilmsAssembly = FilmsPresenterAssembly.instance()

    lazy var dataSourceAssembly = PopularFilmsDSAssembly.instance()

    func inject(into mvc: MainViewController) {
        defineInjection(into: mvc) {
            $0.tabDisplayManager = self.tabDisplayManager.tabDisplayManager
            $0.tabNamesPresenter = self.tabNamesPresenterAssembly.tabNamesPresenter
            $0.genresDataSource = self.genresDataSourceAssembly.tabNamesDataSource
            $0.filmsPresenter = self.presenterFilmsAssembly.filmsPresenter
            $0.filmsDataSource = self.dataSourceAssembly.popularFilmsDS
            return $0
        }
    }
}
