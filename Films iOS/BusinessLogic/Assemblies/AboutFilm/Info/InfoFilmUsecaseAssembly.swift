//
//  AboutFilmUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class InfoFilmUsecaseAssembly: Assembly {

    lazy var infoFilmGatewayAssembly: InfoFilmGatewayAssembly = self.context.assembly()

    var detailFilmUsecaseAssembly: IDetailsFilmUsecase {
        return define(scope: .lazySingleton, init:
            DetailsFilmUsecase(makeRequestGatewayFilmDetail: self.infoFilmGatewayAssembly.detailGateway)
        )
    }

    var galleryFilmUsecaseAssembly: IGalleryUsecase {
        return define(scope: .lazySingleton, init:
            GalleryUsecase(makeRequestGatewayGallery: self.infoFilmGatewayAssembly.galleryGateway)
        )
    }

    var similarUsecaseAssembly: ISimilarFilmsUsecase {
        return define(scope: .lazySingleton, init:
            SimilarFilmsUsecase(makeRequestGatewaySimilar: self.infoFilmGatewayAssembly.similarGateway)
        )
    }

}
