//
//  CastFilmPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol ICastFilmPresenter: class {
    func setCredits()
}

final class CastFilmPresenter: ICastFilmPresenter {

    private var castFilmUsecase: ICastUsecase
    private var castFilmDataSource: ICastFilmDataSourceInput
    private var moviesRouting: MoviesRoutingOutput

    init(
        castFilmUsecase: ICastUsecase,
        castFilmDataSource: ICastFilmDataSourceInput,
        moviesRouting: MoviesRoutingOutput
    ) {
        self.castFilmUsecase = castFilmUsecase
        self.castFilmDataSource = castFilmDataSource
        self.moviesRouting = moviesRouting
    }

    func setCredits() {

        guard let filmId = moviesRouting.selectFilmId else { fatalError("Film id doesnt exist") }

        castFilmUsecase.getCast(relativeURL: "/movie/\(filmId)/credits").done { credits in
            self.castFilmDataSource.addCredits(credits: credits)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}
