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

    var detailsFilmPresenter: IDetailsFilmPresenter {
        return define(scope: .lazySingleton, init:
            DetailsFilmPresenter(
                detailsFilmUsecase: self.infoFilmUsecaseAssembly.detailFilmUsecaseAssembly,
                dataSource: self.infoFilmDataSourceAssembly.detailsFilmDataSource,
                galleryUsecase: self.infoFilmUsecaseAssembly.galleryFilmUsecaseAssembly
            )
        )
    }

}
