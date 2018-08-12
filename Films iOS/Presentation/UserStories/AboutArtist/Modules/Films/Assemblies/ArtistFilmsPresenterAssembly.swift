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

    lazy var artistFilmsDataSourceAssembly = ArtistFilmsDataSourceAssembly.instance()

    lazy var castRoutingAssembly = CastRoutingAssembly.instance()

    var artistFilmsPresenter: IArtistFilmsPresenter {
        return define(scope: .lazySingleton, init:
            ArtistFilmsPresenter(
                castRouting: self.castRoutingAssembly.castRouting,
                artistFilmsUsecase: self.artistFilmsUsecaseAssembly.artistFilmsUsecase,
                artistFilmsDataSource: self.artistFilmsDataSourceAssembly.artistFilmsDataSource
            )
        )
    }

}
