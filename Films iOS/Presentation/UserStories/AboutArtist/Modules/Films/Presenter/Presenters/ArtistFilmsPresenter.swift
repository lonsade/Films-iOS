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
    var type: Int { get }
}

final class ArtistFilmsPresenter: IArtistFilmsPresenter {

    private var artistFilmsUsecase: IArtistFilmsUsecase
    private var artistFilmsDataSource: ArtistFilmsDataSourceInput
    private var router: ArtistFilmsRoutingInput
    private weak var aboutArtistPresenter: AboutArtistInput?

    init(
        artistFilmsUsecase: IArtistFilmsUsecase,
        artistFilmsDataSource: ArtistFilmsDataSourceInput,
        aboutArtistPresenter: AboutArtistInput,
        router: ArtistFilmsRoutingInput
    ) {
        self.artistFilmsDataSource = artistFilmsDataSource
        self.artistFilmsUsecase = artistFilmsUsecase
        self.aboutArtistPresenter = aboutArtistPresenter
        self.router = router
    }

    var id: Int {
        guard let filmId = aboutArtistPresenter?.id else {
            router.closeCurrentModule()
            assertionFailure("Film id doesnt exist")
            return 0
        }
        return filmId
    }
    var type: Int {
        guard let type = aboutArtistPresenter?.type else {
            router.closeCurrentModule()
            assertionFailure("Type of page doesnt exist")
            return 0
        }
        return type
    }

    func loadArtistFilms() {
        guard let artistId = aboutArtistPresenter?.id else {
            router.closeCurrentModule()
            return assertionFailure("Artist id doesnt exist")
        }

        let url = type == 0 ? "movie_credits" : "tv_credits"

        artistFilmsUsecase.getFilms(relativeURL: "/person/\(id)/\(url)").done { films in
            self.artistFilmsDataSource.load(base: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}
