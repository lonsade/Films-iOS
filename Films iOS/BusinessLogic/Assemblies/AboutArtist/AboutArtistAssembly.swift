//
//  AboutArtistAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class AboutArtistAssembly: Assembly {

    /// Gateways

    lazy var networking: NetworkingAssembly = self.context.assembly()

    var aboutArtistGateway: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                parameters: ["api_key": L10n.apiKey, "language": "en-US"],
                headers: ["Content-Type": "application/json", "Accept": "application/json"],
                method: RequestMethod.GET
            )
        )
    }

    var aboutArtistGatewayWithPaging: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                parameters: ["api_key": L10n.apiKey, "language": "en-US"],
                headers: ["Content-Type": "application/json", "Accept": "application/json"],
                method: RequestMethod.GET
            )
        )
    }

    var aboutArtistGatewayForImages: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                parameters: ["api_key": L10n.apiKey, "language": "en-US"],
                headers: ["Content-Type": "application/json", "Accept": "application/json"],
                method: RequestMethod.GET
            )
        )
    }

    /// Usecases

    // Bio

    var artistBioUsecase: IAboutArtistUsecase {
        return define(scope: .lazySingleton, init: AboutArtistUsecase(makeRequestGatewayCast: self.aboutArtistGateway))
    }

    var artistPhotosUsecase: IArtistPhotosUsecase {
        return define(scope: .lazySingleton, init: ArtistPhotosUsecase(makeRequestGatewayPhotos: self.aboutArtistGatewayForImages))
    }

    // Films

    var artistFilmsUsecase: IArtistFilmsUsecase {
        return define(init: ArtistFilmsUsecase(makeRequestGatewayArtistFilms: self.aboutArtistGatewayWithPaging))
    }

}
