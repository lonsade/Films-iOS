//
//  ListOfMoviesAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class ListOfMoviesAssembly: Assembly {

    lazy var usecaseAssembly = MoviesFilmAssembly.instance()

    var moviesRoting: MoviesRouting {
        return define(init: MoviesRouting())
    }

    var moviesDataSource: BaseMoviesDataSource {
        return define(init: BaseMoviesDataSource())
    }

    var moviesPresenter: IPopularFilmsPresenter & FilmsPresenterInput {
        return define(init:
            PopularFilmsPresenter(listPopularFilmsUsecase: self.usecaseAssembly.moviesFilmsUsecase, dataSource: self.moviesDataSource)
        )
    }

    var moviesDisplayManager: BaseMoviesDisplayManager {
        return define(init:
            BaseMoviesDisplayManager(filmsDataSource: self.moviesDataSource, filmsPresenter: self.moviesPresenter)
        )
    }

    func inject(into pvc: PopularFilmsViewController) {
        defineInjection(into: pvc) {
            $0.filmCollectionDisplayManager = self.moviesDisplayManager
            $0.presenter = self.moviesPresenter
            $0.router = self.moviesRoting
            $0.moduleInput = self.moviesPresenter
            return $0
        }
    }
}
