//
//  ArtistBioPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistBioPresenterAssembly: Assembly {

    lazy var artistBioAndPhotosUsecaseAssembly: ArtistBioAndPhotosUsecaseAssembly = ArtistBioAndPhotosUsecaseAssembly.instance()

    lazy var artistBioDataSourceAssembly: ArtistBioDataSourceAssembly = ArtistBioDataSourceAssembly.instance()

    lazy var castRoutingAssembly: CastRoutingAssembly = CastRoutingAssembly.instance()

    var artistBioPresenter: IArtistBioPresenter {
        return define(scope: .lazySingleton, init:
            ArtistBioPresenter(
                artistBioUsecase: self.artistBioAndPhotosUsecaseAssembly.artistBioUsecase,
                artistBioDataSource: self.artistBioDataSourceAssembly.artistBioDataSource,
                castRouting: self.castRoutingAssembly.castRouting,
                artistGalleryUsecase: self.artistBioAndPhotosUsecaseAssembly.artistPhotosUsecase
            )
        )
    }

}
