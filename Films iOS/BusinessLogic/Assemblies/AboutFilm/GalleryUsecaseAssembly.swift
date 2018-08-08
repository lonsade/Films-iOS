//
//  GalleryUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class GalleryUsecaseAssembly: Assembly {

    lazy var requestGalleryAssembly: MakeRequestGatewayGalleryAssembly = self.context.assembly()

    var galleryUsecase: IGalleryUsecase {
        return define(scope: .lazySingleton, init:
            GalleryUsecase(makeRequestGatewayGallery: self.requestGalleryAssembly.makeRequestGatewayGallery)
        )
    }

}
