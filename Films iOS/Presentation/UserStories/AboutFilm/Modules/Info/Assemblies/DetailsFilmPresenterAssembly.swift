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

    lazy var aboutFilmPresenter = AboutFilmPresenterAssembly.instance()

    var detailsFilmPresenter: IDetailsFilmPresenter {
        return define(init:
            DetailsFilmPresenter(
                detailsFilmUsecase: self.infoFilmUsecaseAssembly.detailFilmUsecaseAssembly,
                dataSourceForDetails: self.infoFilmDataSourceAssembly.detailsFilmDataSource,
                galleryUsecase: self.infoFilmUsecaseAssembly.galleryFilmUsecaseAssembly,
                similarUsecase: self.infoFilmUsecaseAssembly.similarUsecaseAssembly,
                dataSourceForSimilar: self.infoFilmDataSourceAssembly.similarFilmDataSource,
                aboutFilmPresenter: self.aboutFilmPresenter.aboutFilmPresenter

            )
        )
    }

}
