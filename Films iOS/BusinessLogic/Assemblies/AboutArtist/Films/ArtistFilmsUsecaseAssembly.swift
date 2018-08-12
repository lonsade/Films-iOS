//
//  ArtistFilmsUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistFilmsUsecaseAssembly: Assembly {

    lazy var artistFilmsGatewayAssembly: ArtistFilmsGatewayAssembly = self.context.assembly()

    var artistFilmsUsecase: IArtistFilmsUsecase {
        return define(scope: .lazySingleton, init:
            ArtistFilmsUsecase(makeRequestGatewayArtistFilms: self.artistFilmsGatewayAssembly.artistFilmsGateway)
        )
    }

}
