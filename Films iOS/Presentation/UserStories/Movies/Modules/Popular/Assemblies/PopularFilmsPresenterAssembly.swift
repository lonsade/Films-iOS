//
//  PopularFilmsPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class PopularFilmsPresenterAssembly: Assembly {

    lazy var moviesUsecaseAssembly: MoviesUsecaseAssembly = MoviesUsecaseAssembly.instance()

    lazy var popularFilmsDSAssembly: PopularFilmsDSAssembly = PopularFilmsDSAssembly.instance()

    var popularFilmsPresenter: IPopularFilmsPresenter & FilmsPresenterInput {
        return define(scope: .lazySingleton, init:
            PopularFilmsPresenter(
                listPopularFilmsUsecase: self.moviesUsecaseAssembly.listPopularFilmsUsecase,
                dataSource: self.popularFilmsDSAssembly.popularFilmsDS
            )
        )
    }

}
