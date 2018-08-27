//
//  ArtistBioAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistBioAssembly: Assembly {

    lazy var aboutArtistLogicAssembly = AboutArtistAssembly.instance()

    lazy var aboutArtistPresenterAssembly = AboutArtistContainerAssembly.instance()

    var artistBioDataSource: IArtistBioDataSourceOutput & IArtistBioDataSourceInput {
        return define(init: ArtistBioDataSource())
    }

    var artistBioPresenter: IArtistBioPresenter {
        return define(init:
            ArtistBioPresenter(
                artistBioUsecase: self.aboutArtistLogicAssembly.artistBioUsecase,
                artistBioDataSource: self.artistBioDataSource,
                artistGalleryUsecase: self.aboutArtistLogicAssembly.artistPhotosUsecase,
                aboutArtistPresenter: self.aboutArtistPresenterAssembly.aboutArtistPresenter,
                router: self.routing
            )
        )
    }

    var routing: ArtistBioRoutingInput {
        return define(init: ArtistBioRouting())
    }

    var artistPhotosDisplayManager: ArtistPhotosDisplayManager {
        return define(init:
            ArtistPhotosDisplayManager(artistBioDataSource: self.artistBioDataSource)
        )
    }

    func inject(into mvc: ArtistBioViewController) {
        defineInjection(into: mvc) {
            $0.artistBioPresenter = self.artistBioPresenter
            $0.artistBioDataSource = self.artistBioDataSource
            $0.artistPhotosDisplayManager = self.artistPhotosDisplayManager
            $0.router = self.routing
            return $0
        }
    }

}
