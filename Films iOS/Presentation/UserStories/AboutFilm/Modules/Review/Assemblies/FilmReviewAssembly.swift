//
//  FilmReviewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class FilmReviewAssembly: Assembly {

    lazy var presenterAssembly = AboutFilmContainerAssembly.instance()

    lazy var usecaseAssembly = AboutFilmAssembly.instance()

    var reviewDataSource: IReviewDataSourceOutput & IReviewDataSourceInput {
        return define(init: ReviewDataSource())
    }

    var reviewDisplayManager: ReviewDisplayManager {
        return define(init: ReviewDisplayManager(reviewDataSource: self.reviewDataSource))
    }

    var routing: ReviewRoutingInput {
        return define(init: ReviewRouting())
    }

    var reviewPresenter: IReviewPresenter {
        return define(init:
            ReviewPresenter(
                reviewUsecase: self.usecaseAssembly.reviewUsecase,
                reviewDataSource: self.reviewDataSource,
                aboutFilmPresenter: self.presenterAssembly.aboutFilmPresenter,
                router: self.routing
            )
        )
    }

    func inject(into mvc: ReviewViewController) {
        defineInjection(into: mvc) {
            $0.presenter = self.reviewPresenter
            $0.reviewDisplayManager = self.reviewDisplayManager
            $0.router = self.routing
            return $0
        }
    }
}
