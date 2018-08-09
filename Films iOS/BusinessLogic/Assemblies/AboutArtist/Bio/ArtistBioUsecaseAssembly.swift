//
//  ArtistBioUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistBioUsecaseAssembly: Assembly {

    lazy var artistBioGatewayAssembly: ArtistBioGatewayAssembly = self.context.assembly()

    var artistBioUsecase: IAboutArtistUsecase {
        return define(scope: .lazySingleton, init:
            AboutArtistUsecase(makeRequestGatewayCast: self.artistBioGatewayAssembly.artistBoiGateway)
        )
    }

}
