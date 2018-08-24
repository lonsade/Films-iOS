//
//  ArtistFilmsPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IArtistFilmsPresenter: class {
    func loadArtistFilms()
}

final class ArtistFilmsPresenter: IArtistFilmsPresenter {

    private var artistFilmsUsecase: IArtistFilmsUsecase
    private var artistFilmsDataSource: ArtistFilmsDataSourceInput
    private var aboutArtistPresenter: AboutArtistInput

    init(
        artistFilmsUsecase: IArtistFilmsUsecase,
        artistFilmsDataSource: ArtistFilmsDataSourceInput,
        aboutArtistPresenter: AboutArtistInput
    ) {
        self.artistFilmsDataSource = artistFilmsDataSource
        self.artistFilmsUsecase = artistFilmsUsecase
        self.aboutArtistPresenter = aboutArtistPresenter
    }

    func loadArtistFilms() {
        guard let artistId = aboutArtistPresenter.id else { fatalError("Artist id doesnt exist") }

        artistFilmsUsecase.getFilms(relativeURL: "/person/\(artistId)/movie_credits").done { films in
            self.artistFilmsDataSource.load(base: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}
