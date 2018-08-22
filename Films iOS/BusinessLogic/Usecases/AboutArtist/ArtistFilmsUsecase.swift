//
//  ArtistFilmsUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol IArtistFilmsUsecase: class {
    func getFilms(relativeURL: String) -> Promise<[FilmCard]>
}

final class ArtistFilmsUsecase: IArtistFilmsUsecase {

    private var makeRequestGatewayArtistFilms: IMakeRequestGateway

    init(makeRequestGatewayArtistFilms: IMakeRequestGateway) {
        self.makeRequestGatewayArtistFilms = makeRequestGatewayArtistFilms
    }

    func getFilms(relativeURL: String) -> Promise<[FilmCard]> {
        return Promise<[FilmCard]> { seal in
            makeRequestGatewayArtistFilms.getResults(relativeURL: relativeURL, parameters: nil).done { (films: ArtistFilms) in
                seal.fulfill(films.cast)
            }.catch { error in
                    seal.reject(error)
            }
        }
    }
}
