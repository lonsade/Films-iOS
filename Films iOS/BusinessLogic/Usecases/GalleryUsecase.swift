//
//  GalleryUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol IGalleryUsecase: class {
    func getGallery() -> Promise<[GalleryImage]>
}

final class GalleryUsecase: IGalleryUsecase {

    private var makeRequestGatewayGallery: IMakeRequestGateway

    init(makeRequestGatewayGallery: IMakeRequestGateway) {
        self.makeRequestGatewayGallery = makeRequestGatewayGallery
    }

    func getGallery() -> Promise<[GalleryImage]> {
        return Promise<[GalleryImage]> { seal in
            makeRequestGatewayGallery.getResults().done { (gallery: Gallery) in
                seal.fulfill(gallery.backdrops)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
