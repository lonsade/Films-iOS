//
//  ArtistFilmsDisplayManagerAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistFilmsDisplayManagerAssembly: Assembly {

    lazy var artistFilmsDataSourceAssembly = ArtistFilmsDataSourceAssembly.instance()

    lazy var filmsPresenterAssembly = ArtistFilmsPresenterAssembly.instance()

    var artistFilmsDisplayManager: ArtistMoviesDisplayManager {
        return define(scope: .lazySingleton, init:
            ArtistMoviesDisplayManager(
                filmsDataSource: self.artistFilmsDataSourceAssembly.artistFilmsDataSource,
                filmsPresenter: self.filmsPresenterAssembly.artistFilmsPresenter
            )
        )
    }
}
