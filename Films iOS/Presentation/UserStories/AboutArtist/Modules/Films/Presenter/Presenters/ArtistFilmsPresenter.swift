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

    private var artistFilmsUsecase: IArtistFilmsUsecase
    private var artistFilmsDataSource: BaseMoviesDataSourceInput

    init(
        artistFilmsUsecase: IArtistFilmsUsecase,
        artistFilmsDataSource: BaseMoviesDataSourceInput
    ) {
        self.artistFilmsDataSource = artistFilmsDataSource
        self.artistFilmsUsecase = artistFilmsUsecase
    }

    func setArtistFilms() {
//        guard let castId = castRouting.selectArtistId else { fatalError("Cast id doesnt exist") }

        let castId = 287

        artistFilmsUsecase.getFilms(relativeURL: "/person/\(castId)/movie_credits").done { films in
            self.artistFilmsDataSource.add(films: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}
