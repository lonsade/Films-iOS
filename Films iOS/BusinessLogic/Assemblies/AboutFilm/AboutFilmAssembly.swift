//
//  AboutFilmAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class AboutFilmAssembly: Assembly {

    lazy var networking: NetworkingAssembly = self.context.assembly()

    /// Gateways

    var aboutFilmGateway: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                parameters: ["api_key": L10n.apiKey, "language": "en-US"],
                headers: ["Content-Type": "application/json", "Accept": "application/json"],
                method: RequestMethod.GET
            )
        )
    }

    var aboutFilmGatewayWithPaging: IMakeRequestGateway {
        return define(scope: .lazySingleton, init:
            MakeRequestGateway(
                networking: self.networking.networking,
                parameters: ["api_key": L10n.apiKey, "language": "en-US"],
                headers: ["Content-Type": "application/json", "Accept": "application/json"],
                method: RequestMethod.GET
            )
        )
    }

    var aboutFilmGatewayForImages: IMakeRequestGateway {
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

    // Cast

    var castFilmUsecase: ICastUsecase {
        return define(scope: .lazySingleton, init: CastUsecase(makeRequestGatewayCast: self.aboutFilmGateway))
    }

    // Info

    var detailFilmUsecase: IDetailsFilmUsecase {
        return define(scope: .lazySingleton, init: DetailsFilmUsecase(makeRequestGatewayFilmDetail: self.aboutFilmGateway))
    }

    var galleryFilmUsecase: IGalleryUsecase {
        return define(scope: .lazySingleton, init: GalleryUsecase(makeRequestGatewayGallery: self.aboutFilmGatewayForImages))
    }

    var similarUsecase: ISimilarFilmsUsecase {
        return define(init: SimilarFilmsUsecase(makeRequestGatewaySimilar: self.aboutFilmGatewayWithPaging))
    }

    // Review

    var reviewUsecase: IReviewUsecase {
        return define(scope: .lazySingleton, init: ReviewUsecase(makeRequestGatewayCast: self.aboutFilmGateway))
    }

}
