//
//  ArtistPhotosUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol IArtistPhotosUsecase: class {
    func getPhotos() -> Promise<[ArtistPhoto]>
}

final class ArtistPhotosUsecase: IArtistPhotosUsecase {

    private var makeRequestGatewayPhotos: IMakeRequestGateway

    init(makeRequestGatewayPhotos: IMakeRequestGateway) {
        self.makeRequestGatewayPhotos = makeRequestGatewayPhotos
    }

    func getPhotos() -> Promise<[ArtistPhoto]> {
        return Promise<[ArtistPhoto]> { seal in
            makeRequestGatewayPhotos.getResults().done { (photos: ArtistPhotos) in
                seal.fulfill(photos.profiles)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
