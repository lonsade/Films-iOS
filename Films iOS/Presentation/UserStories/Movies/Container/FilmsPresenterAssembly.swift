//
//  FilmsPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 21.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class FilmsPresenterAssembly: Assembly {

    lazy var moviesUsecaseAssembly: MoviesUsecaseAssembly = MoviesUsecaseAssembly.instance()

    lazy var popularFilmsDSAssembly: PopularFilmsDSAssembly = PopularFilmsDSAssembly.instance()

    var filmsPresenter: IFilmsPresenter {
        return define(scope: .lazySingleton, init:
            FilmsPresenter(
                listPopularFilmsUsecase: self.moviesUsecaseAssembly.listPopularFilmsUsecase,
                dataSource: self.popularFilmsDSAssembly.popularFilmsDS
            )
        )
    }

}
