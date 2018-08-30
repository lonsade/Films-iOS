//
//  CastFilmPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol ICastFilmPresenter: ModuleInput {
    func setCredits(completion: @escaping Response)
    var type: Int { get }
}

final class CastFilmPresenter: ICastFilmPresenter {

    private var castFilmUsecase: ICastUsecase
    private var castFilmDataSource: ICastFilmDataSourceInput
    private var router: CastRoutingInput
    private weak var aboutFilmPresenter: AboutFilmInput?

    var id: Int {
        guard let filmId = aboutFilmPresenter?.id else {
            router.closeCurrentModule()
            assertionFailure("Film id doesnt exist")
            return 0
        }
        return filmId
    }
    var type: Int {
        guard let type = aboutFilmPresenter?.type else {
            router.closeCurrentModule()
            assertionFailure("Type of page doesnt exist")
            return 0
        }
        return type
    }

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

    func setCredits(completion: @escaping Response) {

        let url = type == 0 ? "movie" : "tv"

        castFilmUsecase.getCast(relativeURL: "/\(url)/\(id)/credits").done { credits in
            self.castFilmDataSource.addCredits(credits: credits)
            completion(nil)
        }
        .catch { error in
            completion(error)
        }
    }

}
