//
//  DetailsFilmPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class DetailsFilmPresenterAssembly: Assembly {

    lazy var infoFilmUsecaseAssembly: InfoFilmUsecaseAssembly = InfoFilmUsecaseAssembly.instance()

    lazy var infoFilmDataSourceAssembly: DetailsFilmDataSourceAssembly = DetailsFilmDataSourceAssembly.instance()

    lazy var moviesRoutingAssembly = MoviesRotingAssembly.instance()

//    lazy var artistRoutingAssembly = ArtistRoutingAssembly.instance()

    var detailsFilmPresenter: IDetailsFilmPresenter {
        return define(scope: .lazySingleton, init:
            DetailsFilmPresenter(
                detailsFilmUsecase: self.infoFilmUsecaseAssembly.detailFilmUsecaseAssembly,
                dataSourceForDetails: self.infoFilmDataSourceAssembly.detailsFilmDataSource,
                galleryUsecase: self.infoFilmUsecaseAssembly.galleryFilmUsecaseAssembly,
                moviesRouting: self.moviesRoutingAssembly.moviesRoting,
                similarUsecase: self.infoFilmUsecaseAssembly.similarUsecaseAssembly,
                dataSourceForSimilar: self.infoFilmDataSourceAssembly.similarFilmDataSource
            )
        )
    }

}
