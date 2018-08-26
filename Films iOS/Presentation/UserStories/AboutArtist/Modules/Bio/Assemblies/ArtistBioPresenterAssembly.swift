//
//  ArtistBioPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistBioPresenterAssembly: Assembly {

    lazy var artistBioAndPhotosUsecaseAssembly = ArtistBioAndPhotosUsecaseAssembly.instance()

    lazy var artistBioDataSourceAssembly = ArtistBioDataSourceAssembly.instance()

    lazy var aboutArtistPresenterAssembly = AboutArtistPresenterAssembly.instance()

    var artistBioPresenter: IArtistBioPresenter {
        return define(init:
            ArtistBioPresenter(
                artistBioUsecase: self.artistBioAndPhotosUsecaseAssembly.artistBioUsecase,
                artistBioDataSource: self.artistBioDataSourceAssembly.artistBioDataSource,
                artistGalleryUsecase: self.artistBioAndPhotosUsecaseAssembly.artistPhotosUsecase,
                aboutArtistPresenter: self.aboutArtistPresenterAssembly.aboutArtistPresenter
            )
        )
    }

}
