//
//  ArtistBioUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistBioAndPhotosUsecaseAssembly: Assembly {

    lazy var artistBioAndPhotosGatewayAssembly: ArtistBioAndPhotosGatewayAssembly = self.context.assembly()

    var artistBioUsecase: IAboutArtistUsecase {
        return define(scope: .lazySingleton, init:
            AboutArtistUsecase(makeRequestGatewayCast: self.artistBioAndPhotosGatewayAssembly.artistBioGateway)
        )
    }

    var artistPhotosUsecase: IArtistPhotosUsecase {
        return define(scope: .lazySingleton, init:
            ArtistPhotosUsecase(makeRequestGatewayPhotos: self.artistBioAndPhotosGatewayAssembly.artistPhotosGateway)
        )
    }

}
