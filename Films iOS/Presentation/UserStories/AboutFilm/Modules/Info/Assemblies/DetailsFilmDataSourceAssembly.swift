//
//  DetailsFilmDataSourceAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class DetailsFilmDataSourceAssembly: Assembly {
    var detailsFilmDataSource: IDetailsFilmDataSourceOutput & IDetailsFilmDataSourceInput {
        return define(scope: .lazySingleton, init: DetailsFilmDataSource())
    }

    lazy var baseFilmsDataSourceAssembly = BaseFilmsDataSourceAssembly.instance()

    var similarFilmDataSource: BaseMoviesDataSourceOutput & BaseMoviesDataSourceInput {
        return define(scope: .lazySingleton, init: BaseMoviesDataSource(
            baseFilmsDataSource: self.baseFilmsDataSourceAssembly.baseFilmsDataSource
        ))
    }
}
