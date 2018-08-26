//
//  InfoFilmDisplayManagerAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class InfoFilmDisplayManagerAssembly: Assembly {

    lazy var detailsFilmDataSourceAssembly: DetailsFilmDataSourceAssembly = self.context.assembly()

    var galleryDisplayManager: GalleryDisplayManager {
        return define(scope: .objectGraph, init:
            GalleryDisplayManager(detailFilm: self.detailsFilmDataSourceAssembly.detailsFilmDataSource)
        )
    }

    lazy var filmsPresenterAssembly = DetailsFilmPresenterAssembly.instance()

    var infoFilmDisplayManager: InfoFilmDisplayManager {
        return define(scope: .objectGraph, init:
            InfoFilmDisplayManager(
                detailFilm: self.detailsFilmDataSourceAssembly.detailsFilmDataSource,
                galleryDisplayManager: self.galleryDisplayManager,
                filmsDataSource: self.detailsFilmDataSourceAssembly.similarFilmDataSource,
                filmsPresenter: self.filmsPresenterAssembly.detailsFilmPresenter
            )
        )
    }

}
