//
//  FilmCastAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class FilmCastAssembly: Assembly {

    lazy var presenterAssembly = AboutFilmContainerAssembly.instance()

    lazy var usecaseAssembly = AboutFilmAssembly.instance()

    var castFilmDataSource: ICastFilmDataSourceOutput & ICastFilmDataSourceInput {
        return define(init: CastFilmDataSource())
    }

    var castRouting: CastRouting {
        return define(init: CastRouting())
    }

    var castFilmPresenter: ICastFilmPresenter {
        return define(init:
            CastFilmPresenter(
                castFilmUsecase: self.usecaseAssembly.castFilmUsecase,
                castFilmDataSource: self.castFilmDataSource,
                aboutFilmPresenter: self.presenterAssembly.aboutFilmPresenter
            )
        )
    }

    var castDisplayManager: CastDisplayManager {
        return define(init: CastDisplayManager(castDataSource: self.castFilmDataSource))
    }

    func inject(into mvc: CastViewController) {
        defineInjection(into: mvc) {
            $0.presenter = self.castFilmPresenter
            $0.castDisplayManager = self.castDisplayManager
            $0.router = self.castRouting
            return $0
        }
    }
}
