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
    private var router: CastRoutingInput
    private weak var aboutFilmPresenter: AboutFilmInput?

    init(
        castFilmUsecase: ICastUsecase,
        castFilmDataSource: ICastFilmDataSourceInput,
        aboutFilmPresenter: AboutFilmInput,
        router: CastRoutingInput
    ) {
        self.castFilmUsecase = castFilmUsecase
        self.castFilmDataSource = castFilmDataSource
        self.aboutFilmPresenter = aboutFilmPresenter
        self.router = router
    }

    func setCredits() {

        guard let filmId = aboutFilmPresenter?.id else {
            router.closeCurrentModule()
            return assertionFailure("Film id doesnt exist")
        }

        castFilmUsecase.getCast(relativeURL: "/movie/\(filmId)/credits").done { credits in
            self.castFilmDataSource.addCredits(credits: credits)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}
