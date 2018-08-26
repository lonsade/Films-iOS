//
//  ArtistFilmsAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistFilmsAssembly: Assembly {

    lazy var aboutArtistPresenterAssembly = AboutArtistContainerAssembly.instance()

    lazy var artistFilmsLogicAssembly = AboutArtistAssembly.instance()

    var artistFilmsDataSource: ArtistFilmsDataSourceOutput & ArtistFilmsDataSourceInput {
        return define(init: ArtistFilmsDataSource())
    }

    var artistRouting: ArtistFilmsRouting {
        return define(init:
            ArtistFilmsRouting()
        )
    }

    var artistFilmsPresenter: IArtistFilmsPresenter {
        return define(init:
            ArtistFilmsPresenter(
                artistFilmsUsecase: self.artistFilmsLogicAssembly.artistFilmsUsecase,
                artistFilmsDataSource: self.artistFilmsDataSource,
                aboutArtistPresenter: self.aboutArtistPresenterAssembly.aboutArtistPresenter
            )
        )
    }

    var artistFilmsDisplayManager: ArtistMoviesDisplayManager {
        return define(init:
            ArtistMoviesDisplayManager(
                filmsDataSource: self.artistFilmsDataSource,
                filmsPresenter: self.artistFilmsPresenter
            )
        )
    }

    func inject(into mvc: ArtistFilmsViewController) {
        defineInjection(into: mvc) {
            $0.artistFilmsDisplayManager = self.artistFilmsDisplayManager
            $0.presenter = self.artistFilmsPresenter
            $0.router = self.artistRouting
            return $0
        }
    }

}
