//
//  PopularFilmsDisplayManagerAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class PopularFilmsDisplayManagerAssembly: Assembly {

    lazy var popularFilmsDSAssembly: PopularFilmsDSAssembly = self.context.assembly()

    lazy var filmsPresenterAssembly = FilmsPresenterAssembly.instance()

    var popularFilmsDisplayManager: BaseMoviesDisplayManager {
        return define(init:
            BaseMoviesDisplayManager(
                filmsDataSource: self.popularFilmsDSAssembly.popularFilmsDS,
                filmsPresenter: self.filmsPresenterAssembly.filmsPresenter
            )
        )
    }

}
