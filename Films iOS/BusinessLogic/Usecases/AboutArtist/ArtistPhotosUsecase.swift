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
    func getPhotos(relativeURL: String) -> Promise<[ArtistPhoto]>
}

final class ArtistPhotosUsecase: IArtistPhotosUsecase {

    private var makeRequestGatewayPhotos: IMakeRequestGateway

    init(makeRequestGatewayPhotos: IMakeRequestGateway) {
        self.makeRequestGatewayPhotos = makeRequestGatewayPhotos
    }

    func getPhotos(relativeURL: String) -> Promise<[ArtistPhoto]> {
        return Promise<[ArtistPhoto]> { seal in
            makeRequestGatewayPhotos.getResults(relativeURL: relativeURL).done { (photos: ArtistPhotos) in
                seal.fulfill(photos.profiles)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
