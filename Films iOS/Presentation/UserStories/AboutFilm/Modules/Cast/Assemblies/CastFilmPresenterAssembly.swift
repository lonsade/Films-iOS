//
//  CastFilmPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class CastFilmPresenterAssembly: Assembly {

    lazy var castFilmUsecaseAssembly: CastFilmUsecaseAssembly = CastFilmUsecaseAssembly.instance()

    lazy var castFilmDataSourceAssembly: CastFilmDataSourceAssembly = CastFilmDataSourceAssembly.instance()

    lazy var moviesRoutingAssembly = MoviesRotingAssembly.instance()

    var castFilmPresenter: ICastFilmPresenter {
        return define(scope: .lazySingleton, init:
            CastFilmPresenter(
                castFilmUsecase: self.castFilmUsecaseAssembly.castFilmUsecase,
                castFilmDataSource: self.castFilmDataSourceAssembly.castFilmDataSource,
                collectionMoviesRouting: self.moviesRoutingAssembly.moviesRoting
            )
        )
    }

}
