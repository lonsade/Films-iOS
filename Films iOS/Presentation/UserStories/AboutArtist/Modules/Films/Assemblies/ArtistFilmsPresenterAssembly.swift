//
//  ArtistFilmsPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistFilmsPresenterAssembly: Assembly {

    lazy var artistFilmsUsecaseAssembly = ArtistFilmsUsecaseAssembly.instance()

    lazy var baseFilmsDataSourceAssembly = BaseFilmsDataSourceAssembly.instance()

    var artistFilmsPresenter: IArtistFilmsPresenter {
        return define(scope: .lazySingleton, init:
            ArtistFilmsPresenter(
                artistFilmsUsecase: self.artistFilmsUsecaseAssembly.artistFilmsUsecase,
                artistFilmsDataSource: self.baseFilmsDataSourceAssembly.baseFilmsDataSource
            )
        )
    }

}
