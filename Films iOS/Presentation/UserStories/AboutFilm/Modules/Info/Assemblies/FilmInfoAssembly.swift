//
//  InfoViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class FilmInfoAssembly: Assembly {

    lazy var filmsPresenterAssembly = AboutFilmContainerAssembly.instance()

    lazy var usecaseAssembly = AboutFilmAssembly.instance()

    var detailsFilmDataSource: IDetailsFilmDataSourceOutput & IDetailsFilmDataSourceInput {
        return define(init: DetailsFilmDataSource())
    }

    var similarFilmDataSource: SimilarFilmsDataSourceOutput & SimilarFilmsDataSourceInput {
        return define(init: SimilarFilmsDataSource())
    }

    var galleryDisplayManager: GalleryDisplayManager {
        return define(init: GalleryDisplayManager(detailFilm: self.detailsFilmDataSource))
    }

    var detailsFilmPresenter: IDetailsFilmPresenter {
        return define(init:
            DetailsFilmPresenter(
                detailsFilmUsecase: self.usecaseAssembly.detailFilmUsecase,
                dataSourceForDetails: self.detailsFilmDataSource,
                galleryUsecase: self.usecaseAssembly.galleryFilmUsecase,
                similarUsecase: self.usecaseAssembly.similarUsecase,
                dataSourceForSimilar: self.similarFilmDataSource,
                aboutFilmPresenter: self.filmsPresenterAssembly.aboutFilmPresenter
            )
        )
    }

    var infoFilmDisplayManager: InfoFilmDisplayManager {
        return define(init:
            InfoFilmDisplayManager(
                detailFilm: self.detailsFilmDataSource,
                galleryDisplayManager: self.galleryDisplayManager,
                filmsDataSource: self.similarFilmDataSource,
                filmsPresenter: self.detailsFilmPresenter
            )
        )
    }

    var infoMoviesRouting: InfoRouting {
        return define(init: InfoRouting())
    }

    func inject(into mvc: InfoFilmViewController) {
        defineInjection(into: mvc) {
            $0.presenter = self.detailsFilmPresenter
            $0.router = self.infoMoviesRouting
            $0.infoFilmDisplayManager = self.infoFilmDisplayManager
            return $0
        }
    }
}
