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

    lazy var listPopularFilmsUsecaseAssembly: ListPopularFilmsUsecaseAssembly = ListPopularFilmsUsecaseAssembly.instance()

    lazy var popularFilmsDSAssembly: PopularFilmsDSAssembly = PopularFilmsDSAssembly.instance()

    var popularFilmsPresenter: IPopularFilmsPresenter {
        return define(scope: .lazySingleton, init:
            PopularFilmsPresenter(
                listPopularFilmsUsecase: self.listPopularFilmsUsecaseAssembly.listPopularFilmsUsecase,
                dataSource: self.popularFilmsDSAssembly.popularFilmsDS
            )
        )
    }

}
