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
        return define(scope: .lazySingleton, init:
            GalleryDisplayManager(detailFilm: self.detailsFilmDataSourceAssembly.detailsFilmDataSource)
        )
    }

    lazy var filmsPresenterAssembly = FilmsPresenterAssembly.instance()

    var similarDisplayManager: BaseMoviesDisplayManager {
        return define(scope: .lazySingleton, init:
            BaseMoviesDisplayManager(
                filmsDataSource: self.detailsFilmDataSourceAssembly.similarFilmDataSource,
                filmsPresenter: self.filmsPresenterAssembly.filmsPresenter
            )
        )
    }

}
