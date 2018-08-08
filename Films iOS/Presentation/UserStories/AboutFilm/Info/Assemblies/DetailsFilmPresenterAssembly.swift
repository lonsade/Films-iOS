//
//  DetailsFilmPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class DetailsFilmPresenterAssembly: Assembly {

    lazy var detailsFilmUsecaseAssembly: DetailsFilmUsecaseAssembly = DetailsFilmUsecaseAssembly.instance()

    lazy var detailsFilmDataSourceAssembly: DetailsFilmDataSourceAssembly = DetailsFilmDataSourceAssembly.instance()

    lazy var galleryUsecaseAssembly: GalleryUsecaseAssembly = GalleryUsecaseAssembly.instance()

    lazy var castUsecaseAssembly: CastUsecaseAssembly = CastUsecaseAssembly.instance()

    var detailsFilmPresenter: IDetailsFilmPresenter {
        return define(scope: .lazySingleton, init:
            DetailsFilmPresenter(
                detailsFilmUsecase: self.detailsFilmUsecaseAssembly.detailsFilmUsecase,
                dataSource: self.detailsFilmDataSourceAssembly.detailsFilmDataSource,
                galleryUsecase: self.galleryUsecaseAssembly.galleryUsecase,
                castUsecase: self.castUsecaseAssembly.castUsecase
            )
        )
    }

}
