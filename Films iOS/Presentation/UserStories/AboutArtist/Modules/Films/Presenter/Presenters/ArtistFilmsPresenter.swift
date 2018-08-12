//
//  ArtistFilmsPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IArtistFilmsPresenter: class {
    func setArtistFilms()
}

final class ArtistFilmsPresenter: IArtistFilmsPresenter {

    private var castRouting: CastRoutingProtocolOutput
    private var artistFilmsUsecase: IArtistFilmsUsecase
    private var artistFilmsDataSource: IArtistFilmsDataSourceInput

    init(
        castRouting: CastRoutingProtocolOutput,
        artistFilmsUsecase: IArtistFilmsUsecase,
        artistFilmsDataSource: IArtistFilmsDataSourceInput
    ) {
        self.artistFilmsDataSource = artistFilmsDataSource
        self.artistFilmsUsecase = artistFilmsUsecase
        self.castRouting = castRouting
    }

    func setArtistFilms() {
        guard let castId = castRouting.selectArtistId else { fatalError("Cast id doesnt exist") }

        artistFilmsUsecase.getFilms(relativeURL: "/person/\(castId)/movie_credits").done { films in
            self.artistFilmsDataSource.add(artistFilms: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}
