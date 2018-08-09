//
//  ArtistBioPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistBioPresenterAssembly: Assembly {

    lazy var artistBioUsecaseAssembly: ArtistBioUsecaseAssembly = ArtistBioUsecaseAssembly.instance()

    lazy var artistBioDataSourceAssembly: ArtistBioDataSourceAssembly = ArtistBioDataSourceAssembly.instance()

    var artistBioPresenter: IArtistBioPresenter {
        return define(scope: .lazySingleton, init:
            ArtistBioPresenter(
                artistBioUsecase: self.artistBioUsecaseAssembly.artistBioUsecase,
                artistBioDataSource: self.artistBioDataSourceAssembly.artistBioDataSource
            )
        )
    }

}
